import '../../domain/entities/registro_sanitario.dart';

/// Modelo de registro sanitario con serialización JSON
class RegistroSanitarioModel extends RegistroSanitario {
  const RegistroSanitarioModel({
    required super.id,
    required super.galponId,
    required super.tipo,
    required super.fecha,
    required super.descripcion,
    super.medicamento,
    super.dosis,
    super.veterinario,
    super.avesAfectadas,
    super.fechaProximaAplicacion,
    super.observaciones,
    required super.createdAt,
  });

  factory RegistroSanitarioModel.fromJson(Map<String, dynamic> json) {
    // Backend uses 'tipo_evento' with UPPERCASE values (VACUNACION, TRATAMIENTO…).
    // Frontend uses lowercase enum names. Map defensively.
    final tipoRaw =
        (json['tipo_evento'] ?? json['tipo'] ?? '').toString().toLowerCase();
    final tipoMapped = _parseTipoEvento(tipoRaw);

    return RegistroSanitarioModel(
      id: json['id'] as String,
      galponId: json['galpon_id'] as String,
      tipo: tipoMapped,
      fecha: DateTime.parse(json['fecha'] as String),
      descripcion: json['descripcion'] as String? ?? '',
      // Backend uses 'producto' for medicamento, 'responsable' for veterinario.
      medicamento: (json['medicamento'] ?? json['producto']) as String?,
      dosis: json['dosis'] as String?,
      veterinario: (json['veterinario'] ?? json['responsable']) as String?,
      avesAfectadas: json['aves_afectadas'] as int?,
      fechaProximaAplicacion: json['fecha_proxima_aplicacion'] != null
          ? DateTime.parse(json['fecha_proxima_aplicacion'] as String)
          : null,
      observaciones: json['observaciones'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
    );
  }

  factory RegistroSanitarioModel.fromEntity(RegistroSanitario entity) {
    return RegistroSanitarioModel(
      id: entity.id,
      galponId: entity.galponId,
      tipo: entity.tipo,
      fecha: entity.fecha,
      descripcion: entity.descripcion,
      medicamento: entity.medicamento,
      dosis: entity.dosis,
      veterinario: entity.veterinario,
      avesAfectadas: entity.avesAfectadas,
      fechaProximaAplicacion: entity.fechaProximaAplicacion,
      observaciones: entity.observaciones,
      createdAt: entity.createdAt,
    );
  }

  static TipoEventoSanitario _parseTipoEvento(String raw) {
    switch (raw) {
      case 'vacunacion':
        return TipoEventoSanitario.vacunacion;
      case 'tratamiento':
        return TipoEventoSanitario.tratamiento;
      case 'cuarentena':
        return TipoEventoSanitario.cuarentena;
      case 'desparasitacion':
        return TipoEventoSanitario.desparasitacion;
      case 'diagnostico':
        // Backend DIAGNOSTICO maps to cuarentena (closest frontend concept).
        return TipoEventoSanitario.cuarentena;
      case 'inspeccion':
      default:
        return TipoEventoSanitario.inspeccion;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'galpon_id': galponId,
      'tipo': tipo.name,
      'fecha': fecha.toIso8601String(),
      'descripcion': descripcion,
      'medicamento': medicamento,
      'dosis': dosis,
      'veterinario': veterinario,
      'aves_afectadas': avesAfectadas,
      'fecha_proxima_aplicacion': fechaProximaAplicacion?.toIso8601String(),
      'observaciones': observaciones,
      'created_at': createdAt.toIso8601String(),
    };
  }

  RegistroSanitario toEntity() {
    return RegistroSanitario(
      id: id,
      galponId: galponId,
      tipo: tipo,
      fecha: fecha,
      descripcion: descripcion,
      medicamento: medicamento,
      dosis: dosis,
      veterinario: veterinario,
      avesAfectadas: avesAfectadas,
      fechaProximaAplicacion: fechaProximaAplicacion,
      observaciones: observaciones,
      createdAt: createdAt,
    );
  }
}
