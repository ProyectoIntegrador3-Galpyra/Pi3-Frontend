import 'package:drift/drift.dart';
import '../app_database.dart';

part 'sanidad_dao.g.dart';

@DriftAccessor(tables: [EventosSanitariosTable])
class SanidadDao extends DatabaseAccessor<AppDatabase> with _$SanidadDaoMixin {
  SanidadDao(super.db);

  /// Obtener historial por galpon
  Future<List<EventosSanitariosTableData>> getByGalpon(String galponId, {int limit = 50}) {
    return (select(eventosSanitariosTable)
          ..where((t) => t.galponId.equals(galponId))
          ..where((t) => t.deletedAt.isNull())
          ..orderBy([(t) => OrderingTerm.desc(t.fecha)])
          ..limit(limit))
        .get();
  }

  /// Obtener por tipo
  Future<List<EventosSanitariosTableData>> getByTipo(String galponId, String tipo) {
    return (select(eventosSanitariosTable)
          ..where((t) => t.galponId.equals(galponId))
          ..where((t) => t.tipo.equals(tipo))
          ..where((t) => t.deletedAt.isNull())
          ..orderBy([(t) => OrderingTerm.desc(t.fecha)]))
        .get();
  }

  /// Obtener por ID
  Future<EventosSanitariosTableData?> getById(String id) {
    return (select(eventosSanitariosTable)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  /// Insertar evento
  Future<int> insertEvento(EventosSanitariosTableCompanion evento) {
    return into(eventosSanitariosTable).insert(evento);
  }

  /// Actualizar evento
  Future<bool> updateEvento(EventosSanitariosTableCompanion evento, String id) {
    return (update(eventosSanitariosTable)..where((t) => t.id.equals(id)))
        .write(evento)
        .then((rows) => rows > 0);
  }

  /// Soft delete
  Future<bool> softDelete(String id) {
    return (update(eventosSanitariosTable)..where((t) => t.id.equals(id))).write(
      EventosSanitariosTableCompanion(
        deletedAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
        sincronizado: const Value(false),
      ),
    ).then((rows) => rows > 0);
  }

  /// Obtener no sincronizados
  Future<List<EventosSanitariosTableData>> getUnsynchronized() {
    return (select(eventosSanitariosTable)..where((t) => t.sincronizado.equals(false))).get();
  }

  /// Marcar como sincronizado
  Future<bool> markAsSynchronized(String id) {
    return (update(eventosSanitariosTable)..where((t) => t.id.equals(id))).write(
      const EventosSanitariosTableCompanion(sincronizado: Value(true)),
    ).then((rows) => rows > 0);
  }

  /// Stream para reactividad
  Stream<List<EventosSanitariosTableData>> watchByGalpon(String galponId) {
    return (select(eventosSanitariosTable)
          ..where((t) => t.galponId.equals(galponId))
          ..where((t) => t.deletedAt.isNull())
          ..orderBy([(t) => OrderingTerm.desc(t.fecha)])
          ..limit(50))
        .watch();
  }
}
