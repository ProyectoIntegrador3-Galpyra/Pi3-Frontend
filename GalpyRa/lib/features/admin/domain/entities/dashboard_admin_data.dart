import 'package:equatable/equatable.dart';

class DashboardAdminData extends Equatable {
  final int avesActivas;
  final int produccionHoy;
  final int produccionMes;
  final int mortalidadMes;
  final double tasaMortalidadMes;
  final double gastoAlimentoMes;
  final double gastoAlimentoAnio;
  final int galponesActivos;

  const DashboardAdminData({
    required this.avesActivas,
    required this.produccionHoy,
    required this.produccionMes,
    required this.mortalidadMes,
    required this.tasaMortalidadMes,
    required this.gastoAlimentoMes,
    required this.gastoAlimentoAnio,
    required this.galponesActivos,
  });

  factory DashboardAdminData.fromJson(Map<String, dynamic> json) {
    return DashboardAdminData(
      avesActivas: (json['aves_activas'] as num?)?.toInt() ?? 0,
      produccionHoy: (json['produccion_hoy'] as num?)?.toInt() ?? 0,
      produccionMes: (json['produccion_mes'] as num?)?.toInt() ?? 0,
      mortalidadMes: (json['mortalidad_mes'] as num?)?.toInt() ?? 0,
      tasaMortalidadMes: (json['tasa_mortalidad_mes'] as num?)?.toDouble() ?? 0,
      gastoAlimentoMes: (json['gasto_alimento_mes'] as num?)?.toDouble() ?? 0,
      gastoAlimentoAnio: (json['gasto_alimento_anio'] as num?)?.toDouble() ?? 0,
      galponesActivos: (json['galpones_activos'] as num?)?.toInt() ?? 0,
    );
  }

  @override
  List<Object?> get props => [
        avesActivas,
        produccionHoy,
        produccionMes,
        mortalidadMes,
        tasaMortalidadMes,
        gastoAlimentoMes,
        gastoAlimentoAnio,
        galponesActivos,
      ];
}
