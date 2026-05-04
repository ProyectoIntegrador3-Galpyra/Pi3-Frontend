import 'package:equatable/equatable.dart';

int _asInt(dynamic value) {
  if (value is num) return value.toInt();
  return int.tryParse((value ?? '').toString().trim()) ?? 0;
}

double _asDouble(dynamic value) {
  if (value is num) return value.toDouble();
  final normalized = (value ?? '').toString().trim().replaceAll(',', '.');
  return double.tryParse(normalized) ?? 0;
}

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
      totalHuevos: _asInt(json['total_huevos']),
      promedioDiario: _asDouble(json['promedio_diario']),
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
      totalKg: _asDouble(json['total_kg']),
      costoTotal: _asDouble(json['costo_total']),
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
      totalBajas: _asInt(json['total_bajas']),
      tasaMortalidad: _asDouble(json['tasa_mortalidad']),
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
      avesIniciales: _asInt(json['aves_iniciales']),
      bajas: _asInt(json['bajas']),
      avesActuales: _asInt(json['aves_actuales']),
    );
  }

  @override
  List<Object?> get props => [galpon, avesIniciales, bajas, avesActuales];
}
