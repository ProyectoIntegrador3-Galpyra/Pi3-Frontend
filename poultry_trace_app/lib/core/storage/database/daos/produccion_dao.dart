import 'package:drift/drift.dart';
import '../app_database.dart';

part 'produccion_dao.g.dart';

@DriftAccessor(tables: [ProduccionHuevosTable])
class ProduccionDao extends DatabaseAccessor<AppDatabase> with _$ProduccionDaoMixin {
  ProduccionDao(super.db);

  /// Obtener historial de producción por galpon
  Future<List<ProduccionHuevosTableData>> getByGalpon(String galponId, {int limit = 30}) {
    return (select(produccionHuevosTable)
          ..where((t) => t.galponId.equals(galponId))
          ..where((t) => t.deletedAt.isNull())
          ..orderBy([(t) => OrderingTerm.desc(t.fecha)])
          ..limit(limit))
        .get();
  }

  /// Obtener producción por rango de fechas
  Future<List<ProduccionHuevosTableData>> getByDateRange(
    String galponId,
    DateTime start,
    DateTime end,
  ) {
    return (select(produccionHuevosTable)
          ..where((t) => t.galponId.equals(galponId))
          ..where((t) => t.fecha.isBetweenValues(start, end))
          ..where((t) => t.deletedAt.isNull())
          ..orderBy([(t) => OrderingTerm.desc(t.fecha)]))
        .get();
  }

  /// Obtener producción por ID
  Future<ProduccionHuevosTableData?> getById(String id) {
    return (select(produccionHuevosTable)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  /// Insertar registro de producción
  Future<int> insertProduccion(ProduccionHuevosTableCompanion produccion) {
    return into(produccionHuevosTable).insert(produccion);
  }

  /// Actualizar registro
  Future<bool> updateProduccion(ProduccionHuevosTableCompanion produccion, String id) {
    return (update(produccionHuevosTable)..where((t) => t.id.equals(id)))
        .write(produccion)
        .then((rows) => rows > 0);
  }

  /// Soft delete
  Future<bool> softDelete(String id) {
    return (update(produccionHuevosTable)..where((t) => t.id.equals(id))).write(
      ProduccionHuevosTableCompanion(
        deletedAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
        sincronizado: const Value(false),
      ),
    ).then((rows) => rows > 0);
  }

  /// Obtener registros no sincronizados
  Future<List<ProduccionHuevosTableData>> getUnsynchronized() {
    return (select(produccionHuevosTable)..where((t) => t.sincronizado.equals(false))).get();
  }

  /// Marcar como sincronizado
  Future<bool> markAsSynchronized(String id) {
    return (update(produccionHuevosTable)..where((t) => t.id.equals(id))).write(
      const ProduccionHuevosTableCompanion(sincronizado: Value(true)),
    ).then((rows) => rows > 0);
  }

  /// Obtener resumen de producción
  Future<Map<String, dynamic>> getResumen(String galponId, int dias) async {
    final desde = DateTime.now().subtract(Duration(days: dias));
    final registros = await (select(produccionHuevosTable)
          ..where((t) => t.galponId.equals(galponId))
          ..where((t) => t.fecha.isBiggerOrEqualValue(desde))
          ..where((t) => t.deletedAt.isNull()))
        .get();

    int totalHuevos = 0;
    int totalRotos = 0;
    int totalSucios = 0;

    for (final r in registros) {
      totalHuevos += r.cantidadTotal;
      totalRotos += r.huevosRotos;
      totalSucios += r.huevosSucios;
    }

    return {
      'totalHuevos': totalHuevos,
      'totalRotos': totalRotos,
      'totalSucios': totalSucios,
      'promediodiario': registros.isNotEmpty ? totalHuevos / registros.length : 0,
      'diasRegistrados': registros.length,
    };
  }

  /// Stream para reactividad
  Stream<List<ProduccionHuevosTableData>> watchByGalpon(String galponId) {
    return (select(produccionHuevosTable)
          ..where((t) => t.galponId.equals(galponId))
          ..where((t) => t.deletedAt.isNull())
          ..orderBy([(t) => OrderingTerm.desc(t.fecha)])
          ..limit(30))
        .watch();
  }
}
