import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/registro_alimentacion.dart';
import '../repositories/alimentacion_repository.dart';

/// Obtener historial de alimentación use case
class ObtenerHistorialAlimentacionUseCase {
  final AlimentacionRepository _repository;

  ObtenerHistorialAlimentacionUseCase(this._repository);

  Future<Either<Failure, List<RegistroAlimentacion>>> call(
    String galponId, {
    DateTime? desde,
    DateTime? hasta,
  }) {
    return _repository.obtenerHistorial(galponId, desde: desde, hasta: hasta);
  }
}
