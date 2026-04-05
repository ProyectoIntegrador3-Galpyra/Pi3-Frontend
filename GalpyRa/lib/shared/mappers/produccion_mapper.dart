import 'package:drift/drift.dart';
import '../../features/produccion_huevos/domain/entities/produccion_huevos.dart';
import '../../core/storage/database/app_database.dart';

/// Mapper para convertir entre ProduccionHuevos (domain) y ProduccionHuevosTableData (Drift)
class ProduccionMapper {
  ProduccionMapper._();

  /// Convierte de modelo Drift a entidad de dominio
  static ProduccionHuevos fromDrift(ProduccionHuevosTableData data) {
    return ProduccionHuevos(
      id: data.id,
      galponId: data.galponId,
      loteId: data.loteId,
      fecha: data.fecha,
      cantidadTotal: data.cantidadTotal,
      huevosRotos: data.huevosRotos,
      huevosSucios: data.huevosSucios,
      huevosGrandeAA: data.huevosGrandeAA,
      huevosGrandeA: data.huevosGrandeA,
      huevosMediano: data.huevosMediano,
      huevosPequeno: data.huevosPequeno,
      porcentajePostura: data.porcentajePostura,
      observaciones: data.observaciones,
      sincronizado: data.sincronizado,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      deletedAt: data.deletedAt,
    );
  }

  /// Convierte de entidad de dominio a companion de Drift para insertar/actualizar
  static ProduccionHuevosTableCompanion toDriftCompanion(ProduccionHuevos entity) {
    return ProduccionHuevosTableCompanion.insert(
      id: entity.id,
      galponId: entity.galponId,
      loteId: Value(entity.loteId),
      fecha: entity.fecha,
      cantidadTotal: entity.cantidadTotal,
      huevosRotos: Value(entity.huevosRotos),
      huevosSucios: Value(entity.huevosSucios),
      huevosGrandeAA: Value(entity.huevosGrandeAA),
      huevosGrandeA: Value(entity.huevosGrandeA),
      huevosMediano: Value(entity.huevosMediano),
      huevosPequeno: Value(entity.huevosPequeno),
      porcentajePostura: Value(entity.porcentajePostura),
      observaciones: Value(entity.observaciones),
      sincronizado: Value(entity.sincronizado),
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      deletedAt: Value(entity.deletedAt),
    );
  }

  /// Convierte de JSON del API a entidad de dominio
  static ProduccionHuevos fromJson(Map<String, dynamic> json) {
    return ProduccionHuevos(
      id: json['id'] as String,
      galponId: json['galpon_id'] as String? ?? json['galponId'] as String,
      loteId: json['lote_id'] as String? ?? json['loteId'] as String?,
      fecha: DateTime.parse(json['fecha'] as String),
      cantidadTotal: json['cantidad_total'] as int? ?? json['cantidadTotal'] as int? ?? 0,
      huevosRotos: json['huevos_rotos'] as int? ?? json['huevosRotos'] as int? ?? 0,
      huevosSucios: json['huevos_sucios'] as int? ?? json['huevosSucios'] as int? ?? 0,
      huevosGrandeAA: json['huevos_grande_aa'] as int? ?? json['huevosGrandeAA'] as int? ?? 0,
      huevosGrandeA: json['huevos_grande_a'] as int? ?? json['huevosGrandeA'] as int? ?? 0,
      huevosMediano: json['huevos_mediano'] as int? ?? json['huevosMediano'] as int? ?? 0,
      huevosPequeno: json['huevos_pequeno'] as int? ?? json['huevosPequeno'] as int? ?? 0,
      porcentajePostura: (json['porcentaje_postura'] as num?)?.toDouble() ?? 
                         (json['porcentajePostura'] as num?)?.toDouble() ?? 0.0,
      observaciones: json['observaciones'] as String?,
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
  static Map<String, dynamic> toJson(ProduccionHuevos entity) {
    return {
      'id': entity.id,
      'galpon_id': entity.galponId,
      'lote_id': entity.loteId,
      'fecha': entity.fecha.toIso8601String(),
      'cantidad_total': entity.cantidadTotal,
      'huevos_rotos': entity.huevosRotos,
      'huevos_sucios': entity.huevosSucios,
      'huevos_grande_aa': entity.huevosGrandeAA,
      'huevos_grande_a': entity.huevosGrandeA,
      'huevos_mediano': entity.huevosMediano,
      'huevos_pequeno': entity.huevosPequeno,
      'porcentaje_postura': entity.porcentajePostura,
      'observaciones': entity.observaciones,
      'created_at': entity.createdAt.toIso8601String(),
      'updated_at': entity.updatedAt.toIso8601String(),
      if (entity.deletedAt != null) 'deleted_at': entity.deletedAt!.toIso8601String(),
    };
  }

  /// Convierte lista de modelos Drift a lista de entidades
  static List<ProduccionHuevos> fromDriftList(List<ProduccionHuevosTableData> dataList) {
    return dataList.map(fromDrift).toList();
  }

  /// Convierte lista de JSON a lista de entidades
  static List<ProduccionHuevos> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((e) => fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
