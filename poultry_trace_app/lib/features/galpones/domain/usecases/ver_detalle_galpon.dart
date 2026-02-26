import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/galpon.dart';
import '../repositories/galpon_repository.dart';

/// Ver detalle de galpon use case
class VerDetalleGalponUseCase {
  final GalponRepository _repository;

  VerDetalleGalponUseCase(this._repository);

  Future<Either<Failure, Galpon>> call(String id) {
    return _repository.obtenerGalpon(id);
  }
}
