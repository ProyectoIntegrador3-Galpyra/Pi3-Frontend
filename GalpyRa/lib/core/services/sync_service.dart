import 'dart:async';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/constants/api_endpoints.dart';
import '../../config/di/injector.dart';
import '../network/api_response_parser.dart';
import '../network/connectivity_service.dart';
import '../network/http_client.dart';
import '../storage/local_db.dart';
import '../storage/database/app_database.dart';

/// Provider para el servicio de sincronización
final syncServiceProvider = Provider((ref) => SyncService(
  getIt<ConnectivityService>(),
  getIt<HttpClient>(),
    ));

/// Provider para el estado de sincronización
final syncStatusProvider =
    StateNotifierProvider<SyncStatusNotifier, SyncStatus>((ref) {
  return SyncStatusNotifier();
});

/// Provider del HttpClient
final httpClientProvider = Provider((ref) => getIt<HttpClient>());

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
    _connectivitySubscription =
        _connectivityService.connectionStream.listen((hasConnection) {
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
      final operaciones = pendientes
          .map((op) => {
                'id': op.id,
                'operacion': op.operacion,
                'entidad': op.entidad,
                'entidad_id': op.entidadId,
                'payload': jsonDecode(op.payload),
                'created_at': op.createdAt.toIso8601String(),
              })
          .toList();

      // 3. Enviar batch al servidor
      final response = await _httpClient.post(
        ApiEndpoints.sync,
        data: {'operaciones': operaciones},
      );

      if (response.statusCode == 200 && ApiResponseParser.isSuccess(response.data)) {
        final data = ApiResponseParser.extractDataMap(response.data);
        final procesados = List<String>.from(data['procesadas'] ?? []);
        final fallidas = List<String>.from(data['fallidas'] ?? []);
        final detallesRaw = data['detalles'];

        final Map<String, String> errores = <String, String>{};
        if (detallesRaw is Map) {
          for (final entry in detallesRaw.entries) {
            errores[entry.key.toString()] = entry.value.toString();
          }
        } else if (detallesRaw is List) {
          for (final detail in detallesRaw) {
            final map = ApiResponseParser.asMap(detail);
            final id = (map['id'] ?? map['operacion_id'] ?? '').toString();
            final error =
                (map['error'] ?? map['mensaje'] ?? 'Operacion no procesada')
                    .toString();
            if (id.isNotEmpty) {
              errores[id] = error;
            }
          }
        }

        for (final failedId in fallidas) {
          errores.putIfAbsent(
              failedId, () => 'Operacion no procesada por el backend');
        }

        // 4. Eliminar operaciones procesadas exitosamente
        if (procesados.isNotEmpty) {
          await LocalDb.syncQueueDao.removeProcessed(procesados);
        }

        // 5. Incrementar intentos de operaciones fallidas
        for (final entry in errores.entries) {
          await LocalDb.syncQueueDao
              .incrementarIntentos(entry.key, entry.value);
        }

        // 6. Marcar registros como sincronizados
        final procesadasData = pendientes
          .where((item) => procesados.contains(item.id))
          .toList();
        await _marcarSincronizados(procesadasData);

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
          message: ApiResponseParser.extractMessage(
            response.data,
            fallback: 'Error del servidor: ${response.statusCode}',
          ),
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
  Future<void> _marcarSincronizados(
      List<SyncQueueTableData> operacionesProcesadas) async {
    final galponIds = <String>[];

    for (final op in operacionesProcesadas) {
      final entidad = op.entidad.toString().toLowerCase();
      if (entidad == 'galpon' || entidad == 'galpones') {
        galponIds.add(op.entidadId);
      }
    }

    if (galponIds.isNotEmpty) {
      await LocalDb.galponesDao.markMultipleAsSynchronized(galponIds);
    }
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
      payload: {
        'id': entidadId,
        'deleted_at': DateTime.now().toIso8601String()
      },
    );
  }

  /// Queue an UPSERT operation
  Future<void> queueUpsert({
    required String id,
    required String entidad,
    required String entidadId,
    required Map<String, dynamic> data,
  }) async {
    await LocalDb.syncQueueDao.addToQueue(
      id: id,
      operacion: 'UPSERT',
      entidad: entidad,
      entidadId: entidadId,
      payload: data,
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
  String toString() =>
      'SyncResult(success: $success, message: $message, synced: $syncedItems)';
}
