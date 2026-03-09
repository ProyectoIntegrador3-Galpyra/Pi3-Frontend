import 'dart:convert';
import 'package:drift/drift.dart';
import '../app_database.dart';

part 'sync_queue_dao.g.dart';

@DriftAccessor(tables: [SyncQueueTable])
class SyncQueueDao extends DatabaseAccessor<AppDatabase> with _$SyncQueueDaoMixin {
  SyncQueueDao(super.db);

  /// Obtener todas las operaciones pendientes ordenadas por fecha
  Future<List<SyncQueueTableData>> getPendientes() {
    return (select(syncQueueTable)..orderBy([(t) => OrderingTerm.asc(t.createdAt)])).get();
  }

  /// Obtener operaciones pendientes con límite de intentos
  Future<List<SyncQueueTableData>> getPendientesConLimite({int maxIntentos = 5}) {
    return (select(syncQueueTable)
          ..where((t) => t.intentos.isSmallerThanValue(maxIntentos))
          ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
        .get();
  }

  /// Agregar operación a la cola
  Future<int> addToQueue({
    required String id,
    required String operacion,
    required String entidad,
    required String entidadId,
    required Map<String, dynamic> payload,
  }) {
    return into(syncQueueTable).insert(
      SyncQueueTableCompanion.insert(
        id: id,
        operacion: operacion,
        entidad: entidad,
        entidadId: entidadId,
        payload: jsonEncode(payload),
        createdAt: DateTime.now(),
      ),
    );
  }

  /// Eliminar operación de la cola
  Future<int> removeFromQueue(String id) {
    return (delete(syncQueueTable)..where((t) => t.id.equals(id))).go();
  }

  /// Eliminar múltiples operaciones procesadas
  Future<void> removeProcessed(List<String> ids) async {
    await (delete(syncQueueTable)..where((t) => t.id.isIn(ids))).go();
  }

  /// Incrementar intentos y guardar error
  Future<bool> incrementarIntentos(String id, String? error) {
    return customUpdate(
      'UPDATE sync_queue_table SET intentos = intentos + 1, error = ? WHERE id = ?',
      variables: [Variable(error), Variable(id)],
      updates: {syncQueueTable},
    ).then((rows) => rows > 0);
  }

  /// Obtener conteo de operaciones pendientes
  Future<int> getCount() async {
    final result = await (selectOnly(syncQueueTable)..addColumns([syncQueueTable.id.count()])).getSingle();
    return result.read(syncQueueTable.id.count()) ?? 0;
  }

  /// Obtener conteo por entidad
  Future<Map<String, int>> getCountByEntidad() async {
    final results = await (select(syncQueueTable)).get();
    final Map<String, int> counts = {};
    
    for (final r in results) {
      counts[r.entidad] = (counts[r.entidad] ?? 0) + 1;
    }
    
    return counts;
  }

  /// Limpiar toda la cola
  Future<int> clearAll() {
    return delete(syncQueueTable).go();
  }

  /// Limpiar operaciones con muchos intentos fallidos
  Future<int> clearFailed({int maxIntentos = 5}) {
    return (delete(syncQueueTable)..where((t) => t.intentos.isBiggerOrEqualValue(maxIntentos))).go();
  }

  /// Stream del conteo para UI
  Stream<int> watchCount() {
    return (selectOnly(syncQueueTable)..addColumns([syncQueueTable.id.count()]))
        .watchSingle()
        .map((row) => row.read(syncQueueTable.id.count()) ?? 0);
  }

  /// Verificar si hay operaciones pendientes
  Future<bool> hasPending() async {
    final count = await getCount();
    return count > 0;
  }
}
