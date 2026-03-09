// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $GalponesTableTable extends GalponesTable
    with TableInfo<$GalponesTableTable, GalponesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GalponesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _descripcionMeta =
      const VerificationMeta('descripcion');
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
      'descripcion', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _capacidadMaximaMeta =
      const VerificationMeta('capacidadMaxima');
  @override
  late final GeneratedColumn<int> capacidadMaxima = GeneratedColumn<int>(
      'capacidad_maxima', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _cantidadActualMeta =
      const VerificationMeta('cantidadActual');
  @override
  late final GeneratedColumn<int> cantidadActual = GeneratedColumn<int>(
      'cantidad_actual', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _ubicacionMeta =
      const VerificationMeta('ubicacion');
  @override
  late final GeneratedColumn<String> ubicacion = GeneratedColumn<String>(
      'ubicacion', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _activoMeta = const VerificationMeta('activo');
  @override
  late final GeneratedColumn<bool> activo = GeneratedColumn<bool>(
      'activo', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("activo" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _sincronizadoMeta =
      const VerificationMeta('sincronizado');
  @override
  late final GeneratedColumn<bool> sincronizado = GeneratedColumn<bool>(
      'sincronizado', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("sincronizado" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        nombre,
        descripcion,
        capacidadMaxima,
        cantidadActual,
        ubicacion,
        activo,
        sincronizado,
        createdAt,
        updatedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'galpones_table';
  @override
  VerificationContext validateIntegrity(Insertable<GalponesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
          _descripcionMeta,
          descripcion.isAcceptableOrUnknown(
              data['descripcion']!, _descripcionMeta));
    }
    if (data.containsKey('capacidad_maxima')) {
      context.handle(
          _capacidadMaximaMeta,
          capacidadMaxima.isAcceptableOrUnknown(
              data['capacidad_maxima']!, _capacidadMaximaMeta));
    } else if (isInserting) {
      context.missing(_capacidadMaximaMeta);
    }
    if (data.containsKey('cantidad_actual')) {
      context.handle(
          _cantidadActualMeta,
          cantidadActual.isAcceptableOrUnknown(
              data['cantidad_actual']!, _cantidadActualMeta));
    }
    if (data.containsKey('ubicacion')) {
      context.handle(_ubicacionMeta,
          ubicacion.isAcceptableOrUnknown(data['ubicacion']!, _ubicacionMeta));
    }
    if (data.containsKey('activo')) {
      context.handle(_activoMeta,
          activo.isAcceptableOrUnknown(data['activo']!, _activoMeta));
    }
    if (data.containsKey('sincronizado')) {
      context.handle(
          _sincronizadoMeta,
          sincronizado.isAcceptableOrUnknown(
              data['sincronizado']!, _sincronizadoMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GalponesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GalponesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre'])!,
      descripcion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descripcion']),
      capacidadMaxima: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}capacidad_maxima'])!,
      cantidadActual: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cantidad_actual'])!,
      ubicacion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ubicacion']),
      activo: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}activo'])!,
      sincronizado: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}sincronizado'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $GalponesTableTable createAlias(String alias) {
    return $GalponesTableTable(attachedDatabase, alias);
  }
}

class GalponesTableData extends DataClass
    implements Insertable<GalponesTableData> {
  final String id;
  final String nombre;
  final String? descripcion;
  final int capacidadMaxima;
  final int cantidadActual;
  final String? ubicacion;
  final bool activo;
  final bool sincronizado;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const GalponesTableData(
      {required this.id,
      required this.nombre,
      this.descripcion,
      required this.capacidadMaxima,
      required this.cantidadActual,
      this.ubicacion,
      required this.activo,
      required this.sincronizado,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['nombre'] = Variable<String>(nombre);
    if (!nullToAbsent || descripcion != null) {
      map['descripcion'] = Variable<String>(descripcion);
    }
    map['capacidad_maxima'] = Variable<int>(capacidadMaxima);
    map['cantidad_actual'] = Variable<int>(cantidadActual);
    if (!nullToAbsent || ubicacion != null) {
      map['ubicacion'] = Variable<String>(ubicacion);
    }
    map['activo'] = Variable<bool>(activo);
    map['sincronizado'] = Variable<bool>(sincronizado);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  GalponesTableCompanion toCompanion(bool nullToAbsent) {
    return GalponesTableCompanion(
      id: Value(id),
      nombre: Value(nombre),
      descripcion: descripcion == null && nullToAbsent
          ? const Value.absent()
          : Value(descripcion),
      capacidadMaxima: Value(capacidadMaxima),
      cantidadActual: Value(cantidadActual),
      ubicacion: ubicacion == null && nullToAbsent
          ? const Value.absent()
          : Value(ubicacion),
      activo: Value(activo),
      sincronizado: Value(sincronizado),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory GalponesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GalponesTableData(
      id: serializer.fromJson<String>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      descripcion: serializer.fromJson<String?>(json['descripcion']),
      capacidadMaxima: serializer.fromJson<int>(json['capacidadMaxima']),
      cantidadActual: serializer.fromJson<int>(json['cantidadActual']),
      ubicacion: serializer.fromJson<String?>(json['ubicacion']),
      activo: serializer.fromJson<bool>(json['activo']),
      sincronizado: serializer.fromJson<bool>(json['sincronizado']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nombre': serializer.toJson<String>(nombre),
      'descripcion': serializer.toJson<String?>(descripcion),
      'capacidadMaxima': serializer.toJson<int>(capacidadMaxima),
      'cantidadActual': serializer.toJson<int>(cantidadActual),
      'ubicacion': serializer.toJson<String?>(ubicacion),
      'activo': serializer.toJson<bool>(activo),
      'sincronizado': serializer.toJson<bool>(sincronizado),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  GalponesTableData copyWith(
          {String? id,
          String? nombre,
          Value<String?> descripcion = const Value.absent(),
          int? capacidadMaxima,
          int? cantidadActual,
          Value<String?> ubicacion = const Value.absent(),
          bool? activo,
          bool? sincronizado,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      GalponesTableData(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        descripcion: descripcion.present ? descripcion.value : this.descripcion,
        capacidadMaxima: capacidadMaxima ?? this.capacidadMaxima,
        cantidadActual: cantidadActual ?? this.cantidadActual,
        ubicacion: ubicacion.present ? ubicacion.value : this.ubicacion,
        activo: activo ?? this.activo,
        sincronizado: sincronizado ?? this.sincronizado,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  GalponesTableData copyWithCompanion(GalponesTableCompanion data) {
    return GalponesTableData(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      descripcion:
          data.descripcion.present ? data.descripcion.value : this.descripcion,
      capacidadMaxima: data.capacidadMaxima.present
          ? data.capacidadMaxima.value
          : this.capacidadMaxima,
      cantidadActual: data.cantidadActual.present
          ? data.cantidadActual.value
          : this.cantidadActual,
      ubicacion: data.ubicacion.present ? data.ubicacion.value : this.ubicacion,
      activo: data.activo.present ? data.activo.value : this.activo,
      sincronizado: data.sincronizado.present
          ? data.sincronizado.value
          : this.sincronizado,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GalponesTableData(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('capacidadMaxima: $capacidadMaxima, ')
          ..write('cantidadActual: $cantidadActual, ')
          ..write('ubicacion: $ubicacion, ')
          ..write('activo: $activo, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      nombre,
      descripcion,
      capacidadMaxima,
      cantidadActual,
      ubicacion,
      activo,
      sincronizado,
      createdAt,
      updatedAt,
      deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GalponesTableData &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.descripcion == this.descripcion &&
          other.capacidadMaxima == this.capacidadMaxima &&
          other.cantidadActual == this.cantidadActual &&
          other.ubicacion == this.ubicacion &&
          other.activo == this.activo &&
          other.sincronizado == this.sincronizado &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class GalponesTableCompanion extends UpdateCompanion<GalponesTableData> {
  final Value<String> id;
  final Value<String> nombre;
  final Value<String?> descripcion;
  final Value<int> capacidadMaxima;
  final Value<int> cantidadActual;
  final Value<String?> ubicacion;
  final Value<bool> activo;
  final Value<bool> sincronizado;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const GalponesTableCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.capacidadMaxima = const Value.absent(),
    this.cantidadActual = const Value.absent(),
    this.ubicacion = const Value.absent(),
    this.activo = const Value.absent(),
    this.sincronizado = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GalponesTableCompanion.insert({
    required String id,
    required String nombre,
    this.descripcion = const Value.absent(),
    required int capacidadMaxima,
    this.cantidadActual = const Value.absent(),
    this.ubicacion = const Value.absent(),
    this.activo = const Value.absent(),
    this.sincronizado = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        nombre = Value(nombre),
        capacidadMaxima = Value(capacidadMaxima),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<GalponesTableData> custom({
    Expression<String>? id,
    Expression<String>? nombre,
    Expression<String>? descripcion,
    Expression<int>? capacidadMaxima,
    Expression<int>? cantidadActual,
    Expression<String>? ubicacion,
    Expression<bool>? activo,
    Expression<bool>? sincronizado,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (descripcion != null) 'descripcion': descripcion,
      if (capacidadMaxima != null) 'capacidad_maxima': capacidadMaxima,
      if (cantidadActual != null) 'cantidad_actual': cantidadActual,
      if (ubicacion != null) 'ubicacion': ubicacion,
      if (activo != null) 'activo': activo,
      if (sincronizado != null) 'sincronizado': sincronizado,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GalponesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? nombre,
      Value<String?>? descripcion,
      Value<int>? capacidadMaxima,
      Value<int>? cantidadActual,
      Value<String?>? ubicacion,
      Value<bool>? activo,
      Value<bool>? sincronizado,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<int>? rowid}) {
    return GalponesTableCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      capacidadMaxima: capacidadMaxima ?? this.capacidadMaxima,
      cantidadActual: cantidadActual ?? this.cantidadActual,
      ubicacion: ubicacion ?? this.ubicacion,
      activo: activo ?? this.activo,
      sincronizado: sincronizado ?? this.sincronizado,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (capacidadMaxima.present) {
      map['capacidad_maxima'] = Variable<int>(capacidadMaxima.value);
    }
    if (cantidadActual.present) {
      map['cantidad_actual'] = Variable<int>(cantidadActual.value);
    }
    if (ubicacion.present) {
      map['ubicacion'] = Variable<String>(ubicacion.value);
    }
    if (activo.present) {
      map['activo'] = Variable<bool>(activo.value);
    }
    if (sincronizado.present) {
      map['sincronizado'] = Variable<bool>(sincronizado.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GalponesTableCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('capacidadMaxima: $capacidadMaxima, ')
          ..write('cantidadActual: $cantidadActual, ')
          ..write('ubicacion: $ubicacion, ')
          ..write('activo: $activo, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LotesAvesTableTable extends LotesAvesTable
    with TableInfo<$LotesAvesTableTable, LotesAvesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LotesAvesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _galponIdMeta =
      const VerificationMeta('galponId');
  @override
  late final GeneratedColumn<String> galponId = GeneratedColumn<String>(
      'galpon_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES galpones_table (id)'));
  static const VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<String> codigo = GeneratedColumn<String>(
      'codigo', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _cantidadInicialMeta =
      const VerificationMeta('cantidadInicial');
  @override
  late final GeneratedColumn<int> cantidadInicial = GeneratedColumn<int>(
      'cantidad_inicial', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _cantidadActualMeta =
      const VerificationMeta('cantidadActual');
  @override
  late final GeneratedColumn<int> cantidadActual = GeneratedColumn<int>(
      'cantidad_actual', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _fechaIngresoMeta =
      const VerificationMeta('fechaIngreso');
  @override
  late final GeneratedColumn<DateTime> fechaIngreso = GeneratedColumn<DateTime>(
      'fecha_ingreso', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _razaMeta = const VerificationMeta('raza');
  @override
  late final GeneratedColumn<String> raza = GeneratedColumn<String>(
      'raza', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _edadSemanasMeta =
      const VerificationMeta('edadSemanas');
  @override
  late final GeneratedColumn<int> edadSemanas = GeneratedColumn<int>(
      'edad_semanas', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
      'estado', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('activo'));
  static const VerificationMeta _sincronizadoMeta =
      const VerificationMeta('sincronizado');
  @override
  late final GeneratedColumn<bool> sincronizado = GeneratedColumn<bool>(
      'sincronizado', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("sincronizado" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        galponId,
        codigo,
        cantidadInicial,
        cantidadActual,
        fechaIngreso,
        raza,
        edadSemanas,
        estado,
        sincronizado,
        createdAt,
        updatedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lotes_aves_table';
  @override
  VerificationContext validateIntegrity(Insertable<LotesAvesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('galpon_id')) {
      context.handle(_galponIdMeta,
          galponId.isAcceptableOrUnknown(data['galpon_id']!, _galponIdMeta));
    } else if (isInserting) {
      context.missing(_galponIdMeta);
    }
    if (data.containsKey('codigo')) {
      context.handle(_codigoMeta,
          codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta));
    } else if (isInserting) {
      context.missing(_codigoMeta);
    }
    if (data.containsKey('cantidad_inicial')) {
      context.handle(
          _cantidadInicialMeta,
          cantidadInicial.isAcceptableOrUnknown(
              data['cantidad_inicial']!, _cantidadInicialMeta));
    } else if (isInserting) {
      context.missing(_cantidadInicialMeta);
    }
    if (data.containsKey('cantidad_actual')) {
      context.handle(
          _cantidadActualMeta,
          cantidadActual.isAcceptableOrUnknown(
              data['cantidad_actual']!, _cantidadActualMeta));
    } else if (isInserting) {
      context.missing(_cantidadActualMeta);
    }
    if (data.containsKey('fecha_ingreso')) {
      context.handle(
          _fechaIngresoMeta,
          fechaIngreso.isAcceptableOrUnknown(
              data['fecha_ingreso']!, _fechaIngresoMeta));
    } else if (isInserting) {
      context.missing(_fechaIngresoMeta);
    }
    if (data.containsKey('raza')) {
      context.handle(
          _razaMeta, raza.isAcceptableOrUnknown(data['raza']!, _razaMeta));
    }
    if (data.containsKey('edad_semanas')) {
      context.handle(
          _edadSemanasMeta,
          edadSemanas.isAcceptableOrUnknown(
              data['edad_semanas']!, _edadSemanasMeta));
    }
    if (data.containsKey('estado')) {
      context.handle(_estadoMeta,
          estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta));
    }
    if (data.containsKey('sincronizado')) {
      context.handle(
          _sincronizadoMeta,
          sincronizado.isAcceptableOrUnknown(
              data['sincronizado']!, _sincronizadoMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LotesAvesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LotesAvesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      galponId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}galpon_id'])!,
      codigo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}codigo'])!,
      cantidadInicial: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cantidad_inicial'])!,
      cantidadActual: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cantidad_actual'])!,
      fechaIngreso: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}fecha_ingreso'])!,
      raza: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}raza']),
      edadSemanas: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}edad_semanas'])!,
      estado: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}estado'])!,
      sincronizado: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}sincronizado'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $LotesAvesTableTable createAlias(String alias) {
    return $LotesAvesTableTable(attachedDatabase, alias);
  }
}

class LotesAvesTableData extends DataClass
    implements Insertable<LotesAvesTableData> {
  final String id;
  final String galponId;
  final String codigo;
  final int cantidadInicial;
  final int cantidadActual;
  final DateTime fechaIngreso;
  final String? raza;
  final int edadSemanas;
  final String estado;
  final bool sincronizado;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const LotesAvesTableData(
      {required this.id,
      required this.galponId,
      required this.codigo,
      required this.cantidadInicial,
      required this.cantidadActual,
      required this.fechaIngreso,
      this.raza,
      required this.edadSemanas,
      required this.estado,
      required this.sincronizado,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['galpon_id'] = Variable<String>(galponId);
    map['codigo'] = Variable<String>(codigo);
    map['cantidad_inicial'] = Variable<int>(cantidadInicial);
    map['cantidad_actual'] = Variable<int>(cantidadActual);
    map['fecha_ingreso'] = Variable<DateTime>(fechaIngreso);
    if (!nullToAbsent || raza != null) {
      map['raza'] = Variable<String>(raza);
    }
    map['edad_semanas'] = Variable<int>(edadSemanas);
    map['estado'] = Variable<String>(estado);
    map['sincronizado'] = Variable<bool>(sincronizado);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  LotesAvesTableCompanion toCompanion(bool nullToAbsent) {
    return LotesAvesTableCompanion(
      id: Value(id),
      galponId: Value(galponId),
      codigo: Value(codigo),
      cantidadInicial: Value(cantidadInicial),
      cantidadActual: Value(cantidadActual),
      fechaIngreso: Value(fechaIngreso),
      raza: raza == null && nullToAbsent ? const Value.absent() : Value(raza),
      edadSemanas: Value(edadSemanas),
      estado: Value(estado),
      sincronizado: Value(sincronizado),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory LotesAvesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LotesAvesTableData(
      id: serializer.fromJson<String>(json['id']),
      galponId: serializer.fromJson<String>(json['galponId']),
      codigo: serializer.fromJson<String>(json['codigo']),
      cantidadInicial: serializer.fromJson<int>(json['cantidadInicial']),
      cantidadActual: serializer.fromJson<int>(json['cantidadActual']),
      fechaIngreso: serializer.fromJson<DateTime>(json['fechaIngreso']),
      raza: serializer.fromJson<String?>(json['raza']),
      edadSemanas: serializer.fromJson<int>(json['edadSemanas']),
      estado: serializer.fromJson<String>(json['estado']),
      sincronizado: serializer.fromJson<bool>(json['sincronizado']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'galponId': serializer.toJson<String>(galponId),
      'codigo': serializer.toJson<String>(codigo),
      'cantidadInicial': serializer.toJson<int>(cantidadInicial),
      'cantidadActual': serializer.toJson<int>(cantidadActual),
      'fechaIngreso': serializer.toJson<DateTime>(fechaIngreso),
      'raza': serializer.toJson<String?>(raza),
      'edadSemanas': serializer.toJson<int>(edadSemanas),
      'estado': serializer.toJson<String>(estado),
      'sincronizado': serializer.toJson<bool>(sincronizado),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  LotesAvesTableData copyWith(
          {String? id,
          String? galponId,
          String? codigo,
          int? cantidadInicial,
          int? cantidadActual,
          DateTime? fechaIngreso,
          Value<String?> raza = const Value.absent(),
          int? edadSemanas,
          String? estado,
          bool? sincronizado,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      LotesAvesTableData(
        id: id ?? this.id,
        galponId: galponId ?? this.galponId,
        codigo: codigo ?? this.codigo,
        cantidadInicial: cantidadInicial ?? this.cantidadInicial,
        cantidadActual: cantidadActual ?? this.cantidadActual,
        fechaIngreso: fechaIngreso ?? this.fechaIngreso,
        raza: raza.present ? raza.value : this.raza,
        edadSemanas: edadSemanas ?? this.edadSemanas,
        estado: estado ?? this.estado,
        sincronizado: sincronizado ?? this.sincronizado,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  LotesAvesTableData copyWithCompanion(LotesAvesTableCompanion data) {
    return LotesAvesTableData(
      id: data.id.present ? data.id.value : this.id,
      galponId: data.galponId.present ? data.galponId.value : this.galponId,
      codigo: data.codigo.present ? data.codigo.value : this.codigo,
      cantidadInicial: data.cantidadInicial.present
          ? data.cantidadInicial.value
          : this.cantidadInicial,
      cantidadActual: data.cantidadActual.present
          ? data.cantidadActual.value
          : this.cantidadActual,
      fechaIngreso: data.fechaIngreso.present
          ? data.fechaIngreso.value
          : this.fechaIngreso,
      raza: data.raza.present ? data.raza.value : this.raza,
      edadSemanas:
          data.edadSemanas.present ? data.edadSemanas.value : this.edadSemanas,
      estado: data.estado.present ? data.estado.value : this.estado,
      sincronizado: data.sincronizado.present
          ? data.sincronizado.value
          : this.sincronizado,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LotesAvesTableData(')
          ..write('id: $id, ')
          ..write('galponId: $galponId, ')
          ..write('codigo: $codigo, ')
          ..write('cantidadInicial: $cantidadInicial, ')
          ..write('cantidadActual: $cantidadActual, ')
          ..write('fechaIngreso: $fechaIngreso, ')
          ..write('raza: $raza, ')
          ..write('edadSemanas: $edadSemanas, ')
          ..write('estado: $estado, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      galponId,
      codigo,
      cantidadInicial,
      cantidadActual,
      fechaIngreso,
      raza,
      edadSemanas,
      estado,
      sincronizado,
      createdAt,
      updatedAt,
      deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LotesAvesTableData &&
          other.id == this.id &&
          other.galponId == this.galponId &&
          other.codigo == this.codigo &&
          other.cantidadInicial == this.cantidadInicial &&
          other.cantidadActual == this.cantidadActual &&
          other.fechaIngreso == this.fechaIngreso &&
          other.raza == this.raza &&
          other.edadSemanas == this.edadSemanas &&
          other.estado == this.estado &&
          other.sincronizado == this.sincronizado &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class LotesAvesTableCompanion extends UpdateCompanion<LotesAvesTableData> {
  final Value<String> id;
  final Value<String> galponId;
  final Value<String> codigo;
  final Value<int> cantidadInicial;
  final Value<int> cantidadActual;
  final Value<DateTime> fechaIngreso;
  final Value<String?> raza;
  final Value<int> edadSemanas;
  final Value<String> estado;
  final Value<bool> sincronizado;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const LotesAvesTableCompanion({
    this.id = const Value.absent(),
    this.galponId = const Value.absent(),
    this.codigo = const Value.absent(),
    this.cantidadInicial = const Value.absent(),
    this.cantidadActual = const Value.absent(),
    this.fechaIngreso = const Value.absent(),
    this.raza = const Value.absent(),
    this.edadSemanas = const Value.absent(),
    this.estado = const Value.absent(),
    this.sincronizado = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LotesAvesTableCompanion.insert({
    required String id,
    required String galponId,
    required String codigo,
    required int cantidadInicial,
    required int cantidadActual,
    required DateTime fechaIngreso,
    this.raza = const Value.absent(),
    this.edadSemanas = const Value.absent(),
    this.estado = const Value.absent(),
    this.sincronizado = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        galponId = Value(galponId),
        codigo = Value(codigo),
        cantidadInicial = Value(cantidadInicial),
        cantidadActual = Value(cantidadActual),
        fechaIngreso = Value(fechaIngreso),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<LotesAvesTableData> custom({
    Expression<String>? id,
    Expression<String>? galponId,
    Expression<String>? codigo,
    Expression<int>? cantidadInicial,
    Expression<int>? cantidadActual,
    Expression<DateTime>? fechaIngreso,
    Expression<String>? raza,
    Expression<int>? edadSemanas,
    Expression<String>? estado,
    Expression<bool>? sincronizado,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (galponId != null) 'galpon_id': galponId,
      if (codigo != null) 'codigo': codigo,
      if (cantidadInicial != null) 'cantidad_inicial': cantidadInicial,
      if (cantidadActual != null) 'cantidad_actual': cantidadActual,
      if (fechaIngreso != null) 'fecha_ingreso': fechaIngreso,
      if (raza != null) 'raza': raza,
      if (edadSemanas != null) 'edad_semanas': edadSemanas,
      if (estado != null) 'estado': estado,
      if (sincronizado != null) 'sincronizado': sincronizado,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LotesAvesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? galponId,
      Value<String>? codigo,
      Value<int>? cantidadInicial,
      Value<int>? cantidadActual,
      Value<DateTime>? fechaIngreso,
      Value<String?>? raza,
      Value<int>? edadSemanas,
      Value<String>? estado,
      Value<bool>? sincronizado,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<int>? rowid}) {
    return LotesAvesTableCompanion(
      id: id ?? this.id,
      galponId: galponId ?? this.galponId,
      codigo: codigo ?? this.codigo,
      cantidadInicial: cantidadInicial ?? this.cantidadInicial,
      cantidadActual: cantidadActual ?? this.cantidadActual,
      fechaIngreso: fechaIngreso ?? this.fechaIngreso,
      raza: raza ?? this.raza,
      edadSemanas: edadSemanas ?? this.edadSemanas,
      estado: estado ?? this.estado,
      sincronizado: sincronizado ?? this.sincronizado,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (galponId.present) {
      map['galpon_id'] = Variable<String>(galponId.value);
    }
    if (codigo.present) {
      map['codigo'] = Variable<String>(codigo.value);
    }
    if (cantidadInicial.present) {
      map['cantidad_inicial'] = Variable<int>(cantidadInicial.value);
    }
    if (cantidadActual.present) {
      map['cantidad_actual'] = Variable<int>(cantidadActual.value);
    }
    if (fechaIngreso.present) {
      map['fecha_ingreso'] = Variable<DateTime>(fechaIngreso.value);
    }
    if (raza.present) {
      map['raza'] = Variable<String>(raza.value);
    }
    if (edadSemanas.present) {
      map['edad_semanas'] = Variable<int>(edadSemanas.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    if (sincronizado.present) {
      map['sincronizado'] = Variable<bool>(sincronizado.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LotesAvesTableCompanion(')
          ..write('id: $id, ')
          ..write('galponId: $galponId, ')
          ..write('codigo: $codigo, ')
          ..write('cantidadInicial: $cantidadInicial, ')
          ..write('cantidadActual: $cantidadActual, ')
          ..write('fechaIngreso: $fechaIngreso, ')
          ..write('raza: $raza, ')
          ..write('edadSemanas: $edadSemanas, ')
          ..write('estado: $estado, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProduccionHuevosTableTable extends ProduccionHuevosTable
    with TableInfo<$ProduccionHuevosTableTable, ProduccionHuevosTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProduccionHuevosTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _galponIdMeta =
      const VerificationMeta('galponId');
  @override
  late final GeneratedColumn<String> galponId = GeneratedColumn<String>(
      'galpon_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES galpones_table (id)'));
  static const VerificationMeta _loteIdMeta = const VerificationMeta('loteId');
  @override
  late final GeneratedColumn<String> loteId = GeneratedColumn<String>(
      'lote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
      'fecha', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _cantidadTotalMeta =
      const VerificationMeta('cantidadTotal');
  @override
  late final GeneratedColumn<int> cantidadTotal = GeneratedColumn<int>(
      'cantidad_total', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _huevosRotosMeta =
      const VerificationMeta('huevosRotos');
  @override
  late final GeneratedColumn<int> huevosRotos = GeneratedColumn<int>(
      'huevos_rotos', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _huevosSuciosMeta =
      const VerificationMeta('huevosSucios');
  @override
  late final GeneratedColumn<int> huevosSucios = GeneratedColumn<int>(
      'huevos_sucios', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _huevosGrandeAAMeta =
      const VerificationMeta('huevosGrandeAA');
  @override
  late final GeneratedColumn<int> huevosGrandeAA = GeneratedColumn<int>(
      'huevos_grande_a_a', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _huevosGrandeAMeta =
      const VerificationMeta('huevosGrandeA');
  @override
  late final GeneratedColumn<int> huevosGrandeA = GeneratedColumn<int>(
      'huevos_grande_a', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _huevosMedianoMeta =
      const VerificationMeta('huevosMediano');
  @override
  late final GeneratedColumn<int> huevosMediano = GeneratedColumn<int>(
      'huevos_mediano', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _huevosPequenoMeta =
      const VerificationMeta('huevosPequeno');
  @override
  late final GeneratedColumn<int> huevosPequeno = GeneratedColumn<int>(
      'huevos_pequeno', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _porcentajePosturaMeta =
      const VerificationMeta('porcentajePostura');
  @override
  late final GeneratedColumn<double> porcentajePostura =
      GeneratedColumn<double>('porcentaje_postura', aliasedName, false,
          type: DriftSqlType.double,
          requiredDuringInsert: false,
          defaultValue: const Constant(0.0));
  static const VerificationMeta _observacionesMeta =
      const VerificationMeta('observaciones');
  @override
  late final GeneratedColumn<String> observaciones = GeneratedColumn<String>(
      'observaciones', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sincronizadoMeta =
      const VerificationMeta('sincronizado');
  @override
  late final GeneratedColumn<bool> sincronizado = GeneratedColumn<bool>(
      'sincronizado', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("sincronizado" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        galponId,
        loteId,
        fecha,
        cantidadTotal,
        huevosRotos,
        huevosSucios,
        huevosGrandeAA,
        huevosGrandeA,
        huevosMediano,
        huevosPequeno,
        porcentajePostura,
        observaciones,
        sincronizado,
        createdAt,
        updatedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'produccion_huevos_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<ProduccionHuevosTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('galpon_id')) {
      context.handle(_galponIdMeta,
          galponId.isAcceptableOrUnknown(data['galpon_id']!, _galponIdMeta));
    } else if (isInserting) {
      context.missing(_galponIdMeta);
    }
    if (data.containsKey('lote_id')) {
      context.handle(_loteIdMeta,
          loteId.isAcceptableOrUnknown(data['lote_id']!, _loteIdMeta));
    }
    if (data.containsKey('fecha')) {
      context.handle(
          _fechaMeta, fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta));
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    if (data.containsKey('cantidad_total')) {
      context.handle(
          _cantidadTotalMeta,
          cantidadTotal.isAcceptableOrUnknown(
              data['cantidad_total']!, _cantidadTotalMeta));
    } else if (isInserting) {
      context.missing(_cantidadTotalMeta);
    }
    if (data.containsKey('huevos_rotos')) {
      context.handle(
          _huevosRotosMeta,
          huevosRotos.isAcceptableOrUnknown(
              data['huevos_rotos']!, _huevosRotosMeta));
    }
    if (data.containsKey('huevos_sucios')) {
      context.handle(
          _huevosSuciosMeta,
          huevosSucios.isAcceptableOrUnknown(
              data['huevos_sucios']!, _huevosSuciosMeta));
    }
    if (data.containsKey('huevos_grande_a_a')) {
      context.handle(
          _huevosGrandeAAMeta,
          huevosGrandeAA.isAcceptableOrUnknown(
              data['huevos_grande_a_a']!, _huevosGrandeAAMeta));
    }
    if (data.containsKey('huevos_grande_a')) {
      context.handle(
          _huevosGrandeAMeta,
          huevosGrandeA.isAcceptableOrUnknown(
              data['huevos_grande_a']!, _huevosGrandeAMeta));
    }
    if (data.containsKey('huevos_mediano')) {
      context.handle(
          _huevosMedianoMeta,
          huevosMediano.isAcceptableOrUnknown(
              data['huevos_mediano']!, _huevosMedianoMeta));
    }
    if (data.containsKey('huevos_pequeno')) {
      context.handle(
          _huevosPequenoMeta,
          huevosPequeno.isAcceptableOrUnknown(
              data['huevos_pequeno']!, _huevosPequenoMeta));
    }
    if (data.containsKey('porcentaje_postura')) {
      context.handle(
          _porcentajePosturaMeta,
          porcentajePostura.isAcceptableOrUnknown(
              data['porcentaje_postura']!, _porcentajePosturaMeta));
    }
    if (data.containsKey('observaciones')) {
      context.handle(
          _observacionesMeta,
          observaciones.isAcceptableOrUnknown(
              data['observaciones']!, _observacionesMeta));
    }
    if (data.containsKey('sincronizado')) {
      context.handle(
          _sincronizadoMeta,
          sincronizado.isAcceptableOrUnknown(
              data['sincronizado']!, _sincronizadoMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProduccionHuevosTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProduccionHuevosTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      galponId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}galpon_id'])!,
      loteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lote_id']),
      fecha: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha'])!,
      cantidadTotal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cantidad_total'])!,
      huevosRotos: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}huevos_rotos'])!,
      huevosSucios: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}huevos_sucios'])!,
      huevosGrandeAA: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}huevos_grande_a_a'])!,
      huevosGrandeA: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}huevos_grande_a'])!,
      huevosMediano: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}huevos_mediano'])!,
      huevosPequeno: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}huevos_pequeno'])!,
      porcentajePostura: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}porcentaje_postura'])!,
      observaciones: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}observaciones']),
      sincronizado: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}sincronizado'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $ProduccionHuevosTableTable createAlias(String alias) {
    return $ProduccionHuevosTableTable(attachedDatabase, alias);
  }
}

class ProduccionHuevosTableData extends DataClass
    implements Insertable<ProduccionHuevosTableData> {
  final String id;
  final String galponId;
  final String? loteId;
  final DateTime fecha;
  final int cantidadTotal;
  final int huevosRotos;
  final int huevosSucios;
  final int huevosGrandeAA;
  final int huevosGrandeA;
  final int huevosMediano;
  final int huevosPequeno;
  final double porcentajePostura;
  final String? observaciones;
  final bool sincronizado;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const ProduccionHuevosTableData(
      {required this.id,
      required this.galponId,
      this.loteId,
      required this.fecha,
      required this.cantidadTotal,
      required this.huevosRotos,
      required this.huevosSucios,
      required this.huevosGrandeAA,
      required this.huevosGrandeA,
      required this.huevosMediano,
      required this.huevosPequeno,
      required this.porcentajePostura,
      this.observaciones,
      required this.sincronizado,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['galpon_id'] = Variable<String>(galponId);
    if (!nullToAbsent || loteId != null) {
      map['lote_id'] = Variable<String>(loteId);
    }
    map['fecha'] = Variable<DateTime>(fecha);
    map['cantidad_total'] = Variable<int>(cantidadTotal);
    map['huevos_rotos'] = Variable<int>(huevosRotos);
    map['huevos_sucios'] = Variable<int>(huevosSucios);
    map['huevos_grande_a_a'] = Variable<int>(huevosGrandeAA);
    map['huevos_grande_a'] = Variable<int>(huevosGrandeA);
    map['huevos_mediano'] = Variable<int>(huevosMediano);
    map['huevos_pequeno'] = Variable<int>(huevosPequeno);
    map['porcentaje_postura'] = Variable<double>(porcentajePostura);
    if (!nullToAbsent || observaciones != null) {
      map['observaciones'] = Variable<String>(observaciones);
    }
    map['sincronizado'] = Variable<bool>(sincronizado);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  ProduccionHuevosTableCompanion toCompanion(bool nullToAbsent) {
    return ProduccionHuevosTableCompanion(
      id: Value(id),
      galponId: Value(galponId),
      loteId:
          loteId == null && nullToAbsent ? const Value.absent() : Value(loteId),
      fecha: Value(fecha),
      cantidadTotal: Value(cantidadTotal),
      huevosRotos: Value(huevosRotos),
      huevosSucios: Value(huevosSucios),
      huevosGrandeAA: Value(huevosGrandeAA),
      huevosGrandeA: Value(huevosGrandeA),
      huevosMediano: Value(huevosMediano),
      huevosPequeno: Value(huevosPequeno),
      porcentajePostura: Value(porcentajePostura),
      observaciones: observaciones == null && nullToAbsent
          ? const Value.absent()
          : Value(observaciones),
      sincronizado: Value(sincronizado),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory ProduccionHuevosTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProduccionHuevosTableData(
      id: serializer.fromJson<String>(json['id']),
      galponId: serializer.fromJson<String>(json['galponId']),
      loteId: serializer.fromJson<String?>(json['loteId']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      cantidadTotal: serializer.fromJson<int>(json['cantidadTotal']),
      huevosRotos: serializer.fromJson<int>(json['huevosRotos']),
      huevosSucios: serializer.fromJson<int>(json['huevosSucios']),
      huevosGrandeAA: serializer.fromJson<int>(json['huevosGrandeAA']),
      huevosGrandeA: serializer.fromJson<int>(json['huevosGrandeA']),
      huevosMediano: serializer.fromJson<int>(json['huevosMediano']),
      huevosPequeno: serializer.fromJson<int>(json['huevosPequeno']),
      porcentajePostura: serializer.fromJson<double>(json['porcentajePostura']),
      observaciones: serializer.fromJson<String?>(json['observaciones']),
      sincronizado: serializer.fromJson<bool>(json['sincronizado']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'galponId': serializer.toJson<String>(galponId),
      'loteId': serializer.toJson<String?>(loteId),
      'fecha': serializer.toJson<DateTime>(fecha),
      'cantidadTotal': serializer.toJson<int>(cantidadTotal),
      'huevosRotos': serializer.toJson<int>(huevosRotos),
      'huevosSucios': serializer.toJson<int>(huevosSucios),
      'huevosGrandeAA': serializer.toJson<int>(huevosGrandeAA),
      'huevosGrandeA': serializer.toJson<int>(huevosGrandeA),
      'huevosMediano': serializer.toJson<int>(huevosMediano),
      'huevosPequeno': serializer.toJson<int>(huevosPequeno),
      'porcentajePostura': serializer.toJson<double>(porcentajePostura),
      'observaciones': serializer.toJson<String?>(observaciones),
      'sincronizado': serializer.toJson<bool>(sincronizado),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  ProduccionHuevosTableData copyWith(
          {String? id,
          String? galponId,
          Value<String?> loteId = const Value.absent(),
          DateTime? fecha,
          int? cantidadTotal,
          int? huevosRotos,
          int? huevosSucios,
          int? huevosGrandeAA,
          int? huevosGrandeA,
          int? huevosMediano,
          int? huevosPequeno,
          double? porcentajePostura,
          Value<String?> observaciones = const Value.absent(),
          bool? sincronizado,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      ProduccionHuevosTableData(
        id: id ?? this.id,
        galponId: galponId ?? this.galponId,
        loteId: loteId.present ? loteId.value : this.loteId,
        fecha: fecha ?? this.fecha,
        cantidadTotal: cantidadTotal ?? this.cantidadTotal,
        huevosRotos: huevosRotos ?? this.huevosRotos,
        huevosSucios: huevosSucios ?? this.huevosSucios,
        huevosGrandeAA: huevosGrandeAA ?? this.huevosGrandeAA,
        huevosGrandeA: huevosGrandeA ?? this.huevosGrandeA,
        huevosMediano: huevosMediano ?? this.huevosMediano,
        huevosPequeno: huevosPequeno ?? this.huevosPequeno,
        porcentajePostura: porcentajePostura ?? this.porcentajePostura,
        observaciones:
            observaciones.present ? observaciones.value : this.observaciones,
        sincronizado: sincronizado ?? this.sincronizado,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  ProduccionHuevosTableData copyWithCompanion(
      ProduccionHuevosTableCompanion data) {
    return ProduccionHuevosTableData(
      id: data.id.present ? data.id.value : this.id,
      galponId: data.galponId.present ? data.galponId.value : this.galponId,
      loteId: data.loteId.present ? data.loteId.value : this.loteId,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      cantidadTotal: data.cantidadTotal.present
          ? data.cantidadTotal.value
          : this.cantidadTotal,
      huevosRotos:
          data.huevosRotos.present ? data.huevosRotos.value : this.huevosRotos,
      huevosSucios: data.huevosSucios.present
          ? data.huevosSucios.value
          : this.huevosSucios,
      huevosGrandeAA: data.huevosGrandeAA.present
          ? data.huevosGrandeAA.value
          : this.huevosGrandeAA,
      huevosGrandeA: data.huevosGrandeA.present
          ? data.huevosGrandeA.value
          : this.huevosGrandeA,
      huevosMediano: data.huevosMediano.present
          ? data.huevosMediano.value
          : this.huevosMediano,
      huevosPequeno: data.huevosPequeno.present
          ? data.huevosPequeno.value
          : this.huevosPequeno,
      porcentajePostura: data.porcentajePostura.present
          ? data.porcentajePostura.value
          : this.porcentajePostura,
      observaciones: data.observaciones.present
          ? data.observaciones.value
          : this.observaciones,
      sincronizado: data.sincronizado.present
          ? data.sincronizado.value
          : this.sincronizado,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProduccionHuevosTableData(')
          ..write('id: $id, ')
          ..write('galponId: $galponId, ')
          ..write('loteId: $loteId, ')
          ..write('fecha: $fecha, ')
          ..write('cantidadTotal: $cantidadTotal, ')
          ..write('huevosRotos: $huevosRotos, ')
          ..write('huevosSucios: $huevosSucios, ')
          ..write('huevosGrandeAA: $huevosGrandeAA, ')
          ..write('huevosGrandeA: $huevosGrandeA, ')
          ..write('huevosMediano: $huevosMediano, ')
          ..write('huevosPequeno: $huevosPequeno, ')
          ..write('porcentajePostura: $porcentajePostura, ')
          ..write('observaciones: $observaciones, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      galponId,
      loteId,
      fecha,
      cantidadTotal,
      huevosRotos,
      huevosSucios,
      huevosGrandeAA,
      huevosGrandeA,
      huevosMediano,
      huevosPequeno,
      porcentajePostura,
      observaciones,
      sincronizado,
      createdAt,
      updatedAt,
      deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProduccionHuevosTableData &&
          other.id == this.id &&
          other.galponId == this.galponId &&
          other.loteId == this.loteId &&
          other.fecha == this.fecha &&
          other.cantidadTotal == this.cantidadTotal &&
          other.huevosRotos == this.huevosRotos &&
          other.huevosSucios == this.huevosSucios &&
          other.huevosGrandeAA == this.huevosGrandeAA &&
          other.huevosGrandeA == this.huevosGrandeA &&
          other.huevosMediano == this.huevosMediano &&
          other.huevosPequeno == this.huevosPequeno &&
          other.porcentajePostura == this.porcentajePostura &&
          other.observaciones == this.observaciones &&
          other.sincronizado == this.sincronizado &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class ProduccionHuevosTableCompanion
    extends UpdateCompanion<ProduccionHuevosTableData> {
  final Value<String> id;
  final Value<String> galponId;
  final Value<String?> loteId;
  final Value<DateTime> fecha;
  final Value<int> cantidadTotal;
  final Value<int> huevosRotos;
  final Value<int> huevosSucios;
  final Value<int> huevosGrandeAA;
  final Value<int> huevosGrandeA;
  final Value<int> huevosMediano;
  final Value<int> huevosPequeno;
  final Value<double> porcentajePostura;
  final Value<String?> observaciones;
  final Value<bool> sincronizado;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const ProduccionHuevosTableCompanion({
    this.id = const Value.absent(),
    this.galponId = const Value.absent(),
    this.loteId = const Value.absent(),
    this.fecha = const Value.absent(),
    this.cantidadTotal = const Value.absent(),
    this.huevosRotos = const Value.absent(),
    this.huevosSucios = const Value.absent(),
    this.huevosGrandeAA = const Value.absent(),
    this.huevosGrandeA = const Value.absent(),
    this.huevosMediano = const Value.absent(),
    this.huevosPequeno = const Value.absent(),
    this.porcentajePostura = const Value.absent(),
    this.observaciones = const Value.absent(),
    this.sincronizado = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProduccionHuevosTableCompanion.insert({
    required String id,
    required String galponId,
    this.loteId = const Value.absent(),
    required DateTime fecha,
    required int cantidadTotal,
    this.huevosRotos = const Value.absent(),
    this.huevosSucios = const Value.absent(),
    this.huevosGrandeAA = const Value.absent(),
    this.huevosGrandeA = const Value.absent(),
    this.huevosMediano = const Value.absent(),
    this.huevosPequeno = const Value.absent(),
    this.porcentajePostura = const Value.absent(),
    this.observaciones = const Value.absent(),
    this.sincronizado = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        galponId = Value(galponId),
        fecha = Value(fecha),
        cantidadTotal = Value(cantidadTotal),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<ProduccionHuevosTableData> custom({
    Expression<String>? id,
    Expression<String>? galponId,
    Expression<String>? loteId,
    Expression<DateTime>? fecha,
    Expression<int>? cantidadTotal,
    Expression<int>? huevosRotos,
    Expression<int>? huevosSucios,
    Expression<int>? huevosGrandeAA,
    Expression<int>? huevosGrandeA,
    Expression<int>? huevosMediano,
    Expression<int>? huevosPequeno,
    Expression<double>? porcentajePostura,
    Expression<String>? observaciones,
    Expression<bool>? sincronizado,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (galponId != null) 'galpon_id': galponId,
      if (loteId != null) 'lote_id': loteId,
      if (fecha != null) 'fecha': fecha,
      if (cantidadTotal != null) 'cantidad_total': cantidadTotal,
      if (huevosRotos != null) 'huevos_rotos': huevosRotos,
      if (huevosSucios != null) 'huevos_sucios': huevosSucios,
      if (huevosGrandeAA != null) 'huevos_grande_a_a': huevosGrandeAA,
      if (huevosGrandeA != null) 'huevos_grande_a': huevosGrandeA,
      if (huevosMediano != null) 'huevos_mediano': huevosMediano,
      if (huevosPequeno != null) 'huevos_pequeno': huevosPequeno,
      if (porcentajePostura != null) 'porcentaje_postura': porcentajePostura,
      if (observaciones != null) 'observaciones': observaciones,
      if (sincronizado != null) 'sincronizado': sincronizado,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProduccionHuevosTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? galponId,
      Value<String?>? loteId,
      Value<DateTime>? fecha,
      Value<int>? cantidadTotal,
      Value<int>? huevosRotos,
      Value<int>? huevosSucios,
      Value<int>? huevosGrandeAA,
      Value<int>? huevosGrandeA,
      Value<int>? huevosMediano,
      Value<int>? huevosPequeno,
      Value<double>? porcentajePostura,
      Value<String?>? observaciones,
      Value<bool>? sincronizado,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<int>? rowid}) {
    return ProduccionHuevosTableCompanion(
      id: id ?? this.id,
      galponId: galponId ?? this.galponId,
      loteId: loteId ?? this.loteId,
      fecha: fecha ?? this.fecha,
      cantidadTotal: cantidadTotal ?? this.cantidadTotal,
      huevosRotos: huevosRotos ?? this.huevosRotos,
      huevosSucios: huevosSucios ?? this.huevosSucios,
      huevosGrandeAA: huevosGrandeAA ?? this.huevosGrandeAA,
      huevosGrandeA: huevosGrandeA ?? this.huevosGrandeA,
      huevosMediano: huevosMediano ?? this.huevosMediano,
      huevosPequeno: huevosPequeno ?? this.huevosPequeno,
      porcentajePostura: porcentajePostura ?? this.porcentajePostura,
      observaciones: observaciones ?? this.observaciones,
      sincronizado: sincronizado ?? this.sincronizado,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (galponId.present) {
      map['galpon_id'] = Variable<String>(galponId.value);
    }
    if (loteId.present) {
      map['lote_id'] = Variable<String>(loteId.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (cantidadTotal.present) {
      map['cantidad_total'] = Variable<int>(cantidadTotal.value);
    }
    if (huevosRotos.present) {
      map['huevos_rotos'] = Variable<int>(huevosRotos.value);
    }
    if (huevosSucios.present) {
      map['huevos_sucios'] = Variable<int>(huevosSucios.value);
    }
    if (huevosGrandeAA.present) {
      map['huevos_grande_a_a'] = Variable<int>(huevosGrandeAA.value);
    }
    if (huevosGrandeA.present) {
      map['huevos_grande_a'] = Variable<int>(huevosGrandeA.value);
    }
    if (huevosMediano.present) {
      map['huevos_mediano'] = Variable<int>(huevosMediano.value);
    }
    if (huevosPequeno.present) {
      map['huevos_pequeno'] = Variable<int>(huevosPequeno.value);
    }
    if (porcentajePostura.present) {
      map['porcentaje_postura'] = Variable<double>(porcentajePostura.value);
    }
    if (observaciones.present) {
      map['observaciones'] = Variable<String>(observaciones.value);
    }
    if (sincronizado.present) {
      map['sincronizado'] = Variable<bool>(sincronizado.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProduccionHuevosTableCompanion(')
          ..write('id: $id, ')
          ..write('galponId: $galponId, ')
          ..write('loteId: $loteId, ')
          ..write('fecha: $fecha, ')
          ..write('cantidadTotal: $cantidadTotal, ')
          ..write('huevosRotos: $huevosRotos, ')
          ..write('huevosSucios: $huevosSucios, ')
          ..write('huevosGrandeAA: $huevosGrandeAA, ')
          ..write('huevosGrandeA: $huevosGrandeA, ')
          ..write('huevosMediano: $huevosMediano, ')
          ..write('huevosPequeno: $huevosPequeno, ')
          ..write('porcentajePostura: $porcentajePostura, ')
          ..write('observaciones: $observaciones, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EventosSanitariosTableTable extends EventosSanitariosTable
    with TableInfo<$EventosSanitariosTableTable, EventosSanitariosTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventosSanitariosTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _galponIdMeta =
      const VerificationMeta('galponId');
  @override
  late final GeneratedColumn<String> galponId = GeneratedColumn<String>(
      'galpon_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES galpones_table (id)'));
  static const VerificationMeta _loteIdMeta = const VerificationMeta('loteId');
  @override
  late final GeneratedColumn<String> loteId = GeneratedColumn<String>(
      'lote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
      'tipo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
      'fecha', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _descripcionMeta =
      const VerificationMeta('descripcion');
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
      'descripcion', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _medicamentoMeta =
      const VerificationMeta('medicamento');
  @override
  late final GeneratedColumn<String> medicamento = GeneratedColumn<String>(
      'medicamento', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dosisMeta = const VerificationMeta('dosis');
  @override
  late final GeneratedColumn<String> dosis = GeneratedColumn<String>(
      'dosis', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _veterinarioMeta =
      const VerificationMeta('veterinario');
  @override
  late final GeneratedColumn<String> veterinario = GeneratedColumn<String>(
      'veterinario', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _avesAfectadasMeta =
      const VerificationMeta('avesAfectadas');
  @override
  late final GeneratedColumn<int> avesAfectadas = GeneratedColumn<int>(
      'aves_afectadas', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _observacionesMeta =
      const VerificationMeta('observaciones');
  @override
  late final GeneratedColumn<String> observaciones = GeneratedColumn<String>(
      'observaciones', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sincronizadoMeta =
      const VerificationMeta('sincronizado');
  @override
  late final GeneratedColumn<bool> sincronizado = GeneratedColumn<bool>(
      'sincronizado', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("sincronizado" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        galponId,
        loteId,
        tipo,
        fecha,
        descripcion,
        medicamento,
        dosis,
        veterinario,
        avesAfectadas,
        observaciones,
        sincronizado,
        createdAt,
        updatedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'eventos_sanitarios_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<EventosSanitariosTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('galpon_id')) {
      context.handle(_galponIdMeta,
          galponId.isAcceptableOrUnknown(data['galpon_id']!, _galponIdMeta));
    } else if (isInserting) {
      context.missing(_galponIdMeta);
    }
    if (data.containsKey('lote_id')) {
      context.handle(_loteIdMeta,
          loteId.isAcceptableOrUnknown(data['lote_id']!, _loteIdMeta));
    }
    if (data.containsKey('tipo')) {
      context.handle(
          _tipoMeta, tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta));
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (data.containsKey('fecha')) {
      context.handle(
          _fechaMeta, fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta));
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
          _descripcionMeta,
          descripcion.isAcceptableOrUnknown(
              data['descripcion']!, _descripcionMeta));
    } else if (isInserting) {
      context.missing(_descripcionMeta);
    }
    if (data.containsKey('medicamento')) {
      context.handle(
          _medicamentoMeta,
          medicamento.isAcceptableOrUnknown(
              data['medicamento']!, _medicamentoMeta));
    }
    if (data.containsKey('dosis')) {
      context.handle(
          _dosisMeta, dosis.isAcceptableOrUnknown(data['dosis']!, _dosisMeta));
    }
    if (data.containsKey('veterinario')) {
      context.handle(
          _veterinarioMeta,
          veterinario.isAcceptableOrUnknown(
              data['veterinario']!, _veterinarioMeta));
    }
    if (data.containsKey('aves_afectadas')) {
      context.handle(
          _avesAfectadasMeta,
          avesAfectadas.isAcceptableOrUnknown(
              data['aves_afectadas']!, _avesAfectadasMeta));
    }
    if (data.containsKey('observaciones')) {
      context.handle(
          _observacionesMeta,
          observaciones.isAcceptableOrUnknown(
              data['observaciones']!, _observacionesMeta));
    }
    if (data.containsKey('sincronizado')) {
      context.handle(
          _sincronizadoMeta,
          sincronizado.isAcceptableOrUnknown(
              data['sincronizado']!, _sincronizadoMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EventosSanitariosTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventosSanitariosTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      galponId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}galpon_id'])!,
      loteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lote_id']),
      tipo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tipo'])!,
      fecha: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha'])!,
      descripcion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descripcion'])!,
      medicamento: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}medicamento']),
      dosis: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dosis']),
      veterinario: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}veterinario']),
      avesAfectadas: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}aves_afectadas'])!,
      observaciones: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}observaciones']),
      sincronizado: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}sincronizado'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $EventosSanitariosTableTable createAlias(String alias) {
    return $EventosSanitariosTableTable(attachedDatabase, alias);
  }
}

class EventosSanitariosTableData extends DataClass
    implements Insertable<EventosSanitariosTableData> {
  final String id;
  final String galponId;
  final String? loteId;
  final String tipo;
  final DateTime fecha;
  final String descripcion;
  final String? medicamento;
  final String? dosis;
  final String? veterinario;
  final int avesAfectadas;
  final String? observaciones;
  final bool sincronizado;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const EventosSanitariosTableData(
      {required this.id,
      required this.galponId,
      this.loteId,
      required this.tipo,
      required this.fecha,
      required this.descripcion,
      this.medicamento,
      this.dosis,
      this.veterinario,
      required this.avesAfectadas,
      this.observaciones,
      required this.sincronizado,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['galpon_id'] = Variable<String>(galponId);
    if (!nullToAbsent || loteId != null) {
      map['lote_id'] = Variable<String>(loteId);
    }
    map['tipo'] = Variable<String>(tipo);
    map['fecha'] = Variable<DateTime>(fecha);
    map['descripcion'] = Variable<String>(descripcion);
    if (!nullToAbsent || medicamento != null) {
      map['medicamento'] = Variable<String>(medicamento);
    }
    if (!nullToAbsent || dosis != null) {
      map['dosis'] = Variable<String>(dosis);
    }
    if (!nullToAbsent || veterinario != null) {
      map['veterinario'] = Variable<String>(veterinario);
    }
    map['aves_afectadas'] = Variable<int>(avesAfectadas);
    if (!nullToAbsent || observaciones != null) {
      map['observaciones'] = Variable<String>(observaciones);
    }
    map['sincronizado'] = Variable<bool>(sincronizado);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  EventosSanitariosTableCompanion toCompanion(bool nullToAbsent) {
    return EventosSanitariosTableCompanion(
      id: Value(id),
      galponId: Value(galponId),
      loteId:
          loteId == null && nullToAbsent ? const Value.absent() : Value(loteId),
      tipo: Value(tipo),
      fecha: Value(fecha),
      descripcion: Value(descripcion),
      medicamento: medicamento == null && nullToAbsent
          ? const Value.absent()
          : Value(medicamento),
      dosis:
          dosis == null && nullToAbsent ? const Value.absent() : Value(dosis),
      veterinario: veterinario == null && nullToAbsent
          ? const Value.absent()
          : Value(veterinario),
      avesAfectadas: Value(avesAfectadas),
      observaciones: observaciones == null && nullToAbsent
          ? const Value.absent()
          : Value(observaciones),
      sincronizado: Value(sincronizado),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory EventosSanitariosTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventosSanitariosTableData(
      id: serializer.fromJson<String>(json['id']),
      galponId: serializer.fromJson<String>(json['galponId']),
      loteId: serializer.fromJson<String?>(json['loteId']),
      tipo: serializer.fromJson<String>(json['tipo']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      descripcion: serializer.fromJson<String>(json['descripcion']),
      medicamento: serializer.fromJson<String?>(json['medicamento']),
      dosis: serializer.fromJson<String?>(json['dosis']),
      veterinario: serializer.fromJson<String?>(json['veterinario']),
      avesAfectadas: serializer.fromJson<int>(json['avesAfectadas']),
      observaciones: serializer.fromJson<String?>(json['observaciones']),
      sincronizado: serializer.fromJson<bool>(json['sincronizado']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'galponId': serializer.toJson<String>(galponId),
      'loteId': serializer.toJson<String?>(loteId),
      'tipo': serializer.toJson<String>(tipo),
      'fecha': serializer.toJson<DateTime>(fecha),
      'descripcion': serializer.toJson<String>(descripcion),
      'medicamento': serializer.toJson<String?>(medicamento),
      'dosis': serializer.toJson<String?>(dosis),
      'veterinario': serializer.toJson<String?>(veterinario),
      'avesAfectadas': serializer.toJson<int>(avesAfectadas),
      'observaciones': serializer.toJson<String?>(observaciones),
      'sincronizado': serializer.toJson<bool>(sincronizado),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  EventosSanitariosTableData copyWith(
          {String? id,
          String? galponId,
          Value<String?> loteId = const Value.absent(),
          String? tipo,
          DateTime? fecha,
          String? descripcion,
          Value<String?> medicamento = const Value.absent(),
          Value<String?> dosis = const Value.absent(),
          Value<String?> veterinario = const Value.absent(),
          int? avesAfectadas,
          Value<String?> observaciones = const Value.absent(),
          bool? sincronizado,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      EventosSanitariosTableData(
        id: id ?? this.id,
        galponId: galponId ?? this.galponId,
        loteId: loteId.present ? loteId.value : this.loteId,
        tipo: tipo ?? this.tipo,
        fecha: fecha ?? this.fecha,
        descripcion: descripcion ?? this.descripcion,
        medicamento: medicamento.present ? medicamento.value : this.medicamento,
        dosis: dosis.present ? dosis.value : this.dosis,
        veterinario: veterinario.present ? veterinario.value : this.veterinario,
        avesAfectadas: avesAfectadas ?? this.avesAfectadas,
        observaciones:
            observaciones.present ? observaciones.value : this.observaciones,
        sincronizado: sincronizado ?? this.sincronizado,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  EventosSanitariosTableData copyWithCompanion(
      EventosSanitariosTableCompanion data) {
    return EventosSanitariosTableData(
      id: data.id.present ? data.id.value : this.id,
      galponId: data.galponId.present ? data.galponId.value : this.galponId,
      loteId: data.loteId.present ? data.loteId.value : this.loteId,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      descripcion:
          data.descripcion.present ? data.descripcion.value : this.descripcion,
      medicamento:
          data.medicamento.present ? data.medicamento.value : this.medicamento,
      dosis: data.dosis.present ? data.dosis.value : this.dosis,
      veterinario:
          data.veterinario.present ? data.veterinario.value : this.veterinario,
      avesAfectadas: data.avesAfectadas.present
          ? data.avesAfectadas.value
          : this.avesAfectadas,
      observaciones: data.observaciones.present
          ? data.observaciones.value
          : this.observaciones,
      sincronizado: data.sincronizado.present
          ? data.sincronizado.value
          : this.sincronizado,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EventosSanitariosTableData(')
          ..write('id: $id, ')
          ..write('galponId: $galponId, ')
          ..write('loteId: $loteId, ')
          ..write('tipo: $tipo, ')
          ..write('fecha: $fecha, ')
          ..write('descripcion: $descripcion, ')
          ..write('medicamento: $medicamento, ')
          ..write('dosis: $dosis, ')
          ..write('veterinario: $veterinario, ')
          ..write('avesAfectadas: $avesAfectadas, ')
          ..write('observaciones: $observaciones, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      galponId,
      loteId,
      tipo,
      fecha,
      descripcion,
      medicamento,
      dosis,
      veterinario,
      avesAfectadas,
      observaciones,
      sincronizado,
      createdAt,
      updatedAt,
      deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventosSanitariosTableData &&
          other.id == this.id &&
          other.galponId == this.galponId &&
          other.loteId == this.loteId &&
          other.tipo == this.tipo &&
          other.fecha == this.fecha &&
          other.descripcion == this.descripcion &&
          other.medicamento == this.medicamento &&
          other.dosis == this.dosis &&
          other.veterinario == this.veterinario &&
          other.avesAfectadas == this.avesAfectadas &&
          other.observaciones == this.observaciones &&
          other.sincronizado == this.sincronizado &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class EventosSanitariosTableCompanion
    extends UpdateCompanion<EventosSanitariosTableData> {
  final Value<String> id;
  final Value<String> galponId;
  final Value<String?> loteId;
  final Value<String> tipo;
  final Value<DateTime> fecha;
  final Value<String> descripcion;
  final Value<String?> medicamento;
  final Value<String?> dosis;
  final Value<String?> veterinario;
  final Value<int> avesAfectadas;
  final Value<String?> observaciones;
  final Value<bool> sincronizado;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const EventosSanitariosTableCompanion({
    this.id = const Value.absent(),
    this.galponId = const Value.absent(),
    this.loteId = const Value.absent(),
    this.tipo = const Value.absent(),
    this.fecha = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.medicamento = const Value.absent(),
    this.dosis = const Value.absent(),
    this.veterinario = const Value.absent(),
    this.avesAfectadas = const Value.absent(),
    this.observaciones = const Value.absent(),
    this.sincronizado = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EventosSanitariosTableCompanion.insert({
    required String id,
    required String galponId,
    this.loteId = const Value.absent(),
    required String tipo,
    required DateTime fecha,
    required String descripcion,
    this.medicamento = const Value.absent(),
    this.dosis = const Value.absent(),
    this.veterinario = const Value.absent(),
    this.avesAfectadas = const Value.absent(),
    this.observaciones = const Value.absent(),
    this.sincronizado = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        galponId = Value(galponId),
        tipo = Value(tipo),
        fecha = Value(fecha),
        descripcion = Value(descripcion),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<EventosSanitariosTableData> custom({
    Expression<String>? id,
    Expression<String>? galponId,
    Expression<String>? loteId,
    Expression<String>? tipo,
    Expression<DateTime>? fecha,
    Expression<String>? descripcion,
    Expression<String>? medicamento,
    Expression<String>? dosis,
    Expression<String>? veterinario,
    Expression<int>? avesAfectadas,
    Expression<String>? observaciones,
    Expression<bool>? sincronizado,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (galponId != null) 'galpon_id': galponId,
      if (loteId != null) 'lote_id': loteId,
      if (tipo != null) 'tipo': tipo,
      if (fecha != null) 'fecha': fecha,
      if (descripcion != null) 'descripcion': descripcion,
      if (medicamento != null) 'medicamento': medicamento,
      if (dosis != null) 'dosis': dosis,
      if (veterinario != null) 'veterinario': veterinario,
      if (avesAfectadas != null) 'aves_afectadas': avesAfectadas,
      if (observaciones != null) 'observaciones': observaciones,
      if (sincronizado != null) 'sincronizado': sincronizado,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EventosSanitariosTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? galponId,
      Value<String?>? loteId,
      Value<String>? tipo,
      Value<DateTime>? fecha,
      Value<String>? descripcion,
      Value<String?>? medicamento,
      Value<String?>? dosis,
      Value<String?>? veterinario,
      Value<int>? avesAfectadas,
      Value<String?>? observaciones,
      Value<bool>? sincronizado,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<int>? rowid}) {
    return EventosSanitariosTableCompanion(
      id: id ?? this.id,
      galponId: galponId ?? this.galponId,
      loteId: loteId ?? this.loteId,
      tipo: tipo ?? this.tipo,
      fecha: fecha ?? this.fecha,
      descripcion: descripcion ?? this.descripcion,
      medicamento: medicamento ?? this.medicamento,
      dosis: dosis ?? this.dosis,
      veterinario: veterinario ?? this.veterinario,
      avesAfectadas: avesAfectadas ?? this.avesAfectadas,
      observaciones: observaciones ?? this.observaciones,
      sincronizado: sincronizado ?? this.sincronizado,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (galponId.present) {
      map['galpon_id'] = Variable<String>(galponId.value);
    }
    if (loteId.present) {
      map['lote_id'] = Variable<String>(loteId.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (medicamento.present) {
      map['medicamento'] = Variable<String>(medicamento.value);
    }
    if (dosis.present) {
      map['dosis'] = Variable<String>(dosis.value);
    }
    if (veterinario.present) {
      map['veterinario'] = Variable<String>(veterinario.value);
    }
    if (avesAfectadas.present) {
      map['aves_afectadas'] = Variable<int>(avesAfectadas.value);
    }
    if (observaciones.present) {
      map['observaciones'] = Variable<String>(observaciones.value);
    }
    if (sincronizado.present) {
      map['sincronizado'] = Variable<bool>(sincronizado.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventosSanitariosTableCompanion(')
          ..write('id: $id, ')
          ..write('galponId: $galponId, ')
          ..write('loteId: $loteId, ')
          ..write('tipo: $tipo, ')
          ..write('fecha: $fecha, ')
          ..write('descripcion: $descripcion, ')
          ..write('medicamento: $medicamento, ')
          ..write('dosis: $dosis, ')
          ..write('veterinario: $veterinario, ')
          ..write('avesAfectadas: $avesAfectadas, ')
          ..write('observaciones: $observaciones, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AlimentacionTableTable extends AlimentacionTable
    with TableInfo<$AlimentacionTableTable, AlimentacionTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlimentacionTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _galponIdMeta =
      const VerificationMeta('galponId');
  @override
  late final GeneratedColumn<String> galponId = GeneratedColumn<String>(
      'galpon_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES galpones_table (id)'));
  static const VerificationMeta _loteIdMeta = const VerificationMeta('loteId');
  @override
  late final GeneratedColumn<String> loteId = GeneratedColumn<String>(
      'lote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
      'fecha', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _tipoAlimentoMeta =
      const VerificationMeta('tipoAlimento');
  @override
  late final GeneratedColumn<String> tipoAlimento = GeneratedColumn<String>(
      'tipo_alimento', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _cantidadKgMeta =
      const VerificationMeta('cantidadKg');
  @override
  late final GeneratedColumn<double> cantidadKg = GeneratedColumn<double>(
      'cantidad_kg', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _loteAlimentoMeta =
      const VerificationMeta('loteAlimento');
  @override
  late final GeneratedColumn<String> loteAlimento = GeneratedColumn<String>(
      'lote_alimento', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _costoUnitarioMeta =
      const VerificationMeta('costoUnitario');
  @override
  late final GeneratedColumn<double> costoUnitario = GeneratedColumn<double>(
      'costo_unitario', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _observacionesMeta =
      const VerificationMeta('observaciones');
  @override
  late final GeneratedColumn<String> observaciones = GeneratedColumn<String>(
      'observaciones', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sincronizadoMeta =
      const VerificationMeta('sincronizado');
  @override
  late final GeneratedColumn<bool> sincronizado = GeneratedColumn<bool>(
      'sincronizado', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("sincronizado" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        galponId,
        loteId,
        fecha,
        tipoAlimento,
        cantidadKg,
        loteAlimento,
        costoUnitario,
        observaciones,
        sincronizado,
        createdAt,
        updatedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'alimentacion_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<AlimentacionTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('galpon_id')) {
      context.handle(_galponIdMeta,
          galponId.isAcceptableOrUnknown(data['galpon_id']!, _galponIdMeta));
    } else if (isInserting) {
      context.missing(_galponIdMeta);
    }
    if (data.containsKey('lote_id')) {
      context.handle(_loteIdMeta,
          loteId.isAcceptableOrUnknown(data['lote_id']!, _loteIdMeta));
    }
    if (data.containsKey('fecha')) {
      context.handle(
          _fechaMeta, fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta));
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    if (data.containsKey('tipo_alimento')) {
      context.handle(
          _tipoAlimentoMeta,
          tipoAlimento.isAcceptableOrUnknown(
              data['tipo_alimento']!, _tipoAlimentoMeta));
    } else if (isInserting) {
      context.missing(_tipoAlimentoMeta);
    }
    if (data.containsKey('cantidad_kg')) {
      context.handle(
          _cantidadKgMeta,
          cantidadKg.isAcceptableOrUnknown(
              data['cantidad_kg']!, _cantidadKgMeta));
    } else if (isInserting) {
      context.missing(_cantidadKgMeta);
    }
    if (data.containsKey('lote_alimento')) {
      context.handle(
          _loteAlimentoMeta,
          loteAlimento.isAcceptableOrUnknown(
              data['lote_alimento']!, _loteAlimentoMeta));
    }
    if (data.containsKey('costo_unitario')) {
      context.handle(
          _costoUnitarioMeta,
          costoUnitario.isAcceptableOrUnknown(
              data['costo_unitario']!, _costoUnitarioMeta));
    }
    if (data.containsKey('observaciones')) {
      context.handle(
          _observacionesMeta,
          observaciones.isAcceptableOrUnknown(
              data['observaciones']!, _observacionesMeta));
    }
    if (data.containsKey('sincronizado')) {
      context.handle(
          _sincronizadoMeta,
          sincronizado.isAcceptableOrUnknown(
              data['sincronizado']!, _sincronizadoMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AlimentacionTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AlimentacionTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      galponId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}galpon_id'])!,
      loteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lote_id']),
      fecha: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha'])!,
      tipoAlimento: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tipo_alimento'])!,
      cantidadKg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}cantidad_kg'])!,
      loteAlimento: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lote_alimento']),
      costoUnitario: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}costo_unitario'])!,
      observaciones: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}observaciones']),
      sincronizado: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}sincronizado'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $AlimentacionTableTable createAlias(String alias) {
    return $AlimentacionTableTable(attachedDatabase, alias);
  }
}

class AlimentacionTableData extends DataClass
    implements Insertable<AlimentacionTableData> {
  final String id;
  final String galponId;
  final String? loteId;
  final DateTime fecha;
  final String tipoAlimento;
  final double cantidadKg;
  final String? loteAlimento;
  final double costoUnitario;
  final String? observaciones;
  final bool sincronizado;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const AlimentacionTableData(
      {required this.id,
      required this.galponId,
      this.loteId,
      required this.fecha,
      required this.tipoAlimento,
      required this.cantidadKg,
      this.loteAlimento,
      required this.costoUnitario,
      this.observaciones,
      required this.sincronizado,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['galpon_id'] = Variable<String>(galponId);
    if (!nullToAbsent || loteId != null) {
      map['lote_id'] = Variable<String>(loteId);
    }
    map['fecha'] = Variable<DateTime>(fecha);
    map['tipo_alimento'] = Variable<String>(tipoAlimento);
    map['cantidad_kg'] = Variable<double>(cantidadKg);
    if (!nullToAbsent || loteAlimento != null) {
      map['lote_alimento'] = Variable<String>(loteAlimento);
    }
    map['costo_unitario'] = Variable<double>(costoUnitario);
    if (!nullToAbsent || observaciones != null) {
      map['observaciones'] = Variable<String>(observaciones);
    }
    map['sincronizado'] = Variable<bool>(sincronizado);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  AlimentacionTableCompanion toCompanion(bool nullToAbsent) {
    return AlimentacionTableCompanion(
      id: Value(id),
      galponId: Value(galponId),
      loteId:
          loteId == null && nullToAbsent ? const Value.absent() : Value(loteId),
      fecha: Value(fecha),
      tipoAlimento: Value(tipoAlimento),
      cantidadKg: Value(cantidadKg),
      loteAlimento: loteAlimento == null && nullToAbsent
          ? const Value.absent()
          : Value(loteAlimento),
      costoUnitario: Value(costoUnitario),
      observaciones: observaciones == null && nullToAbsent
          ? const Value.absent()
          : Value(observaciones),
      sincronizado: Value(sincronizado),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory AlimentacionTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AlimentacionTableData(
      id: serializer.fromJson<String>(json['id']),
      galponId: serializer.fromJson<String>(json['galponId']),
      loteId: serializer.fromJson<String?>(json['loteId']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      tipoAlimento: serializer.fromJson<String>(json['tipoAlimento']),
      cantidadKg: serializer.fromJson<double>(json['cantidadKg']),
      loteAlimento: serializer.fromJson<String?>(json['loteAlimento']),
      costoUnitario: serializer.fromJson<double>(json['costoUnitario']),
      observaciones: serializer.fromJson<String?>(json['observaciones']),
      sincronizado: serializer.fromJson<bool>(json['sincronizado']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'galponId': serializer.toJson<String>(galponId),
      'loteId': serializer.toJson<String?>(loteId),
      'fecha': serializer.toJson<DateTime>(fecha),
      'tipoAlimento': serializer.toJson<String>(tipoAlimento),
      'cantidadKg': serializer.toJson<double>(cantidadKg),
      'loteAlimento': serializer.toJson<String?>(loteAlimento),
      'costoUnitario': serializer.toJson<double>(costoUnitario),
      'observaciones': serializer.toJson<String?>(observaciones),
      'sincronizado': serializer.toJson<bool>(sincronizado),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  AlimentacionTableData copyWith(
          {String? id,
          String? galponId,
          Value<String?> loteId = const Value.absent(),
          DateTime? fecha,
          String? tipoAlimento,
          double? cantidadKg,
          Value<String?> loteAlimento = const Value.absent(),
          double? costoUnitario,
          Value<String?> observaciones = const Value.absent(),
          bool? sincronizado,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      AlimentacionTableData(
        id: id ?? this.id,
        galponId: galponId ?? this.galponId,
        loteId: loteId.present ? loteId.value : this.loteId,
        fecha: fecha ?? this.fecha,
        tipoAlimento: tipoAlimento ?? this.tipoAlimento,
        cantidadKg: cantidadKg ?? this.cantidadKg,
        loteAlimento:
            loteAlimento.present ? loteAlimento.value : this.loteAlimento,
        costoUnitario: costoUnitario ?? this.costoUnitario,
        observaciones:
            observaciones.present ? observaciones.value : this.observaciones,
        sincronizado: sincronizado ?? this.sincronizado,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  AlimentacionTableData copyWithCompanion(AlimentacionTableCompanion data) {
    return AlimentacionTableData(
      id: data.id.present ? data.id.value : this.id,
      galponId: data.galponId.present ? data.galponId.value : this.galponId,
      loteId: data.loteId.present ? data.loteId.value : this.loteId,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      tipoAlimento: data.tipoAlimento.present
          ? data.tipoAlimento.value
          : this.tipoAlimento,
      cantidadKg:
          data.cantidadKg.present ? data.cantidadKg.value : this.cantidadKg,
      loteAlimento: data.loteAlimento.present
          ? data.loteAlimento.value
          : this.loteAlimento,
      costoUnitario: data.costoUnitario.present
          ? data.costoUnitario.value
          : this.costoUnitario,
      observaciones: data.observaciones.present
          ? data.observaciones.value
          : this.observaciones,
      sincronizado: data.sincronizado.present
          ? data.sincronizado.value
          : this.sincronizado,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AlimentacionTableData(')
          ..write('id: $id, ')
          ..write('galponId: $galponId, ')
          ..write('loteId: $loteId, ')
          ..write('fecha: $fecha, ')
          ..write('tipoAlimento: $tipoAlimento, ')
          ..write('cantidadKg: $cantidadKg, ')
          ..write('loteAlimento: $loteAlimento, ')
          ..write('costoUnitario: $costoUnitario, ')
          ..write('observaciones: $observaciones, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      galponId,
      loteId,
      fecha,
      tipoAlimento,
      cantidadKg,
      loteAlimento,
      costoUnitario,
      observaciones,
      sincronizado,
      createdAt,
      updatedAt,
      deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AlimentacionTableData &&
          other.id == this.id &&
          other.galponId == this.galponId &&
          other.loteId == this.loteId &&
          other.fecha == this.fecha &&
          other.tipoAlimento == this.tipoAlimento &&
          other.cantidadKg == this.cantidadKg &&
          other.loteAlimento == this.loteAlimento &&
          other.costoUnitario == this.costoUnitario &&
          other.observaciones == this.observaciones &&
          other.sincronizado == this.sincronizado &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class AlimentacionTableCompanion
    extends UpdateCompanion<AlimentacionTableData> {
  final Value<String> id;
  final Value<String> galponId;
  final Value<String?> loteId;
  final Value<DateTime> fecha;
  final Value<String> tipoAlimento;
  final Value<double> cantidadKg;
  final Value<String?> loteAlimento;
  final Value<double> costoUnitario;
  final Value<String?> observaciones;
  final Value<bool> sincronizado;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const AlimentacionTableCompanion({
    this.id = const Value.absent(),
    this.galponId = const Value.absent(),
    this.loteId = const Value.absent(),
    this.fecha = const Value.absent(),
    this.tipoAlimento = const Value.absent(),
    this.cantidadKg = const Value.absent(),
    this.loteAlimento = const Value.absent(),
    this.costoUnitario = const Value.absent(),
    this.observaciones = const Value.absent(),
    this.sincronizado = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AlimentacionTableCompanion.insert({
    required String id,
    required String galponId,
    this.loteId = const Value.absent(),
    required DateTime fecha,
    required String tipoAlimento,
    required double cantidadKg,
    this.loteAlimento = const Value.absent(),
    this.costoUnitario = const Value.absent(),
    this.observaciones = const Value.absent(),
    this.sincronizado = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        galponId = Value(galponId),
        fecha = Value(fecha),
        tipoAlimento = Value(tipoAlimento),
        cantidadKg = Value(cantidadKg),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<AlimentacionTableData> custom({
    Expression<String>? id,
    Expression<String>? galponId,
    Expression<String>? loteId,
    Expression<DateTime>? fecha,
    Expression<String>? tipoAlimento,
    Expression<double>? cantidadKg,
    Expression<String>? loteAlimento,
    Expression<double>? costoUnitario,
    Expression<String>? observaciones,
    Expression<bool>? sincronizado,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (galponId != null) 'galpon_id': galponId,
      if (loteId != null) 'lote_id': loteId,
      if (fecha != null) 'fecha': fecha,
      if (tipoAlimento != null) 'tipo_alimento': tipoAlimento,
      if (cantidadKg != null) 'cantidad_kg': cantidadKg,
      if (loteAlimento != null) 'lote_alimento': loteAlimento,
      if (costoUnitario != null) 'costo_unitario': costoUnitario,
      if (observaciones != null) 'observaciones': observaciones,
      if (sincronizado != null) 'sincronizado': sincronizado,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AlimentacionTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? galponId,
      Value<String?>? loteId,
      Value<DateTime>? fecha,
      Value<String>? tipoAlimento,
      Value<double>? cantidadKg,
      Value<String?>? loteAlimento,
      Value<double>? costoUnitario,
      Value<String?>? observaciones,
      Value<bool>? sincronizado,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<int>? rowid}) {
    return AlimentacionTableCompanion(
      id: id ?? this.id,
      galponId: galponId ?? this.galponId,
      loteId: loteId ?? this.loteId,
      fecha: fecha ?? this.fecha,
      tipoAlimento: tipoAlimento ?? this.tipoAlimento,
      cantidadKg: cantidadKg ?? this.cantidadKg,
      loteAlimento: loteAlimento ?? this.loteAlimento,
      costoUnitario: costoUnitario ?? this.costoUnitario,
      observaciones: observaciones ?? this.observaciones,
      sincronizado: sincronizado ?? this.sincronizado,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (galponId.present) {
      map['galpon_id'] = Variable<String>(galponId.value);
    }
    if (loteId.present) {
      map['lote_id'] = Variable<String>(loteId.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (tipoAlimento.present) {
      map['tipo_alimento'] = Variable<String>(tipoAlimento.value);
    }
    if (cantidadKg.present) {
      map['cantidad_kg'] = Variable<double>(cantidadKg.value);
    }
    if (loteAlimento.present) {
      map['lote_alimento'] = Variable<String>(loteAlimento.value);
    }
    if (costoUnitario.present) {
      map['costo_unitario'] = Variable<double>(costoUnitario.value);
    }
    if (observaciones.present) {
      map['observaciones'] = Variable<String>(observaciones.value);
    }
    if (sincronizado.present) {
      map['sincronizado'] = Variable<bool>(sincronizado.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlimentacionTableCompanion(')
          ..write('id: $id, ')
          ..write('galponId: $galponId, ')
          ..write('loteId: $loteId, ')
          ..write('fecha: $fecha, ')
          ..write('tipoAlimento: $tipoAlimento, ')
          ..write('cantidadKg: $cantidadKg, ')
          ..write('loteAlimento: $loteAlimento, ')
          ..write('costoUnitario: $costoUnitario, ')
          ..write('observaciones: $observaciones, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MortalidadTableTable extends MortalidadTable
    with TableInfo<$MortalidadTableTable, MortalidadTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MortalidadTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _galponIdMeta =
      const VerificationMeta('galponId');
  @override
  late final GeneratedColumn<String> galponId = GeneratedColumn<String>(
      'galpon_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES galpones_table (id)'));
  static const VerificationMeta _loteIdMeta = const VerificationMeta('loteId');
  @override
  late final GeneratedColumn<String> loteId = GeneratedColumn<String>(
      'lote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
      'fecha', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _cantidadMeta =
      const VerificationMeta('cantidad');
  @override
  late final GeneratedColumn<int> cantidad = GeneratedColumn<int>(
      'cantidad', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _causaMeta = const VerificationMeta('causa');
  @override
  late final GeneratedColumn<String> causa = GeneratedColumn<String>(
      'causa', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _observacionesMeta =
      const VerificationMeta('observaciones');
  @override
  late final GeneratedColumn<String> observaciones = GeneratedColumn<String>(
      'observaciones', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sincronizadoMeta =
      const VerificationMeta('sincronizado');
  @override
  late final GeneratedColumn<bool> sincronizado = GeneratedColumn<bool>(
      'sincronizado', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("sincronizado" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        galponId,
        loteId,
        fecha,
        cantidad,
        causa,
        observaciones,
        sincronizado,
        createdAt,
        updatedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mortalidad_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<MortalidadTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('galpon_id')) {
      context.handle(_galponIdMeta,
          galponId.isAcceptableOrUnknown(data['galpon_id']!, _galponIdMeta));
    } else if (isInserting) {
      context.missing(_galponIdMeta);
    }
    if (data.containsKey('lote_id')) {
      context.handle(_loteIdMeta,
          loteId.isAcceptableOrUnknown(data['lote_id']!, _loteIdMeta));
    }
    if (data.containsKey('fecha')) {
      context.handle(
          _fechaMeta, fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta));
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    if (data.containsKey('cantidad')) {
      context.handle(_cantidadMeta,
          cantidad.isAcceptableOrUnknown(data['cantidad']!, _cantidadMeta));
    } else if (isInserting) {
      context.missing(_cantidadMeta);
    }
    if (data.containsKey('causa')) {
      context.handle(
          _causaMeta, causa.isAcceptableOrUnknown(data['causa']!, _causaMeta));
    } else if (isInserting) {
      context.missing(_causaMeta);
    }
    if (data.containsKey('observaciones')) {
      context.handle(
          _observacionesMeta,
          observaciones.isAcceptableOrUnknown(
              data['observaciones']!, _observacionesMeta));
    }
    if (data.containsKey('sincronizado')) {
      context.handle(
          _sincronizadoMeta,
          sincronizado.isAcceptableOrUnknown(
              data['sincronizado']!, _sincronizadoMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MortalidadTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MortalidadTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      galponId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}galpon_id'])!,
      loteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lote_id']),
      fecha: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha'])!,
      cantidad: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cantidad'])!,
      causa: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}causa'])!,
      observaciones: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}observaciones']),
      sincronizado: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}sincronizado'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $MortalidadTableTable createAlias(String alias) {
    return $MortalidadTableTable(attachedDatabase, alias);
  }
}

class MortalidadTableData extends DataClass
    implements Insertable<MortalidadTableData> {
  final String id;
  final String galponId;
  final String? loteId;
  final DateTime fecha;
  final int cantidad;
  final String causa;
  final String? observaciones;
  final bool sincronizado;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const MortalidadTableData(
      {required this.id,
      required this.galponId,
      this.loteId,
      required this.fecha,
      required this.cantidad,
      required this.causa,
      this.observaciones,
      required this.sincronizado,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['galpon_id'] = Variable<String>(galponId);
    if (!nullToAbsent || loteId != null) {
      map['lote_id'] = Variable<String>(loteId);
    }
    map['fecha'] = Variable<DateTime>(fecha);
    map['cantidad'] = Variable<int>(cantidad);
    map['causa'] = Variable<String>(causa);
    if (!nullToAbsent || observaciones != null) {
      map['observaciones'] = Variable<String>(observaciones);
    }
    map['sincronizado'] = Variable<bool>(sincronizado);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  MortalidadTableCompanion toCompanion(bool nullToAbsent) {
    return MortalidadTableCompanion(
      id: Value(id),
      galponId: Value(galponId),
      loteId:
          loteId == null && nullToAbsent ? const Value.absent() : Value(loteId),
      fecha: Value(fecha),
      cantidad: Value(cantidad),
      causa: Value(causa),
      observaciones: observaciones == null && nullToAbsent
          ? const Value.absent()
          : Value(observaciones),
      sincronizado: Value(sincronizado),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory MortalidadTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MortalidadTableData(
      id: serializer.fromJson<String>(json['id']),
      galponId: serializer.fromJson<String>(json['galponId']),
      loteId: serializer.fromJson<String?>(json['loteId']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      cantidad: serializer.fromJson<int>(json['cantidad']),
      causa: serializer.fromJson<String>(json['causa']),
      observaciones: serializer.fromJson<String?>(json['observaciones']),
      sincronizado: serializer.fromJson<bool>(json['sincronizado']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'galponId': serializer.toJson<String>(galponId),
      'loteId': serializer.toJson<String?>(loteId),
      'fecha': serializer.toJson<DateTime>(fecha),
      'cantidad': serializer.toJson<int>(cantidad),
      'causa': serializer.toJson<String>(causa),
      'observaciones': serializer.toJson<String?>(observaciones),
      'sincronizado': serializer.toJson<bool>(sincronizado),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  MortalidadTableData copyWith(
          {String? id,
          String? galponId,
          Value<String?> loteId = const Value.absent(),
          DateTime? fecha,
          int? cantidad,
          String? causa,
          Value<String?> observaciones = const Value.absent(),
          bool? sincronizado,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      MortalidadTableData(
        id: id ?? this.id,
        galponId: galponId ?? this.galponId,
        loteId: loteId.present ? loteId.value : this.loteId,
        fecha: fecha ?? this.fecha,
        cantidad: cantidad ?? this.cantidad,
        causa: causa ?? this.causa,
        observaciones:
            observaciones.present ? observaciones.value : this.observaciones,
        sincronizado: sincronizado ?? this.sincronizado,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  MortalidadTableData copyWithCompanion(MortalidadTableCompanion data) {
    return MortalidadTableData(
      id: data.id.present ? data.id.value : this.id,
      galponId: data.galponId.present ? data.galponId.value : this.galponId,
      loteId: data.loteId.present ? data.loteId.value : this.loteId,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      cantidad: data.cantidad.present ? data.cantidad.value : this.cantidad,
      causa: data.causa.present ? data.causa.value : this.causa,
      observaciones: data.observaciones.present
          ? data.observaciones.value
          : this.observaciones,
      sincronizado: data.sincronizado.present
          ? data.sincronizado.value
          : this.sincronizado,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MortalidadTableData(')
          ..write('id: $id, ')
          ..write('galponId: $galponId, ')
          ..write('loteId: $loteId, ')
          ..write('fecha: $fecha, ')
          ..write('cantidad: $cantidad, ')
          ..write('causa: $causa, ')
          ..write('observaciones: $observaciones, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, galponId, loteId, fecha, cantidad, causa,
      observaciones, sincronizado, createdAt, updatedAt, deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MortalidadTableData &&
          other.id == this.id &&
          other.galponId == this.galponId &&
          other.loteId == this.loteId &&
          other.fecha == this.fecha &&
          other.cantidad == this.cantidad &&
          other.causa == this.causa &&
          other.observaciones == this.observaciones &&
          other.sincronizado == this.sincronizado &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class MortalidadTableCompanion extends UpdateCompanion<MortalidadTableData> {
  final Value<String> id;
  final Value<String> galponId;
  final Value<String?> loteId;
  final Value<DateTime> fecha;
  final Value<int> cantidad;
  final Value<String> causa;
  final Value<String?> observaciones;
  final Value<bool> sincronizado;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const MortalidadTableCompanion({
    this.id = const Value.absent(),
    this.galponId = const Value.absent(),
    this.loteId = const Value.absent(),
    this.fecha = const Value.absent(),
    this.cantidad = const Value.absent(),
    this.causa = const Value.absent(),
    this.observaciones = const Value.absent(),
    this.sincronizado = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MortalidadTableCompanion.insert({
    required String id,
    required String galponId,
    this.loteId = const Value.absent(),
    required DateTime fecha,
    required int cantidad,
    required String causa,
    this.observaciones = const Value.absent(),
    this.sincronizado = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        galponId = Value(galponId),
        fecha = Value(fecha),
        cantidad = Value(cantidad),
        causa = Value(causa),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<MortalidadTableData> custom({
    Expression<String>? id,
    Expression<String>? galponId,
    Expression<String>? loteId,
    Expression<DateTime>? fecha,
    Expression<int>? cantidad,
    Expression<String>? causa,
    Expression<String>? observaciones,
    Expression<bool>? sincronizado,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (galponId != null) 'galpon_id': galponId,
      if (loteId != null) 'lote_id': loteId,
      if (fecha != null) 'fecha': fecha,
      if (cantidad != null) 'cantidad': cantidad,
      if (causa != null) 'causa': causa,
      if (observaciones != null) 'observaciones': observaciones,
      if (sincronizado != null) 'sincronizado': sincronizado,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MortalidadTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? galponId,
      Value<String?>? loteId,
      Value<DateTime>? fecha,
      Value<int>? cantidad,
      Value<String>? causa,
      Value<String?>? observaciones,
      Value<bool>? sincronizado,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<int>? rowid}) {
    return MortalidadTableCompanion(
      id: id ?? this.id,
      galponId: galponId ?? this.galponId,
      loteId: loteId ?? this.loteId,
      fecha: fecha ?? this.fecha,
      cantidad: cantidad ?? this.cantidad,
      causa: causa ?? this.causa,
      observaciones: observaciones ?? this.observaciones,
      sincronizado: sincronizado ?? this.sincronizado,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (galponId.present) {
      map['galpon_id'] = Variable<String>(galponId.value);
    }
    if (loteId.present) {
      map['lote_id'] = Variable<String>(loteId.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (cantidad.present) {
      map['cantidad'] = Variable<int>(cantidad.value);
    }
    if (causa.present) {
      map['causa'] = Variable<String>(causa.value);
    }
    if (observaciones.present) {
      map['observaciones'] = Variable<String>(observaciones.value);
    }
    if (sincronizado.present) {
      map['sincronizado'] = Variable<bool>(sincronizado.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MortalidadTableCompanion(')
          ..write('id: $id, ')
          ..write('galponId: $galponId, ')
          ..write('loteId: $loteId, ')
          ..write('fecha: $fecha, ')
          ..write('cantidad: $cantidad, ')
          ..write('causa: $causa, ')
          ..write('observaciones: $observaciones, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InventarioFotoTableTable extends InventarioFotoTable
    with TableInfo<$InventarioFotoTableTable, InventarioFotoTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventarioFotoTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _galponIdMeta =
      const VerificationMeta('galponId');
  @override
  late final GeneratedColumn<String> galponId = GeneratedColumn<String>(
      'galpon_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES galpones_table (id)'));
  static const VerificationMeta _loteIdMeta = const VerificationMeta('loteId');
  @override
  late final GeneratedColumn<String> loteId = GeneratedColumn<String>(
      'lote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
      'fecha', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _imagenPathMeta =
      const VerificationMeta('imagenPath');
  @override
  late final GeneratedColumn<String> imagenPath = GeneratedColumn<String>(
      'imagen_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _conteoAutomaticoMeta =
      const VerificationMeta('conteoAutomatico');
  @override
  late final GeneratedColumn<int> conteoAutomatico = GeneratedColumn<int>(
      'conteo_automatico', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _conteoManualMeta =
      const VerificationMeta('conteoManual');
  @override
  late final GeneratedColumn<int> conteoManual = GeneratedColumn<int>(
      'conteo_manual', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _conteoFinalMeta =
      const VerificationMeta('conteoFinal');
  @override
  late final GeneratedColumn<int> conteoFinal = GeneratedColumn<int>(
      'conteo_final', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
      'estado', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pendiente'));
  static const VerificationMeta _observacionesMeta =
      const VerificationMeta('observaciones');
  @override
  late final GeneratedColumn<String> observaciones = GeneratedColumn<String>(
      'observaciones', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sincronizadoMeta =
      const VerificationMeta('sincronizado');
  @override
  late final GeneratedColumn<bool> sincronizado = GeneratedColumn<bool>(
      'sincronizado', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("sincronizado" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        galponId,
        loteId,
        fecha,
        imagenPath,
        conteoAutomatico,
        conteoManual,
        conteoFinal,
        estado,
        observaciones,
        sincronizado,
        createdAt,
        updatedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventario_foto_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<InventarioFotoTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('galpon_id')) {
      context.handle(_galponIdMeta,
          galponId.isAcceptableOrUnknown(data['galpon_id']!, _galponIdMeta));
    } else if (isInserting) {
      context.missing(_galponIdMeta);
    }
    if (data.containsKey('lote_id')) {
      context.handle(_loteIdMeta,
          loteId.isAcceptableOrUnknown(data['lote_id']!, _loteIdMeta));
    }
    if (data.containsKey('fecha')) {
      context.handle(
          _fechaMeta, fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta));
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    if (data.containsKey('imagen_path')) {
      context.handle(
          _imagenPathMeta,
          imagenPath.isAcceptableOrUnknown(
              data['imagen_path']!, _imagenPathMeta));
    } else if (isInserting) {
      context.missing(_imagenPathMeta);
    }
    if (data.containsKey('conteo_automatico')) {
      context.handle(
          _conteoAutomaticoMeta,
          conteoAutomatico.isAcceptableOrUnknown(
              data['conteo_automatico']!, _conteoAutomaticoMeta));
    }
    if (data.containsKey('conteo_manual')) {
      context.handle(
          _conteoManualMeta,
          conteoManual.isAcceptableOrUnknown(
              data['conteo_manual']!, _conteoManualMeta));
    }
    if (data.containsKey('conteo_final')) {
      context.handle(
          _conteoFinalMeta,
          conteoFinal.isAcceptableOrUnknown(
              data['conteo_final']!, _conteoFinalMeta));
    } else if (isInserting) {
      context.missing(_conteoFinalMeta);
    }
    if (data.containsKey('estado')) {
      context.handle(_estadoMeta,
          estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta));
    }
    if (data.containsKey('observaciones')) {
      context.handle(
          _observacionesMeta,
          observaciones.isAcceptableOrUnknown(
              data['observaciones']!, _observacionesMeta));
    }
    if (data.containsKey('sincronizado')) {
      context.handle(
          _sincronizadoMeta,
          sincronizado.isAcceptableOrUnknown(
              data['sincronizado']!, _sincronizadoMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InventarioFotoTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InventarioFotoTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      galponId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}galpon_id'])!,
      loteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lote_id']),
      fecha: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha'])!,
      imagenPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}imagen_path'])!,
      conteoAutomatico: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}conteo_automatico'])!,
      conteoManual: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}conteo_manual'])!,
      conteoFinal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}conteo_final'])!,
      estado: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}estado'])!,
      observaciones: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}observaciones']),
      sincronizado: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}sincronizado'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $InventarioFotoTableTable createAlias(String alias) {
    return $InventarioFotoTableTable(attachedDatabase, alias);
  }
}

class InventarioFotoTableData extends DataClass
    implements Insertable<InventarioFotoTableData> {
  final String id;
  final String galponId;
  final String? loteId;
  final DateTime fecha;
  final String imagenPath;
  final int conteoAutomatico;
  final int conteoManual;
  final int conteoFinal;
  final String estado;
  final String? observaciones;
  final bool sincronizado;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const InventarioFotoTableData(
      {required this.id,
      required this.galponId,
      this.loteId,
      required this.fecha,
      required this.imagenPath,
      required this.conteoAutomatico,
      required this.conteoManual,
      required this.conteoFinal,
      required this.estado,
      this.observaciones,
      required this.sincronizado,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['galpon_id'] = Variable<String>(galponId);
    if (!nullToAbsent || loteId != null) {
      map['lote_id'] = Variable<String>(loteId);
    }
    map['fecha'] = Variable<DateTime>(fecha);
    map['imagen_path'] = Variable<String>(imagenPath);
    map['conteo_automatico'] = Variable<int>(conteoAutomatico);
    map['conteo_manual'] = Variable<int>(conteoManual);
    map['conteo_final'] = Variable<int>(conteoFinal);
    map['estado'] = Variable<String>(estado);
    if (!nullToAbsent || observaciones != null) {
      map['observaciones'] = Variable<String>(observaciones);
    }
    map['sincronizado'] = Variable<bool>(sincronizado);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  InventarioFotoTableCompanion toCompanion(bool nullToAbsent) {
    return InventarioFotoTableCompanion(
      id: Value(id),
      galponId: Value(galponId),
      loteId:
          loteId == null && nullToAbsent ? const Value.absent() : Value(loteId),
      fecha: Value(fecha),
      imagenPath: Value(imagenPath),
      conteoAutomatico: Value(conteoAutomatico),
      conteoManual: Value(conteoManual),
      conteoFinal: Value(conteoFinal),
      estado: Value(estado),
      observaciones: observaciones == null && nullToAbsent
          ? const Value.absent()
          : Value(observaciones),
      sincronizado: Value(sincronizado),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory InventarioFotoTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InventarioFotoTableData(
      id: serializer.fromJson<String>(json['id']),
      galponId: serializer.fromJson<String>(json['galponId']),
      loteId: serializer.fromJson<String?>(json['loteId']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      imagenPath: serializer.fromJson<String>(json['imagenPath']),
      conteoAutomatico: serializer.fromJson<int>(json['conteoAutomatico']),
      conteoManual: serializer.fromJson<int>(json['conteoManual']),
      conteoFinal: serializer.fromJson<int>(json['conteoFinal']),
      estado: serializer.fromJson<String>(json['estado']),
      observaciones: serializer.fromJson<String?>(json['observaciones']),
      sincronizado: serializer.fromJson<bool>(json['sincronizado']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'galponId': serializer.toJson<String>(galponId),
      'loteId': serializer.toJson<String?>(loteId),
      'fecha': serializer.toJson<DateTime>(fecha),
      'imagenPath': serializer.toJson<String>(imagenPath),
      'conteoAutomatico': serializer.toJson<int>(conteoAutomatico),
      'conteoManual': serializer.toJson<int>(conteoManual),
      'conteoFinal': serializer.toJson<int>(conteoFinal),
      'estado': serializer.toJson<String>(estado),
      'observaciones': serializer.toJson<String?>(observaciones),
      'sincronizado': serializer.toJson<bool>(sincronizado),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  InventarioFotoTableData copyWith(
          {String? id,
          String? galponId,
          Value<String?> loteId = const Value.absent(),
          DateTime? fecha,
          String? imagenPath,
          int? conteoAutomatico,
          int? conteoManual,
          int? conteoFinal,
          String? estado,
          Value<String?> observaciones = const Value.absent(),
          bool? sincronizado,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      InventarioFotoTableData(
        id: id ?? this.id,
        galponId: galponId ?? this.galponId,
        loteId: loteId.present ? loteId.value : this.loteId,
        fecha: fecha ?? this.fecha,
        imagenPath: imagenPath ?? this.imagenPath,
        conteoAutomatico: conteoAutomatico ?? this.conteoAutomatico,
        conteoManual: conteoManual ?? this.conteoManual,
        conteoFinal: conteoFinal ?? this.conteoFinal,
        estado: estado ?? this.estado,
        observaciones:
            observaciones.present ? observaciones.value : this.observaciones,
        sincronizado: sincronizado ?? this.sincronizado,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  InventarioFotoTableData copyWithCompanion(InventarioFotoTableCompanion data) {
    return InventarioFotoTableData(
      id: data.id.present ? data.id.value : this.id,
      galponId: data.galponId.present ? data.galponId.value : this.galponId,
      loteId: data.loteId.present ? data.loteId.value : this.loteId,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      imagenPath:
          data.imagenPath.present ? data.imagenPath.value : this.imagenPath,
      conteoAutomatico: data.conteoAutomatico.present
          ? data.conteoAutomatico.value
          : this.conteoAutomatico,
      conteoManual: data.conteoManual.present
          ? data.conteoManual.value
          : this.conteoManual,
      conteoFinal:
          data.conteoFinal.present ? data.conteoFinal.value : this.conteoFinal,
      estado: data.estado.present ? data.estado.value : this.estado,
      observaciones: data.observaciones.present
          ? data.observaciones.value
          : this.observaciones,
      sincronizado: data.sincronizado.present
          ? data.sincronizado.value
          : this.sincronizado,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InventarioFotoTableData(')
          ..write('id: $id, ')
          ..write('galponId: $galponId, ')
          ..write('loteId: $loteId, ')
          ..write('fecha: $fecha, ')
          ..write('imagenPath: $imagenPath, ')
          ..write('conteoAutomatico: $conteoAutomatico, ')
          ..write('conteoManual: $conteoManual, ')
          ..write('conteoFinal: $conteoFinal, ')
          ..write('estado: $estado, ')
          ..write('observaciones: $observaciones, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      galponId,
      loteId,
      fecha,
      imagenPath,
      conteoAutomatico,
      conteoManual,
      conteoFinal,
      estado,
      observaciones,
      sincronizado,
      createdAt,
      updatedAt,
      deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InventarioFotoTableData &&
          other.id == this.id &&
          other.galponId == this.galponId &&
          other.loteId == this.loteId &&
          other.fecha == this.fecha &&
          other.imagenPath == this.imagenPath &&
          other.conteoAutomatico == this.conteoAutomatico &&
          other.conteoManual == this.conteoManual &&
          other.conteoFinal == this.conteoFinal &&
          other.estado == this.estado &&
          other.observaciones == this.observaciones &&
          other.sincronizado == this.sincronizado &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class InventarioFotoTableCompanion
    extends UpdateCompanion<InventarioFotoTableData> {
  final Value<String> id;
  final Value<String> galponId;
  final Value<String?> loteId;
  final Value<DateTime> fecha;
  final Value<String> imagenPath;
  final Value<int> conteoAutomatico;
  final Value<int> conteoManual;
  final Value<int> conteoFinal;
  final Value<String> estado;
  final Value<String?> observaciones;
  final Value<bool> sincronizado;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const InventarioFotoTableCompanion({
    this.id = const Value.absent(),
    this.galponId = const Value.absent(),
    this.loteId = const Value.absent(),
    this.fecha = const Value.absent(),
    this.imagenPath = const Value.absent(),
    this.conteoAutomatico = const Value.absent(),
    this.conteoManual = const Value.absent(),
    this.conteoFinal = const Value.absent(),
    this.estado = const Value.absent(),
    this.observaciones = const Value.absent(),
    this.sincronizado = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InventarioFotoTableCompanion.insert({
    required String id,
    required String galponId,
    this.loteId = const Value.absent(),
    required DateTime fecha,
    required String imagenPath,
    this.conteoAutomatico = const Value.absent(),
    this.conteoManual = const Value.absent(),
    required int conteoFinal,
    this.estado = const Value.absent(),
    this.observaciones = const Value.absent(),
    this.sincronizado = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        galponId = Value(galponId),
        fecha = Value(fecha),
        imagenPath = Value(imagenPath),
        conteoFinal = Value(conteoFinal),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<InventarioFotoTableData> custom({
    Expression<String>? id,
    Expression<String>? galponId,
    Expression<String>? loteId,
    Expression<DateTime>? fecha,
    Expression<String>? imagenPath,
    Expression<int>? conteoAutomatico,
    Expression<int>? conteoManual,
    Expression<int>? conteoFinal,
    Expression<String>? estado,
    Expression<String>? observaciones,
    Expression<bool>? sincronizado,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (galponId != null) 'galpon_id': galponId,
      if (loteId != null) 'lote_id': loteId,
      if (fecha != null) 'fecha': fecha,
      if (imagenPath != null) 'imagen_path': imagenPath,
      if (conteoAutomatico != null) 'conteo_automatico': conteoAutomatico,
      if (conteoManual != null) 'conteo_manual': conteoManual,
      if (conteoFinal != null) 'conteo_final': conteoFinal,
      if (estado != null) 'estado': estado,
      if (observaciones != null) 'observaciones': observaciones,
      if (sincronizado != null) 'sincronizado': sincronizado,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InventarioFotoTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? galponId,
      Value<String?>? loteId,
      Value<DateTime>? fecha,
      Value<String>? imagenPath,
      Value<int>? conteoAutomatico,
      Value<int>? conteoManual,
      Value<int>? conteoFinal,
      Value<String>? estado,
      Value<String?>? observaciones,
      Value<bool>? sincronizado,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<int>? rowid}) {
    return InventarioFotoTableCompanion(
      id: id ?? this.id,
      galponId: galponId ?? this.galponId,
      loteId: loteId ?? this.loteId,
      fecha: fecha ?? this.fecha,
      imagenPath: imagenPath ?? this.imagenPath,
      conteoAutomatico: conteoAutomatico ?? this.conteoAutomatico,
      conteoManual: conteoManual ?? this.conteoManual,
      conteoFinal: conteoFinal ?? this.conteoFinal,
      estado: estado ?? this.estado,
      observaciones: observaciones ?? this.observaciones,
      sincronizado: sincronizado ?? this.sincronizado,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (galponId.present) {
      map['galpon_id'] = Variable<String>(galponId.value);
    }
    if (loteId.present) {
      map['lote_id'] = Variable<String>(loteId.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (imagenPath.present) {
      map['imagen_path'] = Variable<String>(imagenPath.value);
    }
    if (conteoAutomatico.present) {
      map['conteo_automatico'] = Variable<int>(conteoAutomatico.value);
    }
    if (conteoManual.present) {
      map['conteo_manual'] = Variable<int>(conteoManual.value);
    }
    if (conteoFinal.present) {
      map['conteo_final'] = Variable<int>(conteoFinal.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    if (observaciones.present) {
      map['observaciones'] = Variable<String>(observaciones.value);
    }
    if (sincronizado.present) {
      map['sincronizado'] = Variable<bool>(sincronizado.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventarioFotoTableCompanion(')
          ..write('id: $id, ')
          ..write('galponId: $galponId, ')
          ..write('loteId: $loteId, ')
          ..write('fecha: $fecha, ')
          ..write('imagenPath: $imagenPath, ')
          ..write('conteoAutomatico: $conteoAutomatico, ')
          ..write('conteoManual: $conteoManual, ')
          ..write('conteoFinal: $conteoFinal, ')
          ..write('estado: $estado, ')
          ..write('observaciones: $observaciones, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueTableTable extends SyncQueueTable
    with TableInfo<$SyncQueueTableTable, SyncQueueTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _operacionMeta =
      const VerificationMeta('operacion');
  @override
  late final GeneratedColumn<String> operacion = GeneratedColumn<String>(
      'operacion', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _entidadMeta =
      const VerificationMeta('entidad');
  @override
  late final GeneratedColumn<String> entidad = GeneratedColumn<String>(
      'entidad', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _entidadIdMeta =
      const VerificationMeta('entidadId');
  @override
  late final GeneratedColumn<String> entidadId = GeneratedColumn<String>(
      'entidad_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _payloadMeta =
      const VerificationMeta('payload');
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
      'payload', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _intentosMeta =
      const VerificationMeta('intentos');
  @override
  late final GeneratedColumn<int> intentos = GeneratedColumn<int>(
      'intentos', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _errorMeta = const VerificationMeta('error');
  @override
  late final GeneratedColumn<String> error = GeneratedColumn<String>(
      'error', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, operacion, entidad, entidadId, payload, intentos, error, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue_table';
  @override
  VerificationContext validateIntegrity(Insertable<SyncQueueTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('operacion')) {
      context.handle(_operacionMeta,
          operacion.isAcceptableOrUnknown(data['operacion']!, _operacionMeta));
    } else if (isInserting) {
      context.missing(_operacionMeta);
    }
    if (data.containsKey('entidad')) {
      context.handle(_entidadMeta,
          entidad.isAcceptableOrUnknown(data['entidad']!, _entidadMeta));
    } else if (isInserting) {
      context.missing(_entidadMeta);
    }
    if (data.containsKey('entidad_id')) {
      context.handle(_entidadIdMeta,
          entidadId.isAcceptableOrUnknown(data['entidad_id']!, _entidadIdMeta));
    } else if (isInserting) {
      context.missing(_entidadIdMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(_payloadMeta,
          payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta));
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('intentos')) {
      context.handle(_intentosMeta,
          intentos.isAcceptableOrUnknown(data['intentos']!, _intentosMeta));
    }
    if (data.containsKey('error')) {
      context.handle(
          _errorMeta, error.isAcceptableOrUnknown(data['error']!, _errorMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      operacion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}operacion'])!,
      entidad: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entidad'])!,
      entidadId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entidad_id'])!,
      payload: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payload'])!,
      intentos: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}intentos'])!,
      error: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}error']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SyncQueueTableTable createAlias(String alias) {
    return $SyncQueueTableTable(attachedDatabase, alias);
  }
}

class SyncQueueTableData extends DataClass
    implements Insertable<SyncQueueTableData> {
  final String id;
  final String operacion;
  final String entidad;
  final String entidadId;
  final String payload;
  final int intentos;
  final String? error;
  final DateTime createdAt;
  const SyncQueueTableData(
      {required this.id,
      required this.operacion,
      required this.entidad,
      required this.entidadId,
      required this.payload,
      required this.intentos,
      this.error,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['operacion'] = Variable<String>(operacion);
    map['entidad'] = Variable<String>(entidad);
    map['entidad_id'] = Variable<String>(entidadId);
    map['payload'] = Variable<String>(payload);
    map['intentos'] = Variable<int>(intentos);
    if (!nullToAbsent || error != null) {
      map['error'] = Variable<String>(error);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SyncQueueTableCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueTableCompanion(
      id: Value(id),
      operacion: Value(operacion),
      entidad: Value(entidad),
      entidadId: Value(entidadId),
      payload: Value(payload),
      intentos: Value(intentos),
      error:
          error == null && nullToAbsent ? const Value.absent() : Value(error),
      createdAt: Value(createdAt),
    );
  }

  factory SyncQueueTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueTableData(
      id: serializer.fromJson<String>(json['id']),
      operacion: serializer.fromJson<String>(json['operacion']),
      entidad: serializer.fromJson<String>(json['entidad']),
      entidadId: serializer.fromJson<String>(json['entidadId']),
      payload: serializer.fromJson<String>(json['payload']),
      intentos: serializer.fromJson<int>(json['intentos']),
      error: serializer.fromJson<String?>(json['error']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'operacion': serializer.toJson<String>(operacion),
      'entidad': serializer.toJson<String>(entidad),
      'entidadId': serializer.toJson<String>(entidadId),
      'payload': serializer.toJson<String>(payload),
      'intentos': serializer.toJson<int>(intentos),
      'error': serializer.toJson<String?>(error),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SyncQueueTableData copyWith(
          {String? id,
          String? operacion,
          String? entidad,
          String? entidadId,
          String? payload,
          int? intentos,
          Value<String?> error = const Value.absent(),
          DateTime? createdAt}) =>
      SyncQueueTableData(
        id: id ?? this.id,
        operacion: operacion ?? this.operacion,
        entidad: entidad ?? this.entidad,
        entidadId: entidadId ?? this.entidadId,
        payload: payload ?? this.payload,
        intentos: intentos ?? this.intentos,
        error: error.present ? error.value : this.error,
        createdAt: createdAt ?? this.createdAt,
      );
  SyncQueueTableData copyWithCompanion(SyncQueueTableCompanion data) {
    return SyncQueueTableData(
      id: data.id.present ? data.id.value : this.id,
      operacion: data.operacion.present ? data.operacion.value : this.operacion,
      entidad: data.entidad.present ? data.entidad.value : this.entidad,
      entidadId: data.entidadId.present ? data.entidadId.value : this.entidadId,
      payload: data.payload.present ? data.payload.value : this.payload,
      intentos: data.intentos.present ? data.intentos.value : this.intentos,
      error: data.error.present ? data.error.value : this.error,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueTableData(')
          ..write('id: $id, ')
          ..write('operacion: $operacion, ')
          ..write('entidad: $entidad, ')
          ..write('entidadId: $entidadId, ')
          ..write('payload: $payload, ')
          ..write('intentos: $intentos, ')
          ..write('error: $error, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, operacion, entidad, entidadId, payload, intentos, error, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueTableData &&
          other.id == this.id &&
          other.operacion == this.operacion &&
          other.entidad == this.entidad &&
          other.entidadId == this.entidadId &&
          other.payload == this.payload &&
          other.intentos == this.intentos &&
          other.error == this.error &&
          other.createdAt == this.createdAt);
}

class SyncQueueTableCompanion extends UpdateCompanion<SyncQueueTableData> {
  final Value<String> id;
  final Value<String> operacion;
  final Value<String> entidad;
  final Value<String> entidadId;
  final Value<String> payload;
  final Value<int> intentos;
  final Value<String?> error;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SyncQueueTableCompanion({
    this.id = const Value.absent(),
    this.operacion = const Value.absent(),
    this.entidad = const Value.absent(),
    this.entidadId = const Value.absent(),
    this.payload = const Value.absent(),
    this.intentos = const Value.absent(),
    this.error = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncQueueTableCompanion.insert({
    required String id,
    required String operacion,
    required String entidad,
    required String entidadId,
    required String payload,
    this.intentos = const Value.absent(),
    this.error = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        operacion = Value(operacion),
        entidad = Value(entidad),
        entidadId = Value(entidadId),
        payload = Value(payload),
        createdAt = Value(createdAt);
  static Insertable<SyncQueueTableData> custom({
    Expression<String>? id,
    Expression<String>? operacion,
    Expression<String>? entidad,
    Expression<String>? entidadId,
    Expression<String>? payload,
    Expression<int>? intentos,
    Expression<String>? error,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (operacion != null) 'operacion': operacion,
      if (entidad != null) 'entidad': entidad,
      if (entidadId != null) 'entidad_id': entidadId,
      if (payload != null) 'payload': payload,
      if (intentos != null) 'intentos': intentos,
      if (error != null) 'error': error,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncQueueTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? operacion,
      Value<String>? entidad,
      Value<String>? entidadId,
      Value<String>? payload,
      Value<int>? intentos,
      Value<String?>? error,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return SyncQueueTableCompanion(
      id: id ?? this.id,
      operacion: operacion ?? this.operacion,
      entidad: entidad ?? this.entidad,
      entidadId: entidadId ?? this.entidadId,
      payload: payload ?? this.payload,
      intentos: intentos ?? this.intentos,
      error: error ?? this.error,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (operacion.present) {
      map['operacion'] = Variable<String>(operacion.value);
    }
    if (entidad.present) {
      map['entidad'] = Variable<String>(entidad.value);
    }
    if (entidadId.present) {
      map['entidad_id'] = Variable<String>(entidadId.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (intentos.present) {
      map['intentos'] = Variable<int>(intentos.value);
    }
    if (error.present) {
      map['error'] = Variable<String>(error.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueTableCompanion(')
          ..write('id: $id, ')
          ..write('operacion: $operacion, ')
          ..write('entidad: $entidad, ')
          ..write('entidadId: $entidadId, ')
          ..write('payload: $payload, ')
          ..write('intentos: $intentos, ')
          ..write('error: $error, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UsuariosTableTable extends UsuariosTable
    with TableInfo<$UsuariosTableTable, UsuariosTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsuariosTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _rolMeta = const VerificationMeta('rol');
  @override
  late final GeneratedColumn<String> rol = GeneratedColumn<String>(
      'rol', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _telefonoMeta =
      const VerificationMeta('telefono');
  @override
  late final GeneratedColumn<String> telefono = GeneratedColumn<String>(
      'telefono', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _activoMeta = const VerificationMeta('activo');
  @override
  late final GeneratedColumn<bool> activo = GeneratedColumn<bool>(
      'activo', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("activo" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _ultimoAccesoMeta =
      const VerificationMeta('ultimoAcceso');
  @override
  late final GeneratedColumn<DateTime> ultimoAcceso = GeneratedColumn<DateTime>(
      'ultimo_acceso', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        email,
        nombre,
        rol,
        telefono,
        activo,
        ultimoAcceso,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'usuarios_table';
  @override
  VerificationContext validateIntegrity(Insertable<UsuariosTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('rol')) {
      context.handle(
          _rolMeta, rol.isAcceptableOrUnknown(data['rol']!, _rolMeta));
    } else if (isInserting) {
      context.missing(_rolMeta);
    }
    if (data.containsKey('telefono')) {
      context.handle(_telefonoMeta,
          telefono.isAcceptableOrUnknown(data['telefono']!, _telefonoMeta));
    }
    if (data.containsKey('activo')) {
      context.handle(_activoMeta,
          activo.isAcceptableOrUnknown(data['activo']!, _activoMeta));
    }
    if (data.containsKey('ultimo_acceso')) {
      context.handle(
          _ultimoAccesoMeta,
          ultimoAcceso.isAcceptableOrUnknown(
              data['ultimo_acceso']!, _ultimoAccesoMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UsuariosTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UsuariosTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre'])!,
      rol: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}rol'])!,
      telefono: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}telefono']),
      activo: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}activo'])!,
      ultimoAcceso: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}ultimo_acceso']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $UsuariosTableTable createAlias(String alias) {
    return $UsuariosTableTable(attachedDatabase, alias);
  }
}

class UsuariosTableData extends DataClass
    implements Insertable<UsuariosTableData> {
  final String id;
  final String email;
  final String nombre;
  final String rol;
  final String? telefono;
  final bool activo;
  final DateTime? ultimoAcceso;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UsuariosTableData(
      {required this.id,
      required this.email,
      required this.nombre,
      required this.rol,
      this.telefono,
      required this.activo,
      this.ultimoAcceso,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['email'] = Variable<String>(email);
    map['nombre'] = Variable<String>(nombre);
    map['rol'] = Variable<String>(rol);
    if (!nullToAbsent || telefono != null) {
      map['telefono'] = Variable<String>(telefono);
    }
    map['activo'] = Variable<bool>(activo);
    if (!nullToAbsent || ultimoAcceso != null) {
      map['ultimo_acceso'] = Variable<DateTime>(ultimoAcceso);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UsuariosTableCompanion toCompanion(bool nullToAbsent) {
    return UsuariosTableCompanion(
      id: Value(id),
      email: Value(email),
      nombre: Value(nombre),
      rol: Value(rol),
      telefono: telefono == null && nullToAbsent
          ? const Value.absent()
          : Value(telefono),
      activo: Value(activo),
      ultimoAcceso: ultimoAcceso == null && nullToAbsent
          ? const Value.absent()
          : Value(ultimoAcceso),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UsuariosTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UsuariosTableData(
      id: serializer.fromJson<String>(json['id']),
      email: serializer.fromJson<String>(json['email']),
      nombre: serializer.fromJson<String>(json['nombre']),
      rol: serializer.fromJson<String>(json['rol']),
      telefono: serializer.fromJson<String?>(json['telefono']),
      activo: serializer.fromJson<bool>(json['activo']),
      ultimoAcceso: serializer.fromJson<DateTime?>(json['ultimoAcceso']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'email': serializer.toJson<String>(email),
      'nombre': serializer.toJson<String>(nombre),
      'rol': serializer.toJson<String>(rol),
      'telefono': serializer.toJson<String?>(telefono),
      'activo': serializer.toJson<bool>(activo),
      'ultimoAcceso': serializer.toJson<DateTime?>(ultimoAcceso),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UsuariosTableData copyWith(
          {String? id,
          String? email,
          String? nombre,
          String? rol,
          Value<String?> telefono = const Value.absent(),
          bool? activo,
          Value<DateTime?> ultimoAcceso = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      UsuariosTableData(
        id: id ?? this.id,
        email: email ?? this.email,
        nombre: nombre ?? this.nombre,
        rol: rol ?? this.rol,
        telefono: telefono.present ? telefono.value : this.telefono,
        activo: activo ?? this.activo,
        ultimoAcceso:
            ultimoAcceso.present ? ultimoAcceso.value : this.ultimoAcceso,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  UsuariosTableData copyWithCompanion(UsuariosTableCompanion data) {
    return UsuariosTableData(
      id: data.id.present ? data.id.value : this.id,
      email: data.email.present ? data.email.value : this.email,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      rol: data.rol.present ? data.rol.value : this.rol,
      telefono: data.telefono.present ? data.telefono.value : this.telefono,
      activo: data.activo.present ? data.activo.value : this.activo,
      ultimoAcceso: data.ultimoAcceso.present
          ? data.ultimoAcceso.value
          : this.ultimoAcceso,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UsuariosTableData(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('nombre: $nombre, ')
          ..write('rol: $rol, ')
          ..write('telefono: $telefono, ')
          ..write('activo: $activo, ')
          ..write('ultimoAcceso: $ultimoAcceso, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, email, nombre, rol, telefono, activo,
      ultimoAcceso, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UsuariosTableData &&
          other.id == this.id &&
          other.email == this.email &&
          other.nombre == this.nombre &&
          other.rol == this.rol &&
          other.telefono == this.telefono &&
          other.activo == this.activo &&
          other.ultimoAcceso == this.ultimoAcceso &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UsuariosTableCompanion extends UpdateCompanion<UsuariosTableData> {
  final Value<String> id;
  final Value<String> email;
  final Value<String> nombre;
  final Value<String> rol;
  final Value<String?> telefono;
  final Value<bool> activo;
  final Value<DateTime?> ultimoAcceso;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const UsuariosTableCompanion({
    this.id = const Value.absent(),
    this.email = const Value.absent(),
    this.nombre = const Value.absent(),
    this.rol = const Value.absent(),
    this.telefono = const Value.absent(),
    this.activo = const Value.absent(),
    this.ultimoAcceso = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsuariosTableCompanion.insert({
    required String id,
    required String email,
    required String nombre,
    required String rol,
    this.telefono = const Value.absent(),
    this.activo = const Value.absent(),
    this.ultimoAcceso = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        email = Value(email),
        nombre = Value(nombre),
        rol = Value(rol),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<UsuariosTableData> custom({
    Expression<String>? id,
    Expression<String>? email,
    Expression<String>? nombre,
    Expression<String>? rol,
    Expression<String>? telefono,
    Expression<bool>? activo,
    Expression<DateTime>? ultimoAcceso,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (email != null) 'email': email,
      if (nombre != null) 'nombre': nombre,
      if (rol != null) 'rol': rol,
      if (telefono != null) 'telefono': telefono,
      if (activo != null) 'activo': activo,
      if (ultimoAcceso != null) 'ultimo_acceso': ultimoAcceso,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsuariosTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? email,
      Value<String>? nombre,
      Value<String>? rol,
      Value<String?>? telefono,
      Value<bool>? activo,
      Value<DateTime?>? ultimoAcceso,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return UsuariosTableCompanion(
      id: id ?? this.id,
      email: email ?? this.email,
      nombre: nombre ?? this.nombre,
      rol: rol ?? this.rol,
      telefono: telefono ?? this.telefono,
      activo: activo ?? this.activo,
      ultimoAcceso: ultimoAcceso ?? this.ultimoAcceso,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (rol.present) {
      map['rol'] = Variable<String>(rol.value);
    }
    if (telefono.present) {
      map['telefono'] = Variable<String>(telefono.value);
    }
    if (activo.present) {
      map['activo'] = Variable<bool>(activo.value);
    }
    if (ultimoAcceso.present) {
      map['ultimo_acceso'] = Variable<DateTime>(ultimoAcceso.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsuariosTableCompanion(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('nombre: $nombre, ')
          ..write('rol: $rol, ')
          ..write('telefono: $telefono, ')
          ..write('activo: $activo, ')
          ..write('ultimoAcceso: $ultimoAcceso, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $GalponesTableTable galponesTable = $GalponesTableTable(this);
  late final $LotesAvesTableTable lotesAvesTable = $LotesAvesTableTable(this);
  late final $ProduccionHuevosTableTable produccionHuevosTable =
      $ProduccionHuevosTableTable(this);
  late final $EventosSanitariosTableTable eventosSanitariosTable =
      $EventosSanitariosTableTable(this);
  late final $AlimentacionTableTable alimentacionTable =
      $AlimentacionTableTable(this);
  late final $MortalidadTableTable mortalidadTable =
      $MortalidadTableTable(this);
  late final $InventarioFotoTableTable inventarioFotoTable =
      $InventarioFotoTableTable(this);
  late final $SyncQueueTableTable syncQueueTable = $SyncQueueTableTable(this);
  late final $UsuariosTableTable usuariosTable = $UsuariosTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        galponesTable,
        lotesAvesTable,
        produccionHuevosTable,
        eventosSanitariosTable,
        alimentacionTable,
        mortalidadTable,
        inventarioFotoTable,
        syncQueueTable,
        usuariosTable
      ];
}

typedef $$GalponesTableTableCreateCompanionBuilder = GalponesTableCompanion
    Function({
  required String id,
  required String nombre,
  Value<String?> descripcion,
  required int capacidadMaxima,
  Value<int> cantidadActual,
  Value<String?> ubicacion,
  Value<bool> activo,
  Value<bool> sincronizado,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});
typedef $$GalponesTableTableUpdateCompanionBuilder = GalponesTableCompanion
    Function({
  Value<String> id,
  Value<String> nombre,
  Value<String?> descripcion,
  Value<int> capacidadMaxima,
  Value<int> cantidadActual,
  Value<String?> ubicacion,
  Value<bool> activo,
  Value<bool> sincronizado,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});

final class $$GalponesTableTableReferences extends BaseReferences<_$AppDatabase,
    $GalponesTableTable, GalponesTableData> {
  $$GalponesTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$LotesAvesTableTable, List<LotesAvesTableData>>
      _lotesAvesTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.lotesAvesTable,
              aliasName: $_aliasNameGenerator(
                  db.galponesTable.id, db.lotesAvesTable.galponId));

  $$LotesAvesTableTableProcessedTableManager get lotesAvesTableRefs {
    final manager = $$LotesAvesTableTableTableManager($_db, $_db.lotesAvesTable)
        .filter((f) => f.galponId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_lotesAvesTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ProduccionHuevosTableTable,
      List<ProduccionHuevosTableData>> _produccionHuevosTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.produccionHuevosTable,
          aliasName: $_aliasNameGenerator(
              db.galponesTable.id, db.produccionHuevosTable.galponId));

  $$ProduccionHuevosTableTableProcessedTableManager
      get produccionHuevosTableRefs {
    final manager = $$ProduccionHuevosTableTableTableManager(
            $_db, $_db.produccionHuevosTable)
        .filter((f) => f.galponId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_produccionHuevosTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$EventosSanitariosTableTable,
      List<EventosSanitariosTableData>> _eventosSanitariosTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.eventosSanitariosTable,
          aliasName: $_aliasNameGenerator(
              db.galponesTable.id, db.eventosSanitariosTable.galponId));

  $$EventosSanitariosTableTableProcessedTableManager
      get eventosSanitariosTableRefs {
    final manager = $$EventosSanitariosTableTableTableManager(
            $_db, $_db.eventosSanitariosTable)
        .filter((f) => f.galponId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_eventosSanitariosTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$AlimentacionTableTable,
      List<AlimentacionTableData>> _alimentacionTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.alimentacionTable,
          aliasName: $_aliasNameGenerator(
              db.galponesTable.id, db.alimentacionTable.galponId));

  $$AlimentacionTableTableProcessedTableManager get alimentacionTableRefs {
    final manager =
        $$AlimentacionTableTableTableManager($_db, $_db.alimentacionTable)
            .filter((f) => f.galponId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_alimentacionTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$MortalidadTableTable, List<MortalidadTableData>>
      _mortalidadTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.mortalidadTable,
              aliasName: $_aliasNameGenerator(
                  db.galponesTable.id, db.mortalidadTable.galponId));

  $$MortalidadTableTableProcessedTableManager get mortalidadTableRefs {
    final manager =
        $$MortalidadTableTableTableManager($_db, $_db.mortalidadTable)
            .filter((f) => f.galponId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_mortalidadTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$InventarioFotoTableTable,
      List<InventarioFotoTableData>> _inventarioFotoTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.inventarioFotoTable,
          aliasName: $_aliasNameGenerator(
              db.galponesTable.id, db.inventarioFotoTable.galponId));

  $$InventarioFotoTableTableProcessedTableManager get inventarioFotoTableRefs {
    final manager =
        $$InventarioFotoTableTableTableManager($_db, $_db.inventarioFotoTable)
            .filter((f) => f.galponId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_inventarioFotoTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$GalponesTableTableFilterComposer
    extends Composer<_$AppDatabase, $GalponesTableTable> {
  $$GalponesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get capacidadMaxima => $composableBuilder(
      column: $table.capacidadMaxima,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get cantidadActual => $composableBuilder(
      column: $table.cantidadActual,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ubicacion => $composableBuilder(
      column: $table.ubicacion, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get activo => $composableBuilder(
      column: $table.activo, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> lotesAvesTableRefs(
      Expression<bool> Function($$LotesAvesTableTableFilterComposer f) f) {
    final $$LotesAvesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.lotesAvesTable,
        getReferencedColumn: (t) => t.galponId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LotesAvesTableTableFilterComposer(
              $db: $db,
              $table: $db.lotesAvesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> produccionHuevosTableRefs(
      Expression<bool> Function($$ProduccionHuevosTableTableFilterComposer f)
          f) {
    final $$ProduccionHuevosTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.produccionHuevosTable,
            getReferencedColumn: (t) => t.galponId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ProduccionHuevosTableTableFilterComposer(
                  $db: $db,
                  $table: $db.produccionHuevosTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<bool> eventosSanitariosTableRefs(
      Expression<bool> Function($$EventosSanitariosTableTableFilterComposer f)
          f) {
    final $$EventosSanitariosTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.eventosSanitariosTable,
            getReferencedColumn: (t) => t.galponId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$EventosSanitariosTableTableFilterComposer(
                  $db: $db,
                  $table: $db.eventosSanitariosTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<bool> alimentacionTableRefs(
      Expression<bool> Function($$AlimentacionTableTableFilterComposer f) f) {
    final $$AlimentacionTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.alimentacionTable,
        getReferencedColumn: (t) => t.galponId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AlimentacionTableTableFilterComposer(
              $db: $db,
              $table: $db.alimentacionTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> mortalidadTableRefs(
      Expression<bool> Function($$MortalidadTableTableFilterComposer f) f) {
    final $$MortalidadTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.mortalidadTable,
        getReferencedColumn: (t) => t.galponId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MortalidadTableTableFilterComposer(
              $db: $db,
              $table: $db.mortalidadTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> inventarioFotoTableRefs(
      Expression<bool> Function($$InventarioFotoTableTableFilterComposer f) f) {
    final $$InventarioFotoTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.inventarioFotoTable,
        getReferencedColumn: (t) => t.galponId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$InventarioFotoTableTableFilterComposer(
              $db: $db,
              $table: $db.inventarioFotoTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$GalponesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $GalponesTableTable> {
  $$GalponesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get capacidadMaxima => $composableBuilder(
      column: $table.capacidadMaxima,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cantidadActual => $composableBuilder(
      column: $table.cantidadActual,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ubicacion => $composableBuilder(
      column: $table.ubicacion, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get activo => $composableBuilder(
      column: $table.activo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));
}

class $$GalponesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $GalponesTableTable> {
  $$GalponesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => column);

  GeneratedColumn<int> get capacidadMaxima => $composableBuilder(
      column: $table.capacidadMaxima, builder: (column) => column);

  GeneratedColumn<int> get cantidadActual => $composableBuilder(
      column: $table.cantidadActual, builder: (column) => column);

  GeneratedColumn<String> get ubicacion =>
      $composableBuilder(column: $table.ubicacion, builder: (column) => column);

  GeneratedColumn<bool> get activo =>
      $composableBuilder(column: $table.activo, builder: (column) => column);

  GeneratedColumn<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  Expression<T> lotesAvesTableRefs<T extends Object>(
      Expression<T> Function($$LotesAvesTableTableAnnotationComposer a) f) {
    final $$LotesAvesTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.lotesAvesTable,
        getReferencedColumn: (t) => t.galponId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LotesAvesTableTableAnnotationComposer(
              $db: $db,
              $table: $db.lotesAvesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> produccionHuevosTableRefs<T extends Object>(
      Expression<T> Function($$ProduccionHuevosTableTableAnnotationComposer a)
          f) {
    final $$ProduccionHuevosTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.produccionHuevosTable,
            getReferencedColumn: (t) => t.galponId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ProduccionHuevosTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.produccionHuevosTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> eventosSanitariosTableRefs<T extends Object>(
      Expression<T> Function($$EventosSanitariosTableTableAnnotationComposer a)
          f) {
    final $$EventosSanitariosTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.eventosSanitariosTable,
            getReferencedColumn: (t) => t.galponId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$EventosSanitariosTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.eventosSanitariosTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> alimentacionTableRefs<T extends Object>(
      Expression<T> Function($$AlimentacionTableTableAnnotationComposer a) f) {
    final $$AlimentacionTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.alimentacionTable,
            getReferencedColumn: (t) => t.galponId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$AlimentacionTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.alimentacionTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> mortalidadTableRefs<T extends Object>(
      Expression<T> Function($$MortalidadTableTableAnnotationComposer a) f) {
    final $$MortalidadTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.mortalidadTable,
        getReferencedColumn: (t) => t.galponId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MortalidadTableTableAnnotationComposer(
              $db: $db,
              $table: $db.mortalidadTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> inventarioFotoTableRefs<T extends Object>(
      Expression<T> Function($$InventarioFotoTableTableAnnotationComposer a)
          f) {
    final $$InventarioFotoTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.inventarioFotoTable,
            getReferencedColumn: (t) => t.galponId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$InventarioFotoTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.inventarioFotoTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$GalponesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GalponesTableTable,
    GalponesTableData,
    $$GalponesTableTableFilterComposer,
    $$GalponesTableTableOrderingComposer,
    $$GalponesTableTableAnnotationComposer,
    $$GalponesTableTableCreateCompanionBuilder,
    $$GalponesTableTableUpdateCompanionBuilder,
    (GalponesTableData, $$GalponesTableTableReferences),
    GalponesTableData,
    PrefetchHooks Function(
        {bool lotesAvesTableRefs,
        bool produccionHuevosTableRefs,
        bool eventosSanitariosTableRefs,
        bool alimentacionTableRefs,
        bool mortalidadTableRefs,
        bool inventarioFotoTableRefs})> {
  $$GalponesTableTableTableManager(_$AppDatabase db, $GalponesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GalponesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GalponesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GalponesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> nombre = const Value.absent(),
            Value<String?> descripcion = const Value.absent(),
            Value<int> capacidadMaxima = const Value.absent(),
            Value<int> cantidadActual = const Value.absent(),
            Value<String?> ubicacion = const Value.absent(),
            Value<bool> activo = const Value.absent(),
            Value<bool> sincronizado = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GalponesTableCompanion(
            id: id,
            nombre: nombre,
            descripcion: descripcion,
            capacidadMaxima: capacidadMaxima,
            cantidadActual: cantidadActual,
            ubicacion: ubicacion,
            activo: activo,
            sincronizado: sincronizado,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String nombre,
            Value<String?> descripcion = const Value.absent(),
            required int capacidadMaxima,
            Value<int> cantidadActual = const Value.absent(),
            Value<String?> ubicacion = const Value.absent(),
            Value<bool> activo = const Value.absent(),
            Value<bool> sincronizado = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GalponesTableCompanion.insert(
            id: id,
            nombre: nombre,
            descripcion: descripcion,
            capacidadMaxima: capacidadMaxima,
            cantidadActual: cantidadActual,
            ubicacion: ubicacion,
            activo: activo,
            sincronizado: sincronizado,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$GalponesTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {lotesAvesTableRefs = false,
              produccionHuevosTableRefs = false,
              eventosSanitariosTableRefs = false,
              alimentacionTableRefs = false,
              mortalidadTableRefs = false,
              inventarioFotoTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (lotesAvesTableRefs) db.lotesAvesTable,
                if (produccionHuevosTableRefs) db.produccionHuevosTable,
                if (eventosSanitariosTableRefs) db.eventosSanitariosTable,
                if (alimentacionTableRefs) db.alimentacionTable,
                if (mortalidadTableRefs) db.mortalidadTable,
                if (inventarioFotoTableRefs) db.inventarioFotoTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (lotesAvesTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$GalponesTableTableReferences
                            ._lotesAvesTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$GalponesTableTableReferences(db, table, p0)
                                .lotesAvesTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.galponId == item.id),
                        typedResults: items),
                  if (produccionHuevosTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$GalponesTableTableReferences
                            ._produccionHuevosTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$GalponesTableTableReferences(db, table, p0)
                                .produccionHuevosTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.galponId == item.id),
                        typedResults: items),
                  if (eventosSanitariosTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$GalponesTableTableReferences
                            ._eventosSanitariosTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$GalponesTableTableReferences(db, table, p0)
                                .eventosSanitariosTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.galponId == item.id),
                        typedResults: items),
                  if (alimentacionTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$GalponesTableTableReferences
                            ._alimentacionTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$GalponesTableTableReferences(db, table, p0)
                                .alimentacionTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.galponId == item.id),
                        typedResults: items),
                  if (mortalidadTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$GalponesTableTableReferences
                            ._mortalidadTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$GalponesTableTableReferences(db, table, p0)
                                .mortalidadTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.galponId == item.id),
                        typedResults: items),
                  if (inventarioFotoTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$GalponesTableTableReferences
                            ._inventarioFotoTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$GalponesTableTableReferences(db, table, p0)
                                .inventarioFotoTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.galponId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$GalponesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $GalponesTableTable,
    GalponesTableData,
    $$GalponesTableTableFilterComposer,
    $$GalponesTableTableOrderingComposer,
    $$GalponesTableTableAnnotationComposer,
    $$GalponesTableTableCreateCompanionBuilder,
    $$GalponesTableTableUpdateCompanionBuilder,
    (GalponesTableData, $$GalponesTableTableReferences),
    GalponesTableData,
    PrefetchHooks Function(
        {bool lotesAvesTableRefs,
        bool produccionHuevosTableRefs,
        bool eventosSanitariosTableRefs,
        bool alimentacionTableRefs,
        bool mortalidadTableRefs,
        bool inventarioFotoTableRefs})>;
typedef $$LotesAvesTableTableCreateCompanionBuilder = LotesAvesTableCompanion
    Function({
  required String id,
  required String galponId,
  required String codigo,
  required int cantidadInicial,
  required int cantidadActual,
  required DateTime fechaIngreso,
  Value<String?> raza,
  Value<int> edadSemanas,
  Value<String> estado,
  Value<bool> sincronizado,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});
typedef $$LotesAvesTableTableUpdateCompanionBuilder = LotesAvesTableCompanion
    Function({
  Value<String> id,
  Value<String> galponId,
  Value<String> codigo,
  Value<int> cantidadInicial,
  Value<int> cantidadActual,
  Value<DateTime> fechaIngreso,
  Value<String?> raza,
  Value<int> edadSemanas,
  Value<String> estado,
  Value<bool> sincronizado,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});

final class $$LotesAvesTableTableReferences extends BaseReferences<
    _$AppDatabase, $LotesAvesTableTable, LotesAvesTableData> {
  $$LotesAvesTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $GalponesTableTable _galponIdTable(_$AppDatabase db) =>
      db.galponesTable.createAlias($_aliasNameGenerator(
          db.lotesAvesTable.galponId, db.galponesTable.id));

  $$GalponesTableTableProcessedTableManager? get galponId {
    if ($_item.galponId == null) return null;
    final manager = $$GalponesTableTableTableManager($_db, $_db.galponesTable)
        .filter((f) => f.id($_item.galponId!));
    final item = $_typedResult.readTableOrNull(_galponIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$LotesAvesTableTableFilterComposer
    extends Composer<_$AppDatabase, $LotesAvesTableTable> {
  $$LotesAvesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get codigo => $composableBuilder(
      column: $table.codigo, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get cantidadInicial => $composableBuilder(
      column: $table.cantidadInicial,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get cantidadActual => $composableBuilder(
      column: $table.cantidadActual,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fechaIngreso => $composableBuilder(
      column: $table.fechaIngreso, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get raza => $composableBuilder(
      column: $table.raza, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get edadSemanas => $composableBuilder(
      column: $table.edadSemanas, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get estado => $composableBuilder(
      column: $table.estado, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  $$GalponesTableTableFilterComposer get galponId {
    final $$GalponesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.galponId,
        referencedTable: $db.galponesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GalponesTableTableFilterComposer(
              $db: $db,
              $table: $db.galponesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LotesAvesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $LotesAvesTableTable> {
  $$LotesAvesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get codigo => $composableBuilder(
      column: $table.codigo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cantidadInicial => $composableBuilder(
      column: $table.cantidadInicial,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cantidadActual => $composableBuilder(
      column: $table.cantidadActual,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fechaIngreso => $composableBuilder(
      column: $table.fechaIngreso,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get raza => $composableBuilder(
      column: $table.raza, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get edadSemanas => $composableBuilder(
      column: $table.edadSemanas, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get estado => $composableBuilder(
      column: $table.estado, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  $$GalponesTableTableOrderingComposer get galponId {
    final $$GalponesTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.galponId,
        referencedTable: $db.galponesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GalponesTableTableOrderingComposer(
              $db: $db,
              $table: $db.galponesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LotesAvesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $LotesAvesTableTable> {
  $$LotesAvesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get codigo =>
      $composableBuilder(column: $table.codigo, builder: (column) => column);

  GeneratedColumn<int> get cantidadInicial => $composableBuilder(
      column: $table.cantidadInicial, builder: (column) => column);

  GeneratedColumn<int> get cantidadActual => $composableBuilder(
      column: $table.cantidadActual, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaIngreso => $composableBuilder(
      column: $table.fechaIngreso, builder: (column) => column);

  GeneratedColumn<String> get raza =>
      $composableBuilder(column: $table.raza, builder: (column) => column);

  GeneratedColumn<int> get edadSemanas => $composableBuilder(
      column: $table.edadSemanas, builder: (column) => column);

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$GalponesTableTableAnnotationComposer get galponId {
    final $$GalponesTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.galponId,
        referencedTable: $db.galponesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GalponesTableTableAnnotationComposer(
              $db: $db,
              $table: $db.galponesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LotesAvesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LotesAvesTableTable,
    LotesAvesTableData,
    $$LotesAvesTableTableFilterComposer,
    $$LotesAvesTableTableOrderingComposer,
    $$LotesAvesTableTableAnnotationComposer,
    $$LotesAvesTableTableCreateCompanionBuilder,
    $$LotesAvesTableTableUpdateCompanionBuilder,
    (LotesAvesTableData, $$LotesAvesTableTableReferences),
    LotesAvesTableData,
    PrefetchHooks Function({bool galponId})> {
  $$LotesAvesTableTableTableManager(
      _$AppDatabase db, $LotesAvesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LotesAvesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LotesAvesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LotesAvesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> galponId = const Value.absent(),
            Value<String> codigo = const Value.absent(),
            Value<int> cantidadInicial = const Value.absent(),
            Value<int> cantidadActual = const Value.absent(),
            Value<DateTime> fechaIngreso = const Value.absent(),
            Value<String?> raza = const Value.absent(),
            Value<int> edadSemanas = const Value.absent(),
            Value<String> estado = const Value.absent(),
            Value<bool> sincronizado = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LotesAvesTableCompanion(
            id: id,
            galponId: galponId,
            codigo: codigo,
            cantidadInicial: cantidadInicial,
            cantidadActual: cantidadActual,
            fechaIngreso: fechaIngreso,
            raza: raza,
            edadSemanas: edadSemanas,
            estado: estado,
            sincronizado: sincronizado,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String galponId,
            required String codigo,
            required int cantidadInicial,
            required int cantidadActual,
            required DateTime fechaIngreso,
            Value<String?> raza = const Value.absent(),
            Value<int> edadSemanas = const Value.absent(),
            Value<String> estado = const Value.absent(),
            Value<bool> sincronizado = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LotesAvesTableCompanion.insert(
            id: id,
            galponId: galponId,
            codigo: codigo,
            cantidadInicial: cantidadInicial,
            cantidadActual: cantidadActual,
            fechaIngreso: fechaIngreso,
            raza: raza,
            edadSemanas: edadSemanas,
            estado: estado,
            sincronizado: sincronizado,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$LotesAvesTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({galponId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (galponId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.galponId,
                    referencedTable:
                        $$LotesAvesTableTableReferences._galponIdTable(db),
                    referencedColumn:
                        $$LotesAvesTableTableReferences._galponIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$LotesAvesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LotesAvesTableTable,
    LotesAvesTableData,
    $$LotesAvesTableTableFilterComposer,
    $$LotesAvesTableTableOrderingComposer,
    $$LotesAvesTableTableAnnotationComposer,
    $$LotesAvesTableTableCreateCompanionBuilder,
    $$LotesAvesTableTableUpdateCompanionBuilder,
    (LotesAvesTableData, $$LotesAvesTableTableReferences),
    LotesAvesTableData,
    PrefetchHooks Function({bool galponId})>;
typedef $$ProduccionHuevosTableTableCreateCompanionBuilder
    = ProduccionHuevosTableCompanion Function({
  required String id,
  required String galponId,
  Value<String?> loteId,
  required DateTime fecha,
  required int cantidadTotal,
  Value<int> huevosRotos,
  Value<int> huevosSucios,
  Value<int> huevosGrandeAA,
  Value<int> huevosGrandeA,
  Value<int> huevosMediano,
  Value<int> huevosPequeno,
  Value<double> porcentajePostura,
  Value<String?> observaciones,
  Value<bool> sincronizado,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});
typedef $$ProduccionHuevosTableTableUpdateCompanionBuilder
    = ProduccionHuevosTableCompanion Function({
  Value<String> id,
  Value<String> galponId,
  Value<String?> loteId,
  Value<DateTime> fecha,
  Value<int> cantidadTotal,
  Value<int> huevosRotos,
  Value<int> huevosSucios,
  Value<int> huevosGrandeAA,
  Value<int> huevosGrandeA,
  Value<int> huevosMediano,
  Value<int> huevosPequeno,
  Value<double> porcentajePostura,
  Value<String?> observaciones,
  Value<bool> sincronizado,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});

final class $$ProduccionHuevosTableTableReferences extends BaseReferences<
    _$AppDatabase, $ProduccionHuevosTableTable, ProduccionHuevosTableData> {
  $$ProduccionHuevosTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $GalponesTableTable _galponIdTable(_$AppDatabase db) =>
      db.galponesTable.createAlias($_aliasNameGenerator(
          db.produccionHuevosTable.galponId, db.galponesTable.id));

  $$GalponesTableTableProcessedTableManager? get galponId {
    if ($_item.galponId == null) return null;
    final manager = $$GalponesTableTableTableManager($_db, $_db.galponesTable)
        .filter((f) => f.id($_item.galponId!));
    final item = $_typedResult.readTableOrNull(_galponIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ProduccionHuevosTableTableFilterComposer
    extends Composer<_$AppDatabase, $ProduccionHuevosTableTable> {
  $$ProduccionHuevosTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get loteId => $composableBuilder(
      column: $table.loteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fecha => $composableBuilder(
      column: $table.fecha, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get cantidadTotal => $composableBuilder(
      column: $table.cantidadTotal, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get huevosRotos => $composableBuilder(
      column: $table.huevosRotos, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get huevosSucios => $composableBuilder(
      column: $table.huevosSucios, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get huevosGrandeAA => $composableBuilder(
      column: $table.huevosGrandeAA,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get huevosGrandeA => $composableBuilder(
      column: $table.huevosGrandeA, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get huevosMediano => $composableBuilder(
      column: $table.huevosMediano, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get huevosPequeno => $composableBuilder(
      column: $table.huevosPequeno, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get porcentajePostura => $composableBuilder(
      column: $table.porcentajePostura,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get observaciones => $composableBuilder(
      column: $table.observaciones, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  $$GalponesTableTableFilterComposer get galponId {
    final $$GalponesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.galponId,
        referencedTable: $db.galponesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GalponesTableTableFilterComposer(
              $db: $db,
              $table: $db.galponesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ProduccionHuevosTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ProduccionHuevosTableTable> {
  $$ProduccionHuevosTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get loteId => $composableBuilder(
      column: $table.loteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
      column: $table.fecha, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cantidadTotal => $composableBuilder(
      column: $table.cantidadTotal,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get huevosRotos => $composableBuilder(
      column: $table.huevosRotos, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get huevosSucios => $composableBuilder(
      column: $table.huevosSucios,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get huevosGrandeAA => $composableBuilder(
      column: $table.huevosGrandeAA,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get huevosGrandeA => $composableBuilder(
      column: $table.huevosGrandeA,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get huevosMediano => $composableBuilder(
      column: $table.huevosMediano,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get huevosPequeno => $composableBuilder(
      column: $table.huevosPequeno,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get porcentajePostura => $composableBuilder(
      column: $table.porcentajePostura,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get observaciones => $composableBuilder(
      column: $table.observaciones,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  $$GalponesTableTableOrderingComposer get galponId {
    final $$GalponesTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.galponId,
        referencedTable: $db.galponesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GalponesTableTableOrderingComposer(
              $db: $db,
              $table: $db.galponesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ProduccionHuevosTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProduccionHuevosTableTable> {
  $$ProduccionHuevosTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get loteId =>
      $composableBuilder(column: $table.loteId, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  GeneratedColumn<int> get cantidadTotal => $composableBuilder(
      column: $table.cantidadTotal, builder: (column) => column);

  GeneratedColumn<int> get huevosRotos => $composableBuilder(
      column: $table.huevosRotos, builder: (column) => column);

  GeneratedColumn<int> get huevosSucios => $composableBuilder(
      column: $table.huevosSucios, builder: (column) => column);

  GeneratedColumn<int> get huevosGrandeAA => $composableBuilder(
      column: $table.huevosGrandeAA, builder: (column) => column);

  GeneratedColumn<int> get huevosGrandeA => $composableBuilder(
      column: $table.huevosGrandeA, builder: (column) => column);

  GeneratedColumn<int> get huevosMediano => $composableBuilder(
      column: $table.huevosMediano, builder: (column) => column);

  GeneratedColumn<int> get huevosPequeno => $composableBuilder(
      column: $table.huevosPequeno, builder: (column) => column);

  GeneratedColumn<double> get porcentajePostura => $composableBuilder(
      column: $table.porcentajePostura, builder: (column) => column);

  GeneratedColumn<String> get observaciones => $composableBuilder(
      column: $table.observaciones, builder: (column) => column);

  GeneratedColumn<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$GalponesTableTableAnnotationComposer get galponId {
    final $$GalponesTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.galponId,
        referencedTable: $db.galponesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GalponesTableTableAnnotationComposer(
              $db: $db,
              $table: $db.galponesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ProduccionHuevosTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProduccionHuevosTableTable,
    ProduccionHuevosTableData,
    $$ProduccionHuevosTableTableFilterComposer,
    $$ProduccionHuevosTableTableOrderingComposer,
    $$ProduccionHuevosTableTableAnnotationComposer,
    $$ProduccionHuevosTableTableCreateCompanionBuilder,
    $$ProduccionHuevosTableTableUpdateCompanionBuilder,
    (ProduccionHuevosTableData, $$ProduccionHuevosTableTableReferences),
    ProduccionHuevosTableData,
    PrefetchHooks Function({bool galponId})> {
  $$ProduccionHuevosTableTableTableManager(
      _$AppDatabase db, $ProduccionHuevosTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProduccionHuevosTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$ProduccionHuevosTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProduccionHuevosTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> galponId = const Value.absent(),
            Value<String?> loteId = const Value.absent(),
            Value<DateTime> fecha = const Value.absent(),
            Value<int> cantidadTotal = const Value.absent(),
            Value<int> huevosRotos = const Value.absent(),
            Value<int> huevosSucios = const Value.absent(),
            Value<int> huevosGrandeAA = const Value.absent(),
            Value<int> huevosGrandeA = const Value.absent(),
            Value<int> huevosMediano = const Value.absent(),
            Value<int> huevosPequeno = const Value.absent(),
            Value<double> porcentajePostura = const Value.absent(),
            Value<String?> observaciones = const Value.absent(),
            Value<bool> sincronizado = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProduccionHuevosTableCompanion(
            id: id,
            galponId: galponId,
            loteId: loteId,
            fecha: fecha,
            cantidadTotal: cantidadTotal,
            huevosRotos: huevosRotos,
            huevosSucios: huevosSucios,
            huevosGrandeAA: huevosGrandeAA,
            huevosGrandeA: huevosGrandeA,
            huevosMediano: huevosMediano,
            huevosPequeno: huevosPequeno,
            porcentajePostura: porcentajePostura,
            observaciones: observaciones,
            sincronizado: sincronizado,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String galponId,
            Value<String?> loteId = const Value.absent(),
            required DateTime fecha,
            required int cantidadTotal,
            Value<int> huevosRotos = const Value.absent(),
            Value<int> huevosSucios = const Value.absent(),
            Value<int> huevosGrandeAA = const Value.absent(),
            Value<int> huevosGrandeA = const Value.absent(),
            Value<int> huevosMediano = const Value.absent(),
            Value<int> huevosPequeno = const Value.absent(),
            Value<double> porcentajePostura = const Value.absent(),
            Value<String?> observaciones = const Value.absent(),
            Value<bool> sincronizado = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProduccionHuevosTableCompanion.insert(
            id: id,
            galponId: galponId,
            loteId: loteId,
            fecha: fecha,
            cantidadTotal: cantidadTotal,
            huevosRotos: huevosRotos,
            huevosSucios: huevosSucios,
            huevosGrandeAA: huevosGrandeAA,
            huevosGrandeA: huevosGrandeA,
            huevosMediano: huevosMediano,
            huevosPequeno: huevosPequeno,
            porcentajePostura: porcentajePostura,
            observaciones: observaciones,
            sincronizado: sincronizado,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ProduccionHuevosTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({galponId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (galponId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.galponId,
                    referencedTable: $$ProduccionHuevosTableTableReferences
                        ._galponIdTable(db),
                    referencedColumn: $$ProduccionHuevosTableTableReferences
                        ._galponIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ProduccionHuevosTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $ProduccionHuevosTableTable,
        ProduccionHuevosTableData,
        $$ProduccionHuevosTableTableFilterComposer,
        $$ProduccionHuevosTableTableOrderingComposer,
        $$ProduccionHuevosTableTableAnnotationComposer,
        $$ProduccionHuevosTableTableCreateCompanionBuilder,
        $$ProduccionHuevosTableTableUpdateCompanionBuilder,
        (ProduccionHuevosTableData, $$ProduccionHuevosTableTableReferences),
        ProduccionHuevosTableData,
        PrefetchHooks Function({bool galponId})>;
typedef $$EventosSanitariosTableTableCreateCompanionBuilder
    = EventosSanitariosTableCompanion Function({
  required String id,
  required String galponId,
  Value<String?> loteId,
  required String tipo,
  required DateTime fecha,
  required String descripcion,
  Value<String?> medicamento,
  Value<String?> dosis,
  Value<String?> veterinario,
  Value<int> avesAfectadas,
  Value<String?> observaciones,
  Value<bool> sincronizado,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});
typedef $$EventosSanitariosTableTableUpdateCompanionBuilder
    = EventosSanitariosTableCompanion Function({
  Value<String> id,
  Value<String> galponId,
  Value<String?> loteId,
  Value<String> tipo,
  Value<DateTime> fecha,
  Value<String> descripcion,
  Value<String?> medicamento,
  Value<String?> dosis,
  Value<String?> veterinario,
  Value<int> avesAfectadas,
  Value<String?> observaciones,
  Value<bool> sincronizado,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});

final class $$EventosSanitariosTableTableReferences extends BaseReferences<
    _$AppDatabase, $EventosSanitariosTableTable, EventosSanitariosTableData> {
  $$EventosSanitariosTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $GalponesTableTable _galponIdTable(_$AppDatabase db) =>
      db.galponesTable.createAlias($_aliasNameGenerator(
          db.eventosSanitariosTable.galponId, db.galponesTable.id));

  $$GalponesTableTableProcessedTableManager? get galponId {
    if ($_item.galponId == null) return null;
    final manager = $$GalponesTableTableTableManager($_db, $_db.galponesTable)
        .filter((f) => f.id($_item.galponId!));
    final item = $_typedResult.readTableOrNull(_galponIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$EventosSanitariosTableTableFilterComposer
    extends Composer<_$AppDatabase, $EventosSanitariosTableTable> {
  $$EventosSanitariosTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get loteId => $composableBuilder(
      column: $table.loteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tipo => $composableBuilder(
      column: $table.tipo, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fecha => $composableBuilder(
      column: $table.fecha, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get medicamento => $composableBuilder(
      column: $table.medicamento, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dosis => $composableBuilder(
      column: $table.dosis, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get veterinario => $composableBuilder(
      column: $table.veterinario, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get avesAfectadas => $composableBuilder(
      column: $table.avesAfectadas, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get observaciones => $composableBuilder(
      column: $table.observaciones, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  $$GalponesTableTableFilterComposer get galponId {
    final $$GalponesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.galponId,
        referencedTable: $db.galponesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GalponesTableTableFilterComposer(
              $db: $db,
              $table: $db.galponesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EventosSanitariosTableTableOrderingComposer
    extends Composer<_$AppDatabase, $EventosSanitariosTableTable> {
  $$EventosSanitariosTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get loteId => $composableBuilder(
      column: $table.loteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tipo => $composableBuilder(
      column: $table.tipo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
      column: $table.fecha, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get medicamento => $composableBuilder(
      column: $table.medicamento, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dosis => $composableBuilder(
      column: $table.dosis, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get veterinario => $composableBuilder(
      column: $table.veterinario, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get avesAfectadas => $composableBuilder(
      column: $table.avesAfectadas,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get observaciones => $composableBuilder(
      column: $table.observaciones,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  $$GalponesTableTableOrderingComposer get galponId {
    final $$GalponesTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.galponId,
        referencedTable: $db.galponesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GalponesTableTableOrderingComposer(
              $db: $db,
              $table: $db.galponesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EventosSanitariosTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventosSanitariosTableTable> {
  $$EventosSanitariosTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get loteId =>
      $composableBuilder(column: $table.loteId, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => column);

  GeneratedColumn<String> get medicamento => $composableBuilder(
      column: $table.medicamento, builder: (column) => column);

  GeneratedColumn<String> get dosis =>
      $composableBuilder(column: $table.dosis, builder: (column) => column);

  GeneratedColumn<String> get veterinario => $composableBuilder(
      column: $table.veterinario, builder: (column) => column);

  GeneratedColumn<int> get avesAfectadas => $composableBuilder(
      column: $table.avesAfectadas, builder: (column) => column);

  GeneratedColumn<String> get observaciones => $composableBuilder(
      column: $table.observaciones, builder: (column) => column);

  GeneratedColumn<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$GalponesTableTableAnnotationComposer get galponId {
    final $$GalponesTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.galponId,
        referencedTable: $db.galponesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GalponesTableTableAnnotationComposer(
              $db: $db,
              $table: $db.galponesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EventosSanitariosTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EventosSanitariosTableTable,
    EventosSanitariosTableData,
    $$EventosSanitariosTableTableFilterComposer,
    $$EventosSanitariosTableTableOrderingComposer,
    $$EventosSanitariosTableTableAnnotationComposer,
    $$EventosSanitariosTableTableCreateCompanionBuilder,
    $$EventosSanitariosTableTableUpdateCompanionBuilder,
    (EventosSanitariosTableData, $$EventosSanitariosTableTableReferences),
    EventosSanitariosTableData,
    PrefetchHooks Function({bool galponId})> {
  $$EventosSanitariosTableTableTableManager(
      _$AppDatabase db, $EventosSanitariosTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventosSanitariosTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$EventosSanitariosTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventosSanitariosTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> galponId = const Value.absent(),
            Value<String?> loteId = const Value.absent(),
            Value<String> tipo = const Value.absent(),
            Value<DateTime> fecha = const Value.absent(),
            Value<String> descripcion = const Value.absent(),
            Value<String?> medicamento = const Value.absent(),
            Value<String?> dosis = const Value.absent(),
            Value<String?> veterinario = const Value.absent(),
            Value<int> avesAfectadas = const Value.absent(),
            Value<String?> observaciones = const Value.absent(),
            Value<bool> sincronizado = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EventosSanitariosTableCompanion(
            id: id,
            galponId: galponId,
            loteId: loteId,
            tipo: tipo,
            fecha: fecha,
            descripcion: descripcion,
            medicamento: medicamento,
            dosis: dosis,
            veterinario: veterinario,
            avesAfectadas: avesAfectadas,
            observaciones: observaciones,
            sincronizado: sincronizado,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String galponId,
            Value<String?> loteId = const Value.absent(),
            required String tipo,
            required DateTime fecha,
            required String descripcion,
            Value<String?> medicamento = const Value.absent(),
            Value<String?> dosis = const Value.absent(),
            Value<String?> veterinario = const Value.absent(),
            Value<int> avesAfectadas = const Value.absent(),
            Value<String?> observaciones = const Value.absent(),
            Value<bool> sincronizado = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EventosSanitariosTableCompanion.insert(
            id: id,
            galponId: galponId,
            loteId: loteId,
            tipo: tipo,
            fecha: fecha,
            descripcion: descripcion,
            medicamento: medicamento,
            dosis: dosis,
            veterinario: veterinario,
            avesAfectadas: avesAfectadas,
            observaciones: observaciones,
            sincronizado: sincronizado,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$EventosSanitariosTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({galponId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (galponId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.galponId,
                    referencedTable: $$EventosSanitariosTableTableReferences
                        ._galponIdTable(db),
                    referencedColumn: $$EventosSanitariosTableTableReferences
                        ._galponIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$EventosSanitariosTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $EventosSanitariosTableTable,
        EventosSanitariosTableData,
        $$EventosSanitariosTableTableFilterComposer,
        $$EventosSanitariosTableTableOrderingComposer,
        $$EventosSanitariosTableTableAnnotationComposer,
        $$EventosSanitariosTableTableCreateCompanionBuilder,
        $$EventosSanitariosTableTableUpdateCompanionBuilder,
        (EventosSanitariosTableData, $$EventosSanitariosTableTableReferences),
        EventosSanitariosTableData,
        PrefetchHooks Function({bool galponId})>;
typedef $$AlimentacionTableTableCreateCompanionBuilder
    = AlimentacionTableCompanion Function({
  required String id,
  required String galponId,
  Value<String?> loteId,
  required DateTime fecha,
  required String tipoAlimento,
  required double cantidadKg,
  Value<String?> loteAlimento,
  Value<double> costoUnitario,
  Value<String?> observaciones,
  Value<bool> sincronizado,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});
typedef $$AlimentacionTableTableUpdateCompanionBuilder
    = AlimentacionTableCompanion Function({
  Value<String> id,
  Value<String> galponId,
  Value<String?> loteId,
  Value<DateTime> fecha,
  Value<String> tipoAlimento,
  Value<double> cantidadKg,
  Value<String?> loteAlimento,
  Value<double> costoUnitario,
  Value<String?> observaciones,
  Value<bool> sincronizado,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});

final class $$AlimentacionTableTableReferences extends BaseReferences<
    _$AppDatabase, $AlimentacionTableTable, AlimentacionTableData> {
  $$AlimentacionTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $GalponesTableTable _galponIdTable(_$AppDatabase db) =>
      db.galponesTable.createAlias($_aliasNameGenerator(
          db.alimentacionTable.galponId, db.galponesTable.id));

  $$GalponesTableTableProcessedTableManager? get galponId {
    if ($_item.galponId == null) return null;
    final manager = $$GalponesTableTableTableManager($_db, $_db.galponesTable)
        .filter((f) => f.id($_item.galponId!));
    final item = $_typedResult.readTableOrNull(_galponIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$AlimentacionTableTableFilterComposer
    extends Composer<_$AppDatabase, $AlimentacionTableTable> {
  $$AlimentacionTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get loteId => $composableBuilder(
      column: $table.loteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fecha => $composableBuilder(
      column: $table.fecha, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tipoAlimento => $composableBuilder(
      column: $table.tipoAlimento, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get cantidadKg => $composableBuilder(
      column: $table.cantidadKg, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get loteAlimento => $composableBuilder(
      column: $table.loteAlimento, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get costoUnitario => $composableBuilder(
      column: $table.costoUnitario, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get observaciones => $composableBuilder(
      column: $table.observaciones, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  $$GalponesTableTableFilterComposer get galponId {
    final $$GalponesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.galponId,
        referencedTable: $db.galponesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GalponesTableTableFilterComposer(
              $db: $db,
              $table: $db.galponesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AlimentacionTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AlimentacionTableTable> {
  $$AlimentacionTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get loteId => $composableBuilder(
      column: $table.loteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
      column: $table.fecha, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tipoAlimento => $composableBuilder(
      column: $table.tipoAlimento,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get cantidadKg => $composableBuilder(
      column: $table.cantidadKg, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get loteAlimento => $composableBuilder(
      column: $table.loteAlimento,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get costoUnitario => $composableBuilder(
      column: $table.costoUnitario,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get observaciones => $composableBuilder(
      column: $table.observaciones,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  $$GalponesTableTableOrderingComposer get galponId {
    final $$GalponesTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.galponId,
        referencedTable: $db.galponesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GalponesTableTableOrderingComposer(
              $db: $db,
              $table: $db.galponesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AlimentacionTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AlimentacionTableTable> {
  $$AlimentacionTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get loteId =>
      $composableBuilder(column: $table.loteId, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  GeneratedColumn<String> get tipoAlimento => $composableBuilder(
      column: $table.tipoAlimento, builder: (column) => column);

  GeneratedColumn<double> get cantidadKg => $composableBuilder(
      column: $table.cantidadKg, builder: (column) => column);

  GeneratedColumn<String> get loteAlimento => $composableBuilder(
      column: $table.loteAlimento, builder: (column) => column);

  GeneratedColumn<double> get costoUnitario => $composableBuilder(
      column: $table.costoUnitario, builder: (column) => column);

  GeneratedColumn<String> get observaciones => $composableBuilder(
      column: $table.observaciones, builder: (column) => column);

  GeneratedColumn<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$GalponesTableTableAnnotationComposer get galponId {
    final $$GalponesTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.galponId,
        referencedTable: $db.galponesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GalponesTableTableAnnotationComposer(
              $db: $db,
              $table: $db.galponesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AlimentacionTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AlimentacionTableTable,
    AlimentacionTableData,
    $$AlimentacionTableTableFilterComposer,
    $$AlimentacionTableTableOrderingComposer,
    $$AlimentacionTableTableAnnotationComposer,
    $$AlimentacionTableTableCreateCompanionBuilder,
    $$AlimentacionTableTableUpdateCompanionBuilder,
    (AlimentacionTableData, $$AlimentacionTableTableReferences),
    AlimentacionTableData,
    PrefetchHooks Function({bool galponId})> {
  $$AlimentacionTableTableTableManager(
      _$AppDatabase db, $AlimentacionTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AlimentacionTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AlimentacionTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AlimentacionTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> galponId = const Value.absent(),
            Value<String?> loteId = const Value.absent(),
            Value<DateTime> fecha = const Value.absent(),
            Value<String> tipoAlimento = const Value.absent(),
            Value<double> cantidadKg = const Value.absent(),
            Value<String?> loteAlimento = const Value.absent(),
            Value<double> costoUnitario = const Value.absent(),
            Value<String?> observaciones = const Value.absent(),
            Value<bool> sincronizado = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AlimentacionTableCompanion(
            id: id,
            galponId: galponId,
            loteId: loteId,
            fecha: fecha,
            tipoAlimento: tipoAlimento,
            cantidadKg: cantidadKg,
            loteAlimento: loteAlimento,
            costoUnitario: costoUnitario,
            observaciones: observaciones,
            sincronizado: sincronizado,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String galponId,
            Value<String?> loteId = const Value.absent(),
            required DateTime fecha,
            required String tipoAlimento,
            required double cantidadKg,
            Value<String?> loteAlimento = const Value.absent(),
            Value<double> costoUnitario = const Value.absent(),
            Value<String?> observaciones = const Value.absent(),
            Value<bool> sincronizado = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AlimentacionTableCompanion.insert(
            id: id,
            galponId: galponId,
            loteId: loteId,
            fecha: fecha,
            tipoAlimento: tipoAlimento,
            cantidadKg: cantidadKg,
            loteAlimento: loteAlimento,
            costoUnitario: costoUnitario,
            observaciones: observaciones,
            sincronizado: sincronizado,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$AlimentacionTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({galponId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (galponId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.galponId,
                    referencedTable:
                        $$AlimentacionTableTableReferences._galponIdTable(db),
                    referencedColumn: $$AlimentacionTableTableReferences
                        ._galponIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$AlimentacionTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AlimentacionTableTable,
    AlimentacionTableData,
    $$AlimentacionTableTableFilterComposer,
    $$AlimentacionTableTableOrderingComposer,
    $$AlimentacionTableTableAnnotationComposer,
    $$AlimentacionTableTableCreateCompanionBuilder,
    $$AlimentacionTableTableUpdateCompanionBuilder,
    (AlimentacionTableData, $$AlimentacionTableTableReferences),
    AlimentacionTableData,
    PrefetchHooks Function({bool galponId})>;
typedef $$MortalidadTableTableCreateCompanionBuilder = MortalidadTableCompanion
    Function({
  required String id,
  required String galponId,
  Value<String?> loteId,
  required DateTime fecha,
  required int cantidad,
  required String causa,
  Value<String?> observaciones,
  Value<bool> sincronizado,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});
typedef $$MortalidadTableTableUpdateCompanionBuilder = MortalidadTableCompanion
    Function({
  Value<String> id,
  Value<String> galponId,
  Value<String?> loteId,
  Value<DateTime> fecha,
  Value<int> cantidad,
  Value<String> causa,
  Value<String?> observaciones,
  Value<bool> sincronizado,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});

final class $$MortalidadTableTableReferences extends BaseReferences<
    _$AppDatabase, $MortalidadTableTable, MortalidadTableData> {
  $$MortalidadTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $GalponesTableTable _galponIdTable(_$AppDatabase db) =>
      db.galponesTable.createAlias($_aliasNameGenerator(
          db.mortalidadTable.galponId, db.galponesTable.id));

  $$GalponesTableTableProcessedTableManager? get galponId {
    if ($_item.galponId == null) return null;
    final manager = $$GalponesTableTableTableManager($_db, $_db.galponesTable)
        .filter((f) => f.id($_item.galponId!));
    final item = $_typedResult.readTableOrNull(_galponIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$MortalidadTableTableFilterComposer
    extends Composer<_$AppDatabase, $MortalidadTableTable> {
  $$MortalidadTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get loteId => $composableBuilder(
      column: $table.loteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fecha => $composableBuilder(
      column: $table.fecha, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get cantidad => $composableBuilder(
      column: $table.cantidad, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get causa => $composableBuilder(
      column: $table.causa, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get observaciones => $composableBuilder(
      column: $table.observaciones, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  $$GalponesTableTableFilterComposer get galponId {
    final $$GalponesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.galponId,
        referencedTable: $db.galponesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GalponesTableTableFilterComposer(
              $db: $db,
              $table: $db.galponesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MortalidadTableTableOrderingComposer
    extends Composer<_$AppDatabase, $MortalidadTableTable> {
  $$MortalidadTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get loteId => $composableBuilder(
      column: $table.loteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
      column: $table.fecha, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cantidad => $composableBuilder(
      column: $table.cantidad, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get causa => $composableBuilder(
      column: $table.causa, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get observaciones => $composableBuilder(
      column: $table.observaciones,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  $$GalponesTableTableOrderingComposer get galponId {
    final $$GalponesTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.galponId,
        referencedTable: $db.galponesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GalponesTableTableOrderingComposer(
              $db: $db,
              $table: $db.galponesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MortalidadTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $MortalidadTableTable> {
  $$MortalidadTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get loteId =>
      $composableBuilder(column: $table.loteId, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  GeneratedColumn<int> get cantidad =>
      $composableBuilder(column: $table.cantidad, builder: (column) => column);

  GeneratedColumn<String> get causa =>
      $composableBuilder(column: $table.causa, builder: (column) => column);

  GeneratedColumn<String> get observaciones => $composableBuilder(
      column: $table.observaciones, builder: (column) => column);

  GeneratedColumn<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$GalponesTableTableAnnotationComposer get galponId {
    final $$GalponesTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.galponId,
        referencedTable: $db.galponesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GalponesTableTableAnnotationComposer(
              $db: $db,
              $table: $db.galponesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MortalidadTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MortalidadTableTable,
    MortalidadTableData,
    $$MortalidadTableTableFilterComposer,
    $$MortalidadTableTableOrderingComposer,
    $$MortalidadTableTableAnnotationComposer,
    $$MortalidadTableTableCreateCompanionBuilder,
    $$MortalidadTableTableUpdateCompanionBuilder,
    (MortalidadTableData, $$MortalidadTableTableReferences),
    MortalidadTableData,
    PrefetchHooks Function({bool galponId})> {
  $$MortalidadTableTableTableManager(
      _$AppDatabase db, $MortalidadTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MortalidadTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MortalidadTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MortalidadTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> galponId = const Value.absent(),
            Value<String?> loteId = const Value.absent(),
            Value<DateTime> fecha = const Value.absent(),
            Value<int> cantidad = const Value.absent(),
            Value<String> causa = const Value.absent(),
            Value<String?> observaciones = const Value.absent(),
            Value<bool> sincronizado = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MortalidadTableCompanion(
            id: id,
            galponId: galponId,
            loteId: loteId,
            fecha: fecha,
            cantidad: cantidad,
            causa: causa,
            observaciones: observaciones,
            sincronizado: sincronizado,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String galponId,
            Value<String?> loteId = const Value.absent(),
            required DateTime fecha,
            required int cantidad,
            required String causa,
            Value<String?> observaciones = const Value.absent(),
            Value<bool> sincronizado = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MortalidadTableCompanion.insert(
            id: id,
            galponId: galponId,
            loteId: loteId,
            fecha: fecha,
            cantidad: cantidad,
            causa: causa,
            observaciones: observaciones,
            sincronizado: sincronizado,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$MortalidadTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({galponId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (galponId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.galponId,
                    referencedTable:
                        $$MortalidadTableTableReferences._galponIdTable(db),
                    referencedColumn:
                        $$MortalidadTableTableReferences._galponIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$MortalidadTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MortalidadTableTable,
    MortalidadTableData,
    $$MortalidadTableTableFilterComposer,
    $$MortalidadTableTableOrderingComposer,
    $$MortalidadTableTableAnnotationComposer,
    $$MortalidadTableTableCreateCompanionBuilder,
    $$MortalidadTableTableUpdateCompanionBuilder,
    (MortalidadTableData, $$MortalidadTableTableReferences),
    MortalidadTableData,
    PrefetchHooks Function({bool galponId})>;
typedef $$InventarioFotoTableTableCreateCompanionBuilder
    = InventarioFotoTableCompanion Function({
  required String id,
  required String galponId,
  Value<String?> loteId,
  required DateTime fecha,
  required String imagenPath,
  Value<int> conteoAutomatico,
  Value<int> conteoManual,
  required int conteoFinal,
  Value<String> estado,
  Value<String?> observaciones,
  Value<bool> sincronizado,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});
typedef $$InventarioFotoTableTableUpdateCompanionBuilder
    = InventarioFotoTableCompanion Function({
  Value<String> id,
  Value<String> galponId,
  Value<String?> loteId,
  Value<DateTime> fecha,
  Value<String> imagenPath,
  Value<int> conteoAutomatico,
  Value<int> conteoManual,
  Value<int> conteoFinal,
  Value<String> estado,
  Value<String?> observaciones,
  Value<bool> sincronizado,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});

final class $$InventarioFotoTableTableReferences extends BaseReferences<
    _$AppDatabase, $InventarioFotoTableTable, InventarioFotoTableData> {
  $$InventarioFotoTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $GalponesTableTable _galponIdTable(_$AppDatabase db) =>
      db.galponesTable.createAlias($_aliasNameGenerator(
          db.inventarioFotoTable.galponId, db.galponesTable.id));

  $$GalponesTableTableProcessedTableManager? get galponId {
    if ($_item.galponId == null) return null;
    final manager = $$GalponesTableTableTableManager($_db, $_db.galponesTable)
        .filter((f) => f.id($_item.galponId!));
    final item = $_typedResult.readTableOrNull(_galponIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$InventarioFotoTableTableFilterComposer
    extends Composer<_$AppDatabase, $InventarioFotoTableTable> {
  $$InventarioFotoTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get loteId => $composableBuilder(
      column: $table.loteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fecha => $composableBuilder(
      column: $table.fecha, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imagenPath => $composableBuilder(
      column: $table.imagenPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get conteoAutomatico => $composableBuilder(
      column: $table.conteoAutomatico,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get conteoManual => $composableBuilder(
      column: $table.conteoManual, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get conteoFinal => $composableBuilder(
      column: $table.conteoFinal, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get estado => $composableBuilder(
      column: $table.estado, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get observaciones => $composableBuilder(
      column: $table.observaciones, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  $$GalponesTableTableFilterComposer get galponId {
    final $$GalponesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.galponId,
        referencedTable: $db.galponesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GalponesTableTableFilterComposer(
              $db: $db,
              $table: $db.galponesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$InventarioFotoTableTableOrderingComposer
    extends Composer<_$AppDatabase, $InventarioFotoTableTable> {
  $$InventarioFotoTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get loteId => $composableBuilder(
      column: $table.loteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
      column: $table.fecha, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imagenPath => $composableBuilder(
      column: $table.imagenPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get conteoAutomatico => $composableBuilder(
      column: $table.conteoAutomatico,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get conteoManual => $composableBuilder(
      column: $table.conteoManual,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get conteoFinal => $composableBuilder(
      column: $table.conteoFinal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get estado => $composableBuilder(
      column: $table.estado, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get observaciones => $composableBuilder(
      column: $table.observaciones,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  $$GalponesTableTableOrderingComposer get galponId {
    final $$GalponesTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.galponId,
        referencedTable: $db.galponesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GalponesTableTableOrderingComposer(
              $db: $db,
              $table: $db.galponesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$InventarioFotoTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $InventarioFotoTableTable> {
  $$InventarioFotoTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get loteId =>
      $composableBuilder(column: $table.loteId, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  GeneratedColumn<String> get imagenPath => $composableBuilder(
      column: $table.imagenPath, builder: (column) => column);

  GeneratedColumn<int> get conteoAutomatico => $composableBuilder(
      column: $table.conteoAutomatico, builder: (column) => column);

  GeneratedColumn<int> get conteoManual => $composableBuilder(
      column: $table.conteoManual, builder: (column) => column);

  GeneratedColumn<int> get conteoFinal => $composableBuilder(
      column: $table.conteoFinal, builder: (column) => column);

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<String> get observaciones => $composableBuilder(
      column: $table.observaciones, builder: (column) => column);

  GeneratedColumn<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$GalponesTableTableAnnotationComposer get galponId {
    final $$GalponesTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.galponId,
        referencedTable: $db.galponesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GalponesTableTableAnnotationComposer(
              $db: $db,
              $table: $db.galponesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$InventarioFotoTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $InventarioFotoTableTable,
    InventarioFotoTableData,
    $$InventarioFotoTableTableFilterComposer,
    $$InventarioFotoTableTableOrderingComposer,
    $$InventarioFotoTableTableAnnotationComposer,
    $$InventarioFotoTableTableCreateCompanionBuilder,
    $$InventarioFotoTableTableUpdateCompanionBuilder,
    (InventarioFotoTableData, $$InventarioFotoTableTableReferences),
    InventarioFotoTableData,
    PrefetchHooks Function({bool galponId})> {
  $$InventarioFotoTableTableTableManager(
      _$AppDatabase db, $InventarioFotoTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InventarioFotoTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InventarioFotoTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InventarioFotoTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> galponId = const Value.absent(),
            Value<String?> loteId = const Value.absent(),
            Value<DateTime> fecha = const Value.absent(),
            Value<String> imagenPath = const Value.absent(),
            Value<int> conteoAutomatico = const Value.absent(),
            Value<int> conteoManual = const Value.absent(),
            Value<int> conteoFinal = const Value.absent(),
            Value<String> estado = const Value.absent(),
            Value<String?> observaciones = const Value.absent(),
            Value<bool> sincronizado = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              InventarioFotoTableCompanion(
            id: id,
            galponId: galponId,
            loteId: loteId,
            fecha: fecha,
            imagenPath: imagenPath,
            conteoAutomatico: conteoAutomatico,
            conteoManual: conteoManual,
            conteoFinal: conteoFinal,
            estado: estado,
            observaciones: observaciones,
            sincronizado: sincronizado,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String galponId,
            Value<String?> loteId = const Value.absent(),
            required DateTime fecha,
            required String imagenPath,
            Value<int> conteoAutomatico = const Value.absent(),
            Value<int> conteoManual = const Value.absent(),
            required int conteoFinal,
            Value<String> estado = const Value.absent(),
            Value<String?> observaciones = const Value.absent(),
            Value<bool> sincronizado = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              InventarioFotoTableCompanion.insert(
            id: id,
            galponId: galponId,
            loteId: loteId,
            fecha: fecha,
            imagenPath: imagenPath,
            conteoAutomatico: conteoAutomatico,
            conteoManual: conteoManual,
            conteoFinal: conteoFinal,
            estado: estado,
            observaciones: observaciones,
            sincronizado: sincronizado,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$InventarioFotoTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({galponId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (galponId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.galponId,
                    referencedTable:
                        $$InventarioFotoTableTableReferences._galponIdTable(db),
                    referencedColumn: $$InventarioFotoTableTableReferences
                        ._galponIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$InventarioFotoTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $InventarioFotoTableTable,
    InventarioFotoTableData,
    $$InventarioFotoTableTableFilterComposer,
    $$InventarioFotoTableTableOrderingComposer,
    $$InventarioFotoTableTableAnnotationComposer,
    $$InventarioFotoTableTableCreateCompanionBuilder,
    $$InventarioFotoTableTableUpdateCompanionBuilder,
    (InventarioFotoTableData, $$InventarioFotoTableTableReferences),
    InventarioFotoTableData,
    PrefetchHooks Function({bool galponId})>;
typedef $$SyncQueueTableTableCreateCompanionBuilder = SyncQueueTableCompanion
    Function({
  required String id,
  required String operacion,
  required String entidad,
  required String entidadId,
  required String payload,
  Value<int> intentos,
  Value<String?> error,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$SyncQueueTableTableUpdateCompanionBuilder = SyncQueueTableCompanion
    Function({
  Value<String> id,
  Value<String> operacion,
  Value<String> entidad,
  Value<String> entidadId,
  Value<String> payload,
  Value<int> intentos,
  Value<String?> error,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$SyncQueueTableTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueTableTable> {
  $$SyncQueueTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get operacion => $composableBuilder(
      column: $table.operacion, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entidad => $composableBuilder(
      column: $table.entidad, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entidadId => $composableBuilder(
      column: $table.entidadId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get intentos => $composableBuilder(
      column: $table.intentos, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get error => $composableBuilder(
      column: $table.error, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$SyncQueueTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueTableTable> {
  $$SyncQueueTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get operacion => $composableBuilder(
      column: $table.operacion, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entidad => $composableBuilder(
      column: $table.entidad, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entidadId => $composableBuilder(
      column: $table.entidadId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get intentos => $composableBuilder(
      column: $table.intentos, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get error => $composableBuilder(
      column: $table.error, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$SyncQueueTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueTableTable> {
  $$SyncQueueTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get operacion =>
      $composableBuilder(column: $table.operacion, builder: (column) => column);

  GeneratedColumn<String> get entidad =>
      $composableBuilder(column: $table.entidad, builder: (column) => column);

  GeneratedColumn<String> get entidadId =>
      $composableBuilder(column: $table.entidadId, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<int> get intentos =>
      $composableBuilder(column: $table.intentos, builder: (column) => column);

  GeneratedColumn<String> get error =>
      $composableBuilder(column: $table.error, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SyncQueueTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SyncQueueTableTable,
    SyncQueueTableData,
    $$SyncQueueTableTableFilterComposer,
    $$SyncQueueTableTableOrderingComposer,
    $$SyncQueueTableTableAnnotationComposer,
    $$SyncQueueTableTableCreateCompanionBuilder,
    $$SyncQueueTableTableUpdateCompanionBuilder,
    (
      SyncQueueTableData,
      BaseReferences<_$AppDatabase, $SyncQueueTableTable, SyncQueueTableData>
    ),
    SyncQueueTableData,
    PrefetchHooks Function()> {
  $$SyncQueueTableTableTableManager(
      _$AppDatabase db, $SyncQueueTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> operacion = const Value.absent(),
            Value<String> entidad = const Value.absent(),
            Value<String> entidadId = const Value.absent(),
            Value<String> payload = const Value.absent(),
            Value<int> intentos = const Value.absent(),
            Value<String?> error = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncQueueTableCompanion(
            id: id,
            operacion: operacion,
            entidad: entidad,
            entidadId: entidadId,
            payload: payload,
            intentos: intentos,
            error: error,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String operacion,
            required String entidad,
            required String entidadId,
            required String payload,
            Value<int> intentos = const Value.absent(),
            Value<String?> error = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncQueueTableCompanion.insert(
            id: id,
            operacion: operacion,
            entidad: entidad,
            entidadId: entidadId,
            payload: payload,
            intentos: intentos,
            error: error,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncQueueTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SyncQueueTableTable,
    SyncQueueTableData,
    $$SyncQueueTableTableFilterComposer,
    $$SyncQueueTableTableOrderingComposer,
    $$SyncQueueTableTableAnnotationComposer,
    $$SyncQueueTableTableCreateCompanionBuilder,
    $$SyncQueueTableTableUpdateCompanionBuilder,
    (
      SyncQueueTableData,
      BaseReferences<_$AppDatabase, $SyncQueueTableTable, SyncQueueTableData>
    ),
    SyncQueueTableData,
    PrefetchHooks Function()>;
typedef $$UsuariosTableTableCreateCompanionBuilder = UsuariosTableCompanion
    Function({
  required String id,
  required String email,
  required String nombre,
  required String rol,
  Value<String?> telefono,
  Value<bool> activo,
  Value<DateTime?> ultimoAcceso,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$UsuariosTableTableUpdateCompanionBuilder = UsuariosTableCompanion
    Function({
  Value<String> id,
  Value<String> email,
  Value<String> nombre,
  Value<String> rol,
  Value<String?> telefono,
  Value<bool> activo,
  Value<DateTime?> ultimoAcceso,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$UsuariosTableTableFilterComposer
    extends Composer<_$AppDatabase, $UsuariosTableTable> {
  $$UsuariosTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get rol => $composableBuilder(
      column: $table.rol, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get telefono => $composableBuilder(
      column: $table.telefono, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get activo => $composableBuilder(
      column: $table.activo, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get ultimoAcceso => $composableBuilder(
      column: $table.ultimoAcceso, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$UsuariosTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UsuariosTableTable> {
  $$UsuariosTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get rol => $composableBuilder(
      column: $table.rol, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get telefono => $composableBuilder(
      column: $table.telefono, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get activo => $composableBuilder(
      column: $table.activo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get ultimoAcceso => $composableBuilder(
      column: $table.ultimoAcceso,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$UsuariosTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsuariosTableTable> {
  $$UsuariosTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get rol =>
      $composableBuilder(column: $table.rol, builder: (column) => column);

  GeneratedColumn<String> get telefono =>
      $composableBuilder(column: $table.telefono, builder: (column) => column);

  GeneratedColumn<bool> get activo =>
      $composableBuilder(column: $table.activo, builder: (column) => column);

  GeneratedColumn<DateTime> get ultimoAcceso => $composableBuilder(
      column: $table.ultimoAcceso, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UsuariosTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsuariosTableTable,
    UsuariosTableData,
    $$UsuariosTableTableFilterComposer,
    $$UsuariosTableTableOrderingComposer,
    $$UsuariosTableTableAnnotationComposer,
    $$UsuariosTableTableCreateCompanionBuilder,
    $$UsuariosTableTableUpdateCompanionBuilder,
    (
      UsuariosTableData,
      BaseReferences<_$AppDatabase, $UsuariosTableTable, UsuariosTableData>
    ),
    UsuariosTableData,
    PrefetchHooks Function()> {
  $$UsuariosTableTableTableManager(_$AppDatabase db, $UsuariosTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsuariosTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsuariosTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsuariosTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<String> nombre = const Value.absent(),
            Value<String> rol = const Value.absent(),
            Value<String?> telefono = const Value.absent(),
            Value<bool> activo = const Value.absent(),
            Value<DateTime?> ultimoAcceso = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UsuariosTableCompanion(
            id: id,
            email: email,
            nombre: nombre,
            rol: rol,
            telefono: telefono,
            activo: activo,
            ultimoAcceso: ultimoAcceso,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String email,
            required String nombre,
            required String rol,
            Value<String?> telefono = const Value.absent(),
            Value<bool> activo = const Value.absent(),
            Value<DateTime?> ultimoAcceso = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              UsuariosTableCompanion.insert(
            id: id,
            email: email,
            nombre: nombre,
            rol: rol,
            telefono: telefono,
            activo: activo,
            ultimoAcceso: ultimoAcceso,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UsuariosTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UsuariosTableTable,
    UsuariosTableData,
    $$UsuariosTableTableFilterComposer,
    $$UsuariosTableTableOrderingComposer,
    $$UsuariosTableTableAnnotationComposer,
    $$UsuariosTableTableCreateCompanionBuilder,
    $$UsuariosTableTableUpdateCompanionBuilder,
    (
      UsuariosTableData,
      BaseReferences<_$AppDatabase, $UsuariosTableTable, UsuariosTableData>
    ),
    UsuariosTableData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$GalponesTableTableTableManager get galponesTable =>
      $$GalponesTableTableTableManager(_db, _db.galponesTable);
  $$LotesAvesTableTableTableManager get lotesAvesTable =>
      $$LotesAvesTableTableTableManager(_db, _db.lotesAvesTable);
  $$ProduccionHuevosTableTableTableManager get produccionHuevosTable =>
      $$ProduccionHuevosTableTableTableManager(_db, _db.produccionHuevosTable);
  $$EventosSanitariosTableTableTableManager get eventosSanitariosTable =>
      $$EventosSanitariosTableTableTableManager(
          _db, _db.eventosSanitariosTable);
  $$AlimentacionTableTableTableManager get alimentacionTable =>
      $$AlimentacionTableTableTableManager(_db, _db.alimentacionTable);
  $$MortalidadTableTableTableManager get mortalidadTable =>
      $$MortalidadTableTableTableManager(_db, _db.mortalidadTable);
  $$InventarioFotoTableTableTableManager get inventarioFotoTable =>
      $$InventarioFotoTableTableTableManager(_db, _db.inventarioFotoTable);
  $$SyncQueueTableTableTableManager get syncQueueTable =>
      $$SyncQueueTableTableTableManager(_db, _db.syncQueueTable);
  $$UsuariosTableTableTableManager get usuariosTable =>
      $$UsuariosTableTableTableManager(_db, _db.usuariosTable);
}
