import '../../domain/entities/galpon.dart';

/// Galpon model for API serialization
class GalponModel extends Galpon {
  const GalponModel({
    required super.id,
    required super.nombre,
    super.descripcion,
    required super.capacidadMaxima,
    super.cantidadActual,
    super.ubicacion,
    super.activo,
    super.cantidadAvesActuales,
    super.cantidadLotesActivos,
    super.espacioDisponible,
    super.sincronizado,
    required super.createdAt,
    required super.updatedAt,
    super.deletedAt,
  });

  factory GalponModel.fromJson(Map<String, dynamic> json) {
    final now = DateTime.now();
    final capacidad = json['capacidad'] ?? json['capacidad_maxima'];
    // cantidad_aves_actuales es el campo nuevo del backend — tiene prioridad
    final cantidadActual = json['cantidad_aves_actuales'] ?? json['cantidad_actual'] ?? json['cantidad'];
    final estadoRaw = (json['estado'] ?? '').toString().toUpperCase();
    final activoRaw = json['activo'];
    final bool activo = activoRaw is bool
        ? activoRaw
        : (estadoRaw.isNotEmpty ? estadoRaw == 'ACTIVO' : true);

    final cantAvesActuales = json['cantidad_aves_actuales'] ?? json['cantidad_actual'] ?? json['cantidad'];
    final cantLotesActivos = json['cantidad_lotes_activos'];
    final espacioDisp = json['espacio_disponible'];

    return GalponModel(
      id: (json['id'] ?? '').toString(),
      nombre: (json['nombre'] ?? '').toString(),
      descripcion: json['descripcion'] as String?,
      capacidadMaxima: capacidad is num ? capacidad.toInt() : 0,
      cantidadActual: cantidadActual is num ? cantidadActual.toInt() : 0,
      ubicacion: json['ubicacion'] as String?,
      activo: activo,
      cantidadAvesActuales: cantAvesActuales is num ? cantAvesActuales.toInt() : 0,
      cantidadLotesActivos: cantLotesActivos is num ? cantLotesActivos.toInt() : 0,
      espacioDisponible: espacioDisp is num ? espacioDisp.toInt() : 0,
      sincronizado: true,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : now,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : now,
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final estado = activo ? 'ACTIVO' : 'INACTIVO';
    return {
      'nombre': nombre,
      'capacidad': capacidadMaxima,
      'ubicacion': ubicacion,
      'estado': estado,
      if (descripcion != null && descripcion!.trim().isNotEmpty)
        'descripcion': descripcion,
    };
  }

  factory GalponModel.fromEntity(Galpon galpon) {
    return GalponModel(
      id: galpon.id,
      nombre: galpon.nombre,
      descripcion: galpon.descripcion,
      capacidadMaxima: galpon.capacidadMaxima,
      cantidadActual: galpon.cantidadActual,
      ubicacion: galpon.ubicacion,
      activo: galpon.activo,
      cantidadAvesActuales: galpon.cantidadAvesActuales,
      cantidadLotesActivos: galpon.cantidadLotesActivos,
      espacioDisponible: galpon.espacioDisponible,
      sincronizado: galpon.sincronizado,
      createdAt: galpon.createdAt,
      updatedAt: galpon.updatedAt,
      deletedAt: galpon.deletedAt,
    );
  }
}
