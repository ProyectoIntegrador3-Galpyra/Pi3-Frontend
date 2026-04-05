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
      id: json['id'].toString(),
      tipo: TipoReporte.values.firstWhere(
        (e) => e.name == (json['tipo']?.toString().toLowerCase() ?? ''),
        orElse: () => TipoReporte.produccion,
      ),
      titulo: (json['titulo'] ?? 'Reporte').toString(),
      descripcion: json['descripcion'] as String?,
      fechaInicio: DateTime.parse((json['fecha_inicio'] ?? json['fechaInicio']).toString()),
      fechaFin: DateTime.parse((json['fecha_fin'] ?? json['fechaFin']).toString()),
      fechaGeneracion: DateTime.parse((json['fecha_generacion'] ?? json['fechaGeneracion']).toString()),
      galponId: (json['galpon_id'] ?? json['galponId'])?.toString(),
      datos: json['datos'] as Map<String, dynamic>? ?? {},
      resumen: json['resumen'] as Map<String, dynamic>?,
      archivoUrl: (json['url_reporte'] ?? json['archivoUrl'])?.toString(),
      formato: (json['formato'] ?? json['format']) != null
          ? FormatoExportacion.values.firstWhere(
              (e) => e.name == (json['formato'] ?? json['format']).toString().toLowerCase(),
              orElse: () => FormatoExportacion.pdf,
            )
          : null,
    );
  }

  factory ReporteModel.fromBackend(Map<String, dynamic> json) {
    final normalized = <String, dynamic>{
      ...json,
      if (json['fecha_inicio'] == null && json['fechaInicio'] == null) 'fecha_inicio': DateTime.now().toIso8601String(),
      if (json['fecha_fin'] == null && json['fechaFin'] == null) 'fecha_fin': DateTime.now().toIso8601String(),
      if (json['fecha_generacion'] == null && json['fechaGeneracion'] == null)
        'fecha_generacion': DateTime.now().toIso8601String(),
    };
    return ReporteModel.fromJson(normalized);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tipo': tipo.name,
      'titulo': titulo,
      'descripcion': descripcion,
      'fecha_inicio': fechaInicio.toIso8601String(),
      'fecha_fin': fechaFin.toIso8601String(),
      'fecha_generacion': fechaGeneracion.toIso8601String(),
      'galpon_id': galponId,
      'datos': datos,
      'resumen': resumen,
      'url_reporte': archivoUrl,
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
      'fecha_inicio': fechaInicio.toIso8601String(),
      'fecha_fin': fechaFin.toIso8601String(),
      'galpon_id': galponId,
      'formato': formato?.name,
      'filtros_adicionales': filtrosAdicionales,
    };
  }
}
