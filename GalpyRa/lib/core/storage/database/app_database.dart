import 'package:drift/drift.dart';
import 'app_database_connection.dart';

part 'app_database.g.dart';

// ========== TABLAS ==========

/// Tabla de Galpones
class GalponesTable extends Table {
  TextColumn get id => text()();
  TextColumn get nombre => text().withLength(min: 1, max: 100)();
  TextColumn get descripcion => text().nullable()();
  IntColumn get capacidadMaxima => integer()();
  IntColumn get cantidadActual => integer().withDefault(const Constant(0))();
  TextColumn get ubicacion => text().nullable()();
  BoolColumn get activo => boolean().withDefault(const Constant(true))();
  // Campos de control offline
  BoolColumn get sincronizado => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Tabla de Lotes de Aves
class LotesAvesTable extends Table {
  TextColumn get id => text()();
  TextColumn get galponId => text().references(GalponesTable, #id)();
  TextColumn get codigo => text().withLength(min: 1, max: 50)();
  IntColumn get cantidadInicial => integer()();
  IntColumn get cantidadActual => integer()();
  DateTimeColumn get fechaIngreso => dateTime()();
  TextColumn get raza => text().nullable()();
  IntColumn get edadSemanas => integer().withDefault(const Constant(0))();
  TextColumn get estado => text().withDefault(const Constant('activo'))();
  // Campos de control offline
  BoolColumn get sincronizado => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Tabla de Producción de Huevos
class ProduccionHuevosTable extends Table {
  TextColumn get id => text()();
  TextColumn get galponId => text().references(GalponesTable, #id)();
  TextColumn get loteId => text().nullable()();
  DateTimeColumn get fecha => dateTime()();
  IntColumn get cantidadTotal => integer()();
  IntColumn get huevosRotos => integer().withDefault(const Constant(0))();
  IntColumn get huevosSucios => integer().withDefault(const Constant(0))();
  IntColumn get huevosGrandeAA => integer().withDefault(const Constant(0))();
  IntColumn get huevosGrandeA => integer().withDefault(const Constant(0))();
  IntColumn get huevosMediano => integer().withDefault(const Constant(0))();
  IntColumn get huevosPequeno => integer().withDefault(const Constant(0))();
  RealColumn get porcentajePostura => real().withDefault(const Constant(0.0))();
  TextColumn get observaciones => text().nullable()();
  // Campos de control offline
  BoolColumn get sincronizado => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Tabla de Eventos Sanitarios
class EventosSanitariosTable extends Table {
  TextColumn get id => text()();
  TextColumn get galponId => text().references(GalponesTable, #id)();
  TextColumn get loteId => text().nullable()();
  TextColumn get tipo => text()(); // vacunacion, tratamiento, revision, otro
  DateTimeColumn get fecha => dateTime()();
  TextColumn get descripcion => text()();
  TextColumn get medicamento => text().nullable()();
  TextColumn get dosis => text().nullable()();
  TextColumn get veterinario => text().nullable()();
  IntColumn get avesAfectadas => integer().withDefault(const Constant(0))();
  TextColumn get observaciones => text().nullable()();
  // Campos de control offline
  BoolColumn get sincronizado => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Tabla de Alimentación
class AlimentacionTable extends Table {
  TextColumn get id => text()();
  TextColumn get galponId => text().references(GalponesTable, #id)();
  TextColumn get loteId => text().nullable()();
  DateTimeColumn get fecha => dateTime()();
  TextColumn get tipoAlimento => text()();
  RealColumn get cantidadKg => real()();
  TextColumn get loteAlimento => text().nullable()();
  RealColumn get costoUnitario => real().withDefault(const Constant(0.0))();
  TextColumn get observaciones => text().nullable()();
  // Campos de control offline
  BoolColumn get sincronizado => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Tabla de Mortalidad
class MortalidadTable extends Table {
  TextColumn get id => text()();
  TextColumn get galponId => text().references(GalponesTable, #id)();
  TextColumn get loteId => text().nullable()();
  DateTimeColumn get fecha => dateTime()();
  IntColumn get cantidad => integer()();
  TextColumn get causa => text()();
  TextColumn get observaciones => text().nullable()();
  // Campos de control offline
  BoolColumn get sincronizado => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Tabla de Inventario por Foto
class InventarioFotoTable extends Table {
  TextColumn get id => text()();
  TextColumn get galponId => text().references(GalponesTable, #id)();
  TextColumn get loteId => text().nullable()();
  DateTimeColumn get fecha => dateTime()();
  TextColumn get imagenPath => text()();
  IntColumn get conteoAutomatico => integer().withDefault(const Constant(0))();
  IntColumn get conteoManual => integer().withDefault(const Constant(0))();
  IntColumn get conteoFinal => integer()();
  TextColumn get estado => text().withDefault(const Constant('pendiente'))();
  TextColumn get observaciones => text().nullable()();
  // Campos de control offline
  BoolColumn get sincronizado => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Tabla de Cola de Sincronización
class SyncQueueTable extends Table {
  TextColumn get id => text()();
  TextColumn get operacion => text()(); // CREATE, UPDATE, DELETE, UPSERT
  TextColumn get entidad => text()(); // nombre de la tabla
  TextColumn get entidadId => text()(); // ID del registro
  TextColumn get payload => text()(); // JSON completo del registro
  IntColumn get intentos => integer().withDefault(const Constant(0))();
  TextColumn get error => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Tabla de Usuarios (cache local)
class UsuariosTable extends Table {
  TextColumn get id => text()();
  TextColumn get email => text()();
  TextColumn get nombre => text()();
  TextColumn get rol => text()();
  TextColumn get telefono => text().nullable()();
  BoolColumn get activo => boolean().withDefault(const Constant(true))();
  DateTimeColumn get ultimoAcceso => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// ========== DATABASE ==========

@DriftDatabase(tables: [
  GalponesTable,
  LotesAvesTable,
  ProduccionHuevosTable,
  EventosSanitariosTable,
  AlimentacionTable,
  MortalidadTable,
  InventarioFotoTable,
  SyncQueueTable,
  UsuariosTable,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Futuras migraciones aquí
      },
    );
  }
}
