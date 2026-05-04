import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/reporte.dart';

/// Repositorio abstracto para reportes
abstract class ReportesRepository {
  /// Genera un nuevo reporte
  Future<Either<Failure, Reporte>> generarReporte(ParametrosReporte parametros);

  /// Obtiene historial de reportes generados
  Future<Either<Failure, List<Reporte>>> obtenerHistorialReportes({
    TipoReporte? tipo,
    int limit = 20,
  });

  /// Obtiene un reporte por ID
  Future<Either<Failure, Reporte>> obtenerReportePorId(String id);

  /// Exporta un reporte a un formato específico
  Future<Either<Failure, String>> exportarReporte(
    String reporteId,
    FormatoExportacion formato,
  );

  /// Obtiene la URL de descarga del reporte
  Future<Either<Failure, String>> obtenerUrlDescarga(String reporteId);

  /// Elimina un reporte
  Future<Either<Failure, void>> eliminarReporte(String id);

  /// Obtiene datos para dashboard de resumen
  Future<Either<Failure, Map<String, dynamic>>> obtenerDatosDashboard(
    DateTime fechaInicio,
    DateTime fechaFin,
  );
}
