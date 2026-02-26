import '../../domain/entities/lote_aves.dart';

/// Modelo para LoteAves con serialización JSON
class LoteAvesModel extends LoteAves {
  const LoteAvesModel({
    required super.id,
    required super.galponId,
    super.raza,
    required super.cantidad,
    required super.fechaIngreso,
    required super.edadSemanas,
    super.pesoPromedio,
    super.observaciones,
    required super.createdAt,
  });

  factory LoteAvesModel.fromJson(Map<String, dynamic> json) {
    return LoteAvesModel(
      id: json['id'] as String,
      galponId: json['galpon_id'] as String,
      raza: json['raza'] as String?,
      cantidad: json['cantidad'] as int,
      fechaIngreso: DateTime.parse(json['fecha_ingreso'] as String),
      edadSemanas: (json['edad_semanas'] as int?) ?? 0,
      pesoPromedio: (json['peso_promedio'] as num?)?.toDouble(),
      observaciones: json['observaciones'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'galpon_id': galponId,
      'raza': raza,
      'cantidad': cantidad,
      'fecha_ingreso': fechaIngreso.toIso8601String(),
      'edad_semanas': edadSemanas,
      'peso_promedio': pesoPromedio,
      'observaciones': observaciones,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory LoteAvesModel.fromEntity(LoteAves entity) {
    return LoteAvesModel(
      id: entity.id,
      galponId: entity.galponId,
      raza: entity.raza,
      cantidad: entity.cantidad,
      fechaIngreso: entity.fechaIngreso,
      edadSemanas: entity.edadSemanas,
      pesoPromedio: entity.pesoPromedio,
      observaciones: entity.observaciones,
      createdAt: entity.createdAt,
    );
  }

  LoteAves toEntity() {
    return LoteAves(
      id: id,
      galponId: galponId,
      raza: raza,
      cantidad: cantidad,
      fechaIngreso: fechaIngreso,
      edadSemanas: edadSemanas,
      pesoPromedio: pesoPromedio,
      observaciones: observaciones,
      createdAt: createdAt,
    );
  }
}
