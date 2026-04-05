import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/registro_sanitario.dart';
import '../repositories/sanidad_repository.dart';

/// Obtener historial sanitario use case
class ObtenerHistorialSanitarioUseCase {
  final SanidadRepository _repository;

  ObtenerHistorialSanitarioUseCase(this._repository);

  Future<Either<Failure, List<RegistroSanitario>>> call(
    String galponId, {
    TipoEventoSanitario? tipo,
    DateTime? desde,
    DateTime? hasta,
  }) {
    return _repository.obtenerHistorial(
      galponId,
      tipo: tipo,
      desde: desde,
      hasta: hasta,
    );
  }
}
