import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/produccion_huevos.dart';
import '../repositories/produccion_huevos_repository.dart';

/// Obtener historial de producción use case
class ObtenerHistorialProduccionUseCase {
  final ProduccionHuevosRepository _repository;

  ObtenerHistorialProduccionUseCase(this._repository);

  Future<Either<Failure, List<ProduccionHuevos>>> call(
    String galponId, {
    DateTime? desde,
    DateTime? hasta,
  }) {
    return _repository.obtenerHistorial(galponId, desde: desde, hasta: hasta);
  }
}
