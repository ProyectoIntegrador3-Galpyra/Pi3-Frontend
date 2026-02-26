import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/galpon.dart';
import '../repositories/galpon_repository.dart';

/// Crear galpon use case
class CrearGalponUseCase {
  final GalponRepository _repository;

  CrearGalponUseCase(this._repository);

  Future<Either<Failure, Galpon>> call(Galpon galpon) {
    return _repository.crearGalpon(galpon);
  }
}
