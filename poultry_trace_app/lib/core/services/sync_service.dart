import 'dart:async';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/connectivity_service.dart';
import '../network/http_client.dart';
import '../storage/local_db.dart';

/// Provider para el servicio de sincronización
final syncServiceProvider = Provider((ref) => SyncService(
      ref.watch(connectivityServiceProvider),
      ref.watch(httpClientProvider),
    ));

/// Provider para el estado de sincronización
final syncStatusProvider = StateNotifierProvider<SyncStatusNotifier, SyncStatus>((ref) {
  return SyncStatusNotifier();
});

/// Provider del HttpClient
final httpClientProvider = Provider((ref) => throw UnimplementedError('Must be overridden'));

/// Estados posibles de sincronización
enum SyncState { idle, syncing, success, error }

/// Estado de sincronización
class SyncStatus {
  final SyncState state;
  final int pendingCount;
  final String? errorMessage;
  final DateTime? lastSyncAt;

  const SyncStatus({
    this.state = SyncState.idle,
    this.pendingCount = 0,
    this.errorMessage,
    this.lastSyncAt,
  });

  SyncStatus copyWith({
    SyncState? state,
    int? pendingCount,
    String? errorMessage,
    DateTime? lastSyncAt,
  }) {
    return SyncStatus(
      state: state ?? this.state,
      pendingCount: pendingCount ?? this.pendingCount,
      errorMessage: errorMessage,
      lastSyncAt: lastSyncAt ?? this.lastSyncAt,
    );
  }

  bool get isSyncing => state == SyncState.syncing;
  bool get hasPending => pendingCount > 0;
}

/// Notifier para el estado de sincronización
class SyncStatusNotifier extends StateNotifier<SyncStatus> {
  SyncStatusNotifier() : super(const SyncStatus());

  void setSyncing() {
    state = state.copyWith(state: SyncState.syncing);
  }

  void setSuccess(int remaining) {
    state = state.copyWith(
      state: SyncState.success,
      pendingCount: remaining,
      lastSyncAt: DateTime.now(),
    );
  }

  void setError(String message, int pending) {
    state = state.copyWith(
      state: SyncState.error,
      errorMessage: message,
      pendingCount: pending,
    );
  }

  void setIdle(int pending) {
    state = state.copyWith(
      state: SyncState.idle,
      pendingCount: pending,
    );
  }

  void updatePendingCount(int count) {
    state = state.copyWith(pendingCount: count);
  }
}

/// Service for syncing offline data with server
class SyncService {
  final ConnectivityService _connectivityService;
  final HttpClient _httpClient;
  
  bool _isSyncing = false;
  Timer? _autoSyncTimer;
  StreamSubscription? _connectivitySubscription;

  SyncService(this._connectivityService, this._httpClient) {
    _initAutoSync();
  }

  /// Initialize automatic sync when connectivity changes
  void _initAutoSync() {
    _connectivitySubscription = _connectivityService.connectionStream.listen((hasConnection) {
      if (hasConnection && !_isSyncing) {
        syncAll();
      }
    });

    // Sync periódico cada 5 minutos si hay conexión
    _autoSyncTimer = Timer.periodic(const Duration(minutes: 5), (_) async {
      final hasConnection = await _connectivityService.hasConnection();
      if (hasConnection && !_isSyncing) {
        syncAll();
      }
    });
  }

  /// Check if currently syncing
  bool get isSyncing => _isSyncing;

  /// Get pending operations count
  Future<int> getPendingCount() async {
    return LocalDb.syncQueueDao.getCount();
  }

  /// Sync all pending data
  Future<SyncResult> syncAll() async {
    if (_isSyncing) {
      return SyncResult(
        success: false,
        message: 'Ya hay una sincronización en progreso',
      );
    }

    final hasConnection = await _connectivityService.hasConnection();
    if (!hasConnection) {
      return SyncResult(
        success: false,
        message: 'Sin conexión a internet',
      );
    }

    _isSyncing = true;

    try {
      // 1. Obtener operaciones pendientes ordenadas por fecha
      final pendientes = await LocalDb.syncQueueDao.getPendientesConLimite();
      
      if (pendientes.isEmpty) {
        _isSyncing = false;
        return SyncResult(
          success: true,
          message: 'No hay datos pendientes',
          syncedItems: 0,
        );
      }

      // 2. Preparar batch de operaciones
      final operaciones = pendientes.map((op) => {
        'id': op.id,
        'operacion': op.operacion,
        'entidad': op.entidad,
        'entidad_id': op.entidadId,
        'payload': jsonDecode(op.payload),
        'created_at': op.createdAt.toIso8601String(),
      }).toList();

      // 3. Enviar batch al servidor
      final response = await _httpClient.post(
        '/api/sync',
        data: {'operaciones': operaciones},
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final procesados = List<String>.from(data['procesados'] ?? []);
        final errores = Map<String, String>.from(data['errores'] ?? {});

        // 4. Eliminar operaciones procesadas exitosamente
        if (procesados.isNotEmpty) {
          await LocalDb.syncQueueDao.removeProcessed(procesados);
        }

        // 5. Incrementar intentos de operaciones fallidas
        for (final entry in errores.entries) {
          await LocalDb.syncQueueDao.incrementarIntentos(entry.key, entry.value);
        }

        // 6. Marcar registros como sincronizados
        await _marcarSincronizados(procesados);

        _isSyncing = false;
        return SyncResult(
          success: true,
          message: 'Sincronización completada',
          syncedItems: procesados.length,
          errors: errores.isNotEmpty ? errores.values.toList() : null,
        );
      } else {
        _isSyncing = false;
        return SyncResult(
          success: false,
          message: 'Error del servidor: ${response.statusCode}',
        );
      }
    } catch (e) {
      _isSyncing = false;
      return SyncResult(
        success: false,
        message: 'Error durante la sincronización: ${e.toString()}',
      );
    }
  }

  /// Mark records as synchronized after successful sync
  Future<void> _marcarSincronizados(List<String> ids) async {
    // Aquí se marcarían los registros según su entidad
    // Por simplicidad, esto requeriría parsear el payload de sync_queue
    // para saber qué tabla actualizar
    await LocalDb.galponesDao.markMultipleAsSynchronized(ids);
  }

  /// Queue a CREATE operation
  Future<void> queueCreate({
    required String id,
    required String entidad,
    required String entidadId,
    required Map<String, dynamic> data,
  }) async {
    await LocalDb.syncQueueDao.addToQueue(
      id: id,
      operacion: 'CREATE',
      entidad: entidad,
      entidadId: entidadId,
      payload: data,
    );
  }

  /// Queue an UPDATE operation
  Future<void> queueUpdate({
    required String id,
    required String entidad,
    required String entidadId,
    required Map<String, dynamic> data,
  }) async {
    await LocalDb.syncQueueDao.addToQueue(
      id: id,
      operacion: 'UPDATE',
      entidad: entidad,
      entidadId: entidadId,
      payload: data,
    );
  }

  /// Queue a DELETE operation
  Future<void> queueDelete({
    required String id,
    required String entidad,
    required String entidadId,
  }) async {
    await LocalDb.syncQueueDao.addToQueue(
      id: id,
      operacion: 'DELETE',
      entidad: entidad,
      entidadId: entidadId,
      payload: {'id': entidadId, 'deleted_at': DateTime.now().toIso8601String()},
    );
  }

  /// Stream del conteo de pendientes
  Stream<int> watchPendingCount() {
    return LocalDb.syncQueueDao.watchCount();
  }

  /// Clear all pending operations
  Future<void> clearPending() async {
    await LocalDb.syncQueueDao.clearAll();
  }

  /// Dispose resources
  void dispose() {
    _autoSyncTimer?.cancel();
    _connectivitySubscription?.cancel();
  }
}

/// Result of a sync operation
class SyncResult {
  final bool success;
  final String message;
  final int syncedItems;
  final List<String>? errors;

  SyncResult({
    required this.success,
    required this.message,
    this.syncedItems = 0,
    this.errors,
  });

  @override
  String toString() => 'SyncResult(success: $success, message: $message, synced: $syncedItems)';
}
