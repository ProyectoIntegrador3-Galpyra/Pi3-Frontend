import 'package:equatable/equatable.dart';

/// Entidad de registro de producción de huevos
class ProduccionHuevos extends Equatable {
  final String id;
  final String galponId;
  final DateTime fecha;
  final int cantidadTotal;
  final int huevosRotos;
  final int huevosSucios;
  final int huevosGrandeAA;
  final int huevosGrandeA;
  final int huevosMediano;
  final int huevosPequeno;
  final double porcentajePostura;
  final String? observaciones;
  final DateTime createdAt;

  const ProduccionHuevos({
    required this.id,
    required this.galponId,
    required this.fecha,
    required this.cantidadTotal,
    this.huevosRotos = 0,
    this.huevosSucios = 0,
    this.huevosGrandeAA = 0,
    this.huevosGrandeA = 0,
    this.huevosMediano = 0,
    this.huevosPequeno = 0,
    this.porcentajePostura = 0.0,
    this.observaciones,
    required this.createdAt,
  });

  /// Huevos aptos para venta
  int get huevosAptos => cantidadTotal - huevosRotos - huevosSucios;

  /// Porcentaje de merma
  double get porcentajeMerma => cantidadTotal > 0
      ? ((huevosRotos + huevosSucios) / cantidadTotal) * 100
      : 0.0;

  @override
  List<Object?> get props => [
        id,
        galponId,
        fecha,
        cantidadTotal,
        huevosRotos,
        huevosSucios,
        huevosGrandeAA,
        huevosGrandeA,
        huevosMediano,
        huevosPequeno,
        porcentajePostura,
        observaciones,
        createdAt,
      ];
}
