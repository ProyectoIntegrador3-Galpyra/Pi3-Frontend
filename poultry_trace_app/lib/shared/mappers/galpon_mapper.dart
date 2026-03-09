import 'package:drift/drift.dart';
import '../../features/galpones/domain/entities/galpon.dart';
import '../../core/storage/database/app_database.dart';

/// Mapper para convertir entre Galpon (domain) y GalponesTableData (Drift)
class GalponMapper {
  GalponMapper._();

  /// Convierte de modelo Drift a entidad de dominio
  static Galpon fromDrift(GalponesTableData data) {
    return Galpon(
      id: data.id,
      nombre: data.nombre,
      descripcion: data.descripcion,
      capacidadMaxima: data.capacidadMaxima,
      cantidadActual: data.cantidadActual,
      ubicacion: data.ubicacion,
      activo: data.activo,
      sincronizado: data.sincronizado,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      deletedAt: data.deletedAt,
    );
  }

  /// Convierte de entidad de dominio a companion de Drift para insertar/actualizar
  static GalponesTableCompanion toDriftCompanion(Galpon entity) {
    return GalponesTableCompanion.insert(
      id: entity.id,
      nombre: entity.nombre,
      descripcion: Value(entity.descripcion),
      capacidadMaxima: entity.capacidadMaxima,
      cantidadActual: Value(entity.cantidadActual),
      ubicacion: Value(entity.ubicacion),
      activo: Value(entity.activo),
      sincronizado: Value(entity.sincronizado),
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      deletedAt: Value(entity.deletedAt),
    );
  }

  /// Convierte de JSON del API a entidad de dominio
  static Galpon fromJson(Map<String, dynamic> json) {
    return Galpon(
      id: json['id'] as String,
      nombre: json['nombre'] as String,
      descripcion: json['descripcion'] as String?,
      capacidadMaxima: json['capacidad_maxima'] as int? ?? json['capacidadMaxima'] as int? ?? 0,
      cantidadActual: json['cantidad_actual'] as int? ?? json['cantidadActual'] as int? ?? 0,
      ubicacion: json['ubicacion'] as String?,
      activo: json['activo'] as bool? ?? true,
      sincronizado: true, // Viene del servidor, ya está sincronizado
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at'] as String)
          : DateTime.now(),
      deletedAt: json['deleted_at'] != null 
          ? DateTime.parse(json['deleted_at'] as String)
          : null,
    );
  }

  /// Convierte de entidad de dominio a JSON para enviar al API
  static Map<String, dynamic> toJson(Galpon entity) {
    return {
      'id': entity.id,
      'nombre': entity.nombre,
      'descripcion': entity.descripcion,
      'capacidad_maxima': entity.capacidadMaxima,
      'cantidad_actual': entity.cantidadActual,
      'ubicacion': entity.ubicacion,
      'activo': entity.activo,
      'created_at': entity.createdAt.toIso8601String(),
      'updated_at': entity.updatedAt.toIso8601String(),
      if (entity.deletedAt != null) 'deleted_at': entity.deletedAt!.toIso8601String(),
    };
  }

  /// Convierte lista de modelos Drift a lista de entidades
  static List<Galpon> fromDriftList(List<GalponesTableData> dataList) {
    return dataList.map(fromDrift).toList();
  }

  /// Convierte lista de JSON a lista de entidades
  static List<Galpon> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((e) => fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
