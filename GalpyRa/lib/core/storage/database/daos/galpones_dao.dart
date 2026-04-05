import 'package:drift/drift.dart';
import '../app_database.dart';

part 'galpones_dao.g.dart';

@DriftAccessor(tables: [GalponesTable])
class GalponesDao extends DatabaseAccessor<AppDatabase> with _$GalponesDaoMixin {
  GalponesDao(super.db);

  /// Obtener todos los galpones activos
  Future<List<GalponesTableData>> getAllActive() {
    return (select(galponesTable)
          ..where((t) => t.deletedAt.isNull())
          ..where((t) => t.activo.equals(true))
          ..orderBy([(t) => OrderingTerm.asc(t.nombre)]))
        .get();
  }

  /// Obtener galpon por ID
  Future<GalponesTableData?> getById(String id) {
    return (select(galponesTable)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  /// Insertar galpon
  Future<int> insertGalpon(GalponesTableCompanion galpon) {
    return into(galponesTable).insert(galpon);
  }

  /// Actualizar galpon
  Future<bool> updateGalpon(GalponesTableCompanion galpon, String id) {
    return (update(galponesTable)..where((t) => t.id.equals(id))).write(galpon).then((rows) => rows > 0);
  }

  /// Soft delete
  Future<bool> softDelete(String id) {
    return (update(galponesTable)..where((t) => t.id.equals(id))).write(
      GalponesTableCompanion(
        deletedAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
        sincronizado: const Value(false),
      ),
    ).then((rows) => rows > 0);
  }

  /// Obtener registros no sincronizados
  Future<List<GalponesTableData>> getUnsynchronized() {
    return (select(galponesTable)..where((t) => t.sincronizado.equals(false))).get();
  }

  /// Marcar como sincronizado
  Future<bool> markAsSynchronized(String id) {
    return (update(galponesTable)..where((t) => t.id.equals(id))).write(
      const GalponesTableCompanion(sincronizado: Value(true)),
    ).then((rows) => rows > 0);
  }

  /// Marcar múltiples como sincronizados
  Future<void> markMultipleAsSynchronized(List<String> ids) async {
    await (update(galponesTable)..where((t) => t.id.isIn(ids))).write(
      const GalponesTableCompanion(sincronizado: Value(true)),
    );
  }

  /// Stream de galpones para reactividad
  Stream<List<GalponesTableData>> watchAllActive() {
    return (select(galponesTable)
          ..where((t) => t.deletedAt.isNull())
          ..where((t) => t.activo.equals(true))
          ..orderBy([(t) => OrderingTerm.asc(t.nombre)]))
        .watch();
  }
}
