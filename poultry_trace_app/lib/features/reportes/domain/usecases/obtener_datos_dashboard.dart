import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../repositories/reportes_repository.dart';

/// Caso de uso para obtener datos del dashboard
class ObtenerDatosDashboard {
  final ReportesRepository repository;

  ObtenerDatosDashboard(this.repository);

  Future<Either<Failure, Map<String, dynamic>>> call(
    DateTime fechaInicio,
    DateTime fechaFin,
  ) {
    return repository.obtenerDatosDashboard(fechaInicio, fechaFin);
  }
}
