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
    return RegistroSanitarioModel(
      id: json['id'] as String,
      galponId: json['galpon_id'] as String,
      tipo: TipoEventoSanitario.values.firstWhere(
        (e) => e.name == json['tipo'],
        orElse: () => TipoEventoSanitario.inspeccion,
      ),
      fecha: DateTime.parse(json['fecha'] as String),
      descripcion: json['descripcion'] as String,
      medicamento: json['medicamento'] as String?,
      dosis: json['dosis'] as String?,
      veterinario: json['veterinario'] as String?,
      avesAfectadas: json['aves_afectadas'] as int?,
      fechaProximaAplicacion: json['fecha_proxima_aplicacion'] != null
          ? DateTime.parse(json['fecha_proxima_aplicacion'] as String)
          : null,
      observaciones: json['observaciones'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
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
