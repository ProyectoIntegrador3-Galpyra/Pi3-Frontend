import '../../domain/entities/conteo_foto.dart';

/// Modelo de conteo por foto con serialización JSON
class ConteoFotoModel extends ConteoFoto {
  const ConteoFotoModel({
    required super.id,
    required super.galponId,
    required super.imagePath,
    required super.fechaCaptura,
    super.estado,
    super.conteoAutomatico,
    super.conteoManual,
    super.conteoFinal,
    super.confianza,
    super.mensajeError,
    super.metadatos,
    required super.createdAt,
  });

  factory ConteoFotoModel.fromJson(Map<String, dynamic> json) {
    return ConteoFotoModel(
      id: json['id'] as String,
      galponId: json['galpon_id'] as String,
      imagePath: json['image_path'] as String,
      fechaCaptura: DateTime.parse(json['fecha_captura'] as String),
      estado: EstadoConteo.values.firstWhere(
        (e) => e.name == json['estado'],
        orElse: () => EstadoConteo.pendiente,
      ),
      conteoAutomatico: json['conteo_automatico'] as int?,
      conteoManual: json['conteo_manual'] as int?,
      conteoFinal: json['conteo_final'] as int?,
      confianza: (json['confianza'] as num?)?.toDouble(),
      mensajeError: json['mensaje_error'] as String?,
      metadatos: json['metadatos'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'galpon_id': galponId,
      'image_path': imagePath,
      'fecha_captura': fechaCaptura.toIso8601String(),
      'estado': estado.name,
      'conteo_automatico': conteoAutomatico,
      'conteo_manual': conteoManual,
      'conteo_final': conteoFinal,
      'confianza': confianza,
      'mensaje_error': mensajeError,
      'metadatos': metadatos,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory ConteoFotoModel.fromEntity(ConteoFoto entity) {
    return ConteoFotoModel(
      id: entity.id,
      galponId: entity.galponId,
      imagePath: entity.imagePath,
      fechaCaptura: entity.fechaCaptura,
      estado: entity.estado,
      conteoAutomatico: entity.conteoAutomatico,
      conteoManual: entity.conteoManual,
      conteoFinal: entity.conteoFinal,
      confianza: entity.confianza,
      mensajeError: entity.mensajeError,
      metadatos: entity.metadatos,
      createdAt: entity.createdAt,
    );
  }

  ConteoFoto toEntity() {
    return ConteoFoto(
      id: id,
      galponId: galponId,
      imagePath: imagePath,
      fechaCaptura: fechaCaptura,
      estado: estado,
      conteoAutomatico: conteoAutomatico,
      conteoManual: conteoManual,
      conteoFinal: conteoFinal,
      confianza: confianza,
      mensajeError: mensajeError,
      metadatos: metadatos,
      createdAt: createdAt,
    );
  }
}
