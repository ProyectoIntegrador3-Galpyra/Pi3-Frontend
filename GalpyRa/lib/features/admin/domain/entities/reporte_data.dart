import 'package:equatable/equatable.dart';

class ReporteProduccionItem extends Equatable {
  final String periodo;
  final int totalHuevos;
  final double promedioDiario;

  const ReporteProduccionItem({
    required this.periodo,
    required this.totalHuevos,
    required this.promedioDiario,
  });

  factory ReporteProduccionItem.fromJson(Map<String, dynamic> json) {
    return ReporteProduccionItem(
      periodo: (json['periodo'] ?? '').toString(),
      totalHuevos: (json['total_huevos'] as num?)?.toInt() ?? 0,
      promedioDiario: (json['promedio_diario'] as num?)?.toDouble() ?? 0,
    );
  }

  @override
  List<Object?> get props => [periodo, totalHuevos, promedioDiario];
}

class ReporteAlimentacionItem extends Equatable {
  final String periodo;
  final double totalKg;
  final double costoTotal;

  const ReporteAlimentacionItem({
    required this.periodo,
    required this.totalKg,
    required this.costoTotal,
  });

  factory ReporteAlimentacionItem.fromJson(Map<String, dynamic> json) {
    return ReporteAlimentacionItem(
      periodo: (json['periodo'] ?? '').toString(),
      totalKg: (json['total_kg'] as num?)?.toDouble() ?? 0,
      costoTotal: (json['costo_total'] as num?)?.toDouble() ?? 0,
    );
  }

  @override
  List<Object?> get props => [periodo, totalKg, costoTotal];
}

class ReporteMortalidadItem extends Equatable {
  final String periodo;
  final int totalBajas;
  final double tasaMortalidad;

  const ReporteMortalidadItem({
    required this.periodo,
    required this.totalBajas,
    required this.tasaMortalidad,
  });

  factory ReporteMortalidadItem.fromJson(Map<String, dynamic> json) {
    return ReporteMortalidadItem(
      periodo: (json['periodo'] ?? '').toString(),
      totalBajas: (json['total_bajas'] as num?)?.toInt() ?? 0,
      tasaMortalidad: (json['tasa_mortalidad'] as num?)?.toDouble() ?? 0,
    );
  }

  @override
  List<Object?> get props => [periodo, totalBajas, tasaMortalidad];
}

class ReporteInventarioItem extends Equatable {
  final String galpon;
  final int avesIniciales;
  final int bajas;
  final int avesActuales;

  const ReporteInventarioItem({
    required this.galpon,
    required this.avesIniciales,
    required this.bajas,
    required this.avesActuales,
  });

  factory ReporteInventarioItem.fromJson(Map<String, dynamic> json) {
    return ReporteInventarioItem(
      galpon: (json['galpon'] ?? '').toString(),
      avesIniciales: (json['aves_iniciales'] as num?)?.toInt() ?? 0,
      bajas: (json['bajas'] as num?)?.toInt() ?? 0,
      avesActuales: (json['aves_actuales'] as num?)?.toInt() ?? 0,
    );
  }

  @override
  List<Object?> get props => [galpon, avesIniciales, bajas, avesActuales];
}
