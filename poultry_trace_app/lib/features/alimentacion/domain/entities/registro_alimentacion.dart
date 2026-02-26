import 'package:equatable/equatable.dart';

/// Tipo de alimento
enum TipoAlimento {
  concentrado,
  maiz,
  soya,
  vitaminas,
  minerales,
  otro,
}

/// Entidad de registro de alimentación
class RegistroAlimentacion extends Equatable {
  final String id;
  final String galponId;
  final DateTime fecha;
  final TipoAlimento tipoAlimento;
  final String nombreAlimento;
  final double cantidadKg;
  final double? costoUnitario;
  final int? numeroAves;
  final double? consumoPorAve;
  final String? loteAlimento;
  final String? proveedor;
  final String? observaciones;
  final DateTime createdAt;

  const RegistroAlimentacion({
    required this.id,
    required this.galponId,
    required this.fecha,
    required this.tipoAlimento,
    required this.nombreAlimento,
    required this.cantidadKg,
    this.costoUnitario,
    this.numeroAves,
    this.consumoPorAve,
    this.loteAlimento,
    this.proveedor,
    this.observaciones,
    required this.createdAt,
  });

  /// Costo total
  double? get costoTotal => costoUnitario != null ? cantidadKg * costoUnitario! : null;

  /// Nombre del tipo de alimento
  String get tipoNombre {
    switch (tipoAlimento) {
      case TipoAlimento.concentrado:
        return 'Concentrado';
      case TipoAlimento.maiz:
        return 'Maíz';
      case TipoAlimento.soya:
        return 'Soya';
      case TipoAlimento.vitaminas:
        return 'Vitaminas';
      case TipoAlimento.minerales:
        return 'Minerales';
      case TipoAlimento.otro:
        return 'Otro';
    }
  }

  @override
  List<Object?> get props => [
        id,
        galponId,
        fecha,
        tipoAlimento,
        nombreAlimento,
        cantidadKg,
        costoUnitario,
        numeroAves,
        consumoPorAve,
        loteAlimento,
        proveedor,
        observaciones,
        createdAt,
      ];
}
