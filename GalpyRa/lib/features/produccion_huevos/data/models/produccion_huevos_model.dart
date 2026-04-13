import '../../domain/entities/produccion_huevos.dart';

/// Modelo de producción de huevos con serialización JSON
class ProduccionHuevosModel extends ProduccionHuevos {
  const ProduccionHuevosModel({
    required super.id,
    required super.galponId,
    super.loteId,
    required super.fecha,
    required super.cantidadTotal,
    super.huevosRotos,
    super.huevosSucios,
    super.huevosGrandeAA,
    super.huevosGrandeA,
    super.huevosMediano,
    super.huevosPequeno,
    super.porcentajePostura,
    super.observaciones,
    super.sincronizado,
    required super.createdAt,
    required super.updatedAt,
    super.deletedAt,
  });

  factory ProduccionHuevosModel.fromJson(Map<String, dynamic> json) {
    final now = DateTime.now();
    return ProduccionHuevosModel(
      id: json['id'] as String,
      galponId: json['galpon_id'] as String,
      loteId: json['lote_id'] as String?,
      fecha: DateTime.parse(json['fecha'] as String),
      // Backend sends 'cantidad'; accept both for compatibility.
      cantidadTotal: (json['cantidad_total'] as int?) ?? (json['cantidad'] as int? ?? 0),
      huevosRotos: json['huevos_rotos'] as int? ?? 0,
      huevosSucios: json['huevos_sucios'] as int? ?? 0,
      huevosGrandeAA: json['huevos_grande_aa'] as int? ?? 0,
      huevosGrandeA: json['huevos_grande_a'] as int? ?? 0,
      huevosMediano: json['huevos_mediano'] as int? ?? 0,
      huevosPequeno: json['huevos_pequeno'] as int? ?? 0,
      porcentajePostura: (json['porcentaje_postura'] as num?)?.toDouble() ?? 0.0,
      observaciones: json['observaciones'] as String?,
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

  factory ProduccionHuevosModel.fromEntity(ProduccionHuevos entity) {
    return ProduccionHuevosModel(
      id: entity.id,
      galponId: entity.galponId,
      loteId: entity.loteId,
      fecha: entity.fecha,
      cantidadTotal: entity.cantidadTotal,
      huevosRotos: entity.huevosRotos,
      huevosSucios: entity.huevosSucios,
      huevosGrandeAA: entity.huevosGrandeAA,
      huevosGrandeA: entity.huevosGrandeA,
      huevosMediano: entity.huevosMediano,
      huevosPequeno: entity.huevosPequeno,
      porcentajePostura: entity.porcentajePostura,
      observaciones: entity.observaciones,
      sincronizado: entity.sincronizado,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      deletedAt: entity.deletedAt,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'galpon_id': galponId,
      'lote_id': loteId,
      'fecha': fecha.toIso8601String(),
      'cantidad_total': cantidadTotal,
      'huevos_rotos': huevosRotos,
      'huevos_sucios': huevosSucios,
      'huevos_grande_aa': huevosGrandeAA,
      'huevos_grande_a': huevosGrandeA,
      'huevos_mediano': huevosMediano,
      'huevos_pequeno': huevosPequeno,
      'porcentaje_postura': porcentajePostura,
      'observaciones': observaciones,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      if (deletedAt != null) 'deleted_at': deletedAt!.toIso8601String(),
    };
  }

  ProduccionHuevos toEntity() {
    return ProduccionHuevos(
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
    );
  }
}
