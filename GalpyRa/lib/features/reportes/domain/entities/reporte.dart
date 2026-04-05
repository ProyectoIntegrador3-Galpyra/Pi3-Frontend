import 'package:equatable/equatable.dart';

/// Tipo de reporte
enum TipoReporte {
  produccion,
  mortalidad,
  alimentacion,
  sanitario,
  inventario,
  financiero,
}

/// Formato de exportación
enum FormatoExportacion {
  pdf,
  excel,
  csv,
}

/// Entidad que representa un reporte generado
class Reporte extends Equatable {
  final String id;
  final TipoReporte tipo;
  final String titulo;
  final String? descripcion;
  final DateTime fechaInicio;
  final DateTime fechaFin;
  final DateTime fechaGeneracion;
  final String? galponId;
  final Map<String, dynamic> datos;
  final Map<String, dynamic>? resumen;
  final String? archivoUrl;
  final FormatoExportacion? formato;

  const Reporte({
    required this.id,
    required this.tipo,
    required this.titulo,
    this.descripcion,
    required this.fechaInicio,
    required this.fechaFin,
    required this.fechaGeneracion,
    this.galponId,
    required this.datos,
    this.resumen,
    this.archivoUrl,
    this.formato,
  });

  @override
  List<Object?> get props => [
        id,
        tipo,
        titulo,
        descripcion,
        fechaInicio,
        fechaFin,
        fechaGeneracion,
        galponId,
        datos,
        resumen,
        archivoUrl,
        formato,
      ];
}

/// Parámetros para generar un reporte
class ParametrosReporte extends Equatable {
  final TipoReporte tipo;
  final DateTime fechaInicio;
  final DateTime fechaFin;
  final String? galponId;
  final FormatoExportacion? formato;
  final Map<String, dynamic>? filtrosAdicionales;

  const ParametrosReporte({
    required this.tipo,
    required this.fechaInicio,
    required this.fechaFin,
    this.galponId,
    this.formato,
    this.filtrosAdicionales,
  });

  @override
  List<Object?> get props => [
        tipo,
        fechaInicio,
        fechaFin,
        galponId,
        formato,
        filtrosAdicionales,
      ];
}
