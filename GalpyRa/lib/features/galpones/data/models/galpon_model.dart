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
    super.sincronizado,
    required super.createdAt,
    required super.updatedAt,
    super.deletedAt,
  });

  factory GalponModel.fromJson(Map<String, dynamic> json) {
    final now = DateTime.now();
    return GalponModel(
      id: json['id'] as String,
      nombre: json['nombre'] as String,
      descripcion: json['descripcion'] as String?,
      capacidadMaxima: json['capacidad_maxima'] as int,
      cantidadActual: json['cantidad_actual'] as int? ?? 0,
      ubicacion: json['ubicacion'] as String?,
      activo: json['activo'] as bool? ?? true,
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
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'capacidad_maxima': capacidadMaxima,
      'cantidad_actual': cantidadActual,
      'ubicacion': ubicacion,
      'activo': activo,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      if (deletedAt != null) 'deleted_at': deletedAt!.toIso8601String(),
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
      sincronizado: galpon.sincronizado,
      createdAt: galpon.createdAt,
      updatedAt: galpon.updatedAt,
      deletedAt: galpon.deletedAt,
    );
  }
}
