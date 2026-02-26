import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/reporte.dart';
import '../repositories/reportes_repository.dart';

/// Caso de uso para generar un reporte
class GenerarReporte {
  final ReportesRepository repository;

  GenerarReporte(this.repository);

  Future<Either<Failure, Reporte>> call(ParametrosReporte parametros) {
    return repository.generarReporte(parametros);
  }
}
