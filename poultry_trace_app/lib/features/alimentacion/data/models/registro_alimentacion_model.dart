import '../../domain/entities/registro_alimentacion.dart';

/// Modelo de registro de alimentación con serialización JSON
class RegistroAlimentacionModel extends RegistroAlimentacion {
  const RegistroAlimentacionModel({
    required super.id,
    required super.galponId,
    required super.fecha,
    required super.tipoAlimento,
    required super.nombreAlimento,
    required super.cantidadKg,
    super.costoUnitario,
    super.numeroAves,
    super.consumoPorAve,
    super.loteAlimento,
    super.proveedor,
    super.observaciones,
    required super.createdAt,
  });

  factory RegistroAlimentacionModel.fromJson(Map<String, dynamic> json) {
    return RegistroAlimentacionModel(
      id: json['id'] as String,
      galponId: json['galpon_id'] as String,
      fecha: DateTime.parse(json['fecha'] as String),
      tipoAlimento: TipoAlimento.values.firstWhere(
        (e) => e.name == json['tipo_alimento'],
        orElse: () => TipoAlimento.otro,
      ),
      nombreAlimento: json['nombre_alimento'] as String,
      cantidadKg: (json['cantidad_kg'] as num).toDouble(),
      costoUnitario: (json['costo_unitario'] as num?)?.toDouble(),
      numeroAves: json['numero_aves'] as int?,
      consumoPorAve: (json['consumo_por_ave'] as num?)?.toDouble(),
      loteAlimento: json['lote_alimento'] as String?,
      proveedor: json['proveedor'] as String?,
      observaciones: json['observaciones'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'galpon_id': galponId,
      'fecha': fecha.toIso8601String(),
      'tipo_alimento': tipoAlimento.name,
      'nombre_alimento': nombreAlimento,
      'cantidad_kg': cantidadKg,
      'costo_unitario': costoUnitario,
      'numero_aves': numeroAves,
      'consumo_por_ave': consumoPorAve,
      'lote_alimento': loteAlimento,
      'proveedor': proveedor,
      'observaciones': observaciones,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory RegistroAlimentacionModel.fromEntity(RegistroAlimentacion entity) {
    return RegistroAlimentacionModel(
      id: entity.id,
      galponId: entity.galponId,
      fecha: entity.fecha,
      tipoAlimento: entity.tipoAlimento,
      nombreAlimento: entity.nombreAlimento,
      cantidadKg: entity.cantidadKg,
      costoUnitario: entity.costoUnitario,
      numeroAves: entity.numeroAves,
      consumoPorAve: entity.consumoPorAve,
      loteAlimento: entity.loteAlimento,
      proveedor: entity.proveedor,
      observaciones: entity.observaciones,
      createdAt: entity.createdAt,
    );
  }

  RegistroAlimentacion toEntity() {
    return RegistroAlimentacion(
      id: id,
      galponId: galponId,
      fecha: fecha,
      tipoAlimento: tipoAlimento,
      nombreAlimento: nombreAlimento,
      cantidadKg: cantidadKg,
      costoUnitario: costoUnitario,
      numeroAves: numeroAves,
      consumoPorAve: consumoPorAve,
      loteAlimento: loteAlimento,
      proveedor: proveedor,
      observaciones: observaciones,
      createdAt: createdAt,
    );
  }
}
