import '../../domain/entities/reporte.dart';

/// Modelo de datos para Reporte
class ReporteModel extends Reporte {
  const ReporteModel({
    required super.id,
    required super.tipo,
    required super.titulo,
    super.descripcion,
    required super.fechaInicio,
    required super.fechaFin,
    required super.fechaGeneracion,
    super.galponId,
    required super.datos,
    super.resumen,
    super.archivoUrl,
    super.formato,
  });

  factory ReporteModel.fromJson(Map<String, dynamic> json) {
    return ReporteModel(
      id: json['id'] as String,
      tipo: TipoReporte.values.firstWhere(
        (e) => e.name == json['tipo'],
        orElse: () => TipoReporte.produccion,
      ),
      titulo: json['titulo'] as String,
      descripcion: json['descripcion'] as String?,
      fechaInicio: DateTime.parse(json['fechaInicio'] as String),
      fechaFin: DateTime.parse(json['fechaFin'] as String),
      fechaGeneracion: DateTime.parse(json['fechaGeneracion'] as String),
      galponId: json['galponId'] as String?,
      datos: json['datos'] as Map<String, dynamic>? ?? {},
      resumen: json['resumen'] as Map<String, dynamic>?,
      archivoUrl: json['archivoUrl'] as String?,
      formato: json['formato'] != null
          ? FormatoExportacion.values.firstWhere(
              (e) => e.name == json['formato'],
              orElse: () => FormatoExportacion.pdf,
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tipo': tipo.name,
      'titulo': titulo,
      'descripcion': descripcion,
      'fechaInicio': fechaInicio.toIso8601String(),
      'fechaFin': fechaFin.toIso8601String(),
      'fechaGeneracion': fechaGeneracion.toIso8601String(),
      'galponId': galponId,
      'datos': datos,
      'resumen': resumen,
      'archivoUrl': archivoUrl,
      'formato': formato?.name,
    };
  }

  factory ReporteModel.fromEntity(Reporte entity) {
    return ReporteModel(
      id: entity.id,
      tipo: entity.tipo,
      titulo: entity.titulo,
      descripcion: entity.descripcion,
      fechaInicio: entity.fechaInicio,
      fechaFin: entity.fechaFin,
      fechaGeneracion: entity.fechaGeneracion,
      galponId: entity.galponId,
      datos: entity.datos,
      resumen: entity.resumen,
      archivoUrl: entity.archivoUrl,
      formato: entity.formato,
    );
  }
}

/// Modelo para parámetros de reporte
class ParametrosReporteModel {
  final TipoReporte tipo;
  final DateTime fechaInicio;
  final DateTime fechaFin;
  final String? galponId;
  final FormatoExportacion? formato;
  final Map<String, dynamic>? filtrosAdicionales;

  ParametrosReporteModel({
    required this.tipo,
    required this.fechaInicio,
    required this.fechaFin,
    this.galponId,
    this.formato,
    this.filtrosAdicionales,
  });

  factory ParametrosReporteModel.fromEntity(ParametrosReporte params) {
    return ParametrosReporteModel(
      tipo: params.tipo,
      fechaInicio: params.fechaInicio,
      fechaFin: params.fechaFin,
      galponId: params.galponId,
      formato: params.formato,
      filtrosAdicionales: params.filtrosAdicionales,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tipo': tipo.name,
      'fechaInicio': fechaInicio.toIso8601String(),
      'fechaFin': fechaFin.toIso8601String(),
      'galponId': galponId,
      'formato': formato?.name,
      'filtrosAdicionales': filtrosAdicionales,
    };
  }
}
