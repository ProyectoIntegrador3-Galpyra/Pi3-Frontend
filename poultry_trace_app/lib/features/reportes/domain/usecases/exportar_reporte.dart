import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/reporte.dart';
import '../repositories/reportes_repository.dart';

/// Caso de uso para exportar un reporte
class ExportarReporte {
  final ReportesRepository repository;

  ExportarReporte(this.repository);

  Future<Either<Failure, String>> call(
    String reporteId,
    FormatoExportacion formato,
  ) {
    return repository.exportarReporte(reporteId, formato);
  }
}
