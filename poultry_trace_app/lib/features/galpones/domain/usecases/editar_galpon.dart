import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/galpon.dart';
import '../repositories/galpon_repository.dart';

/// Editar galpon use case
class EditarGalponUseCase {
  final GalponRepository _repository;

  EditarGalponUseCase(this._repository);

  Future<Either<Failure, Galpon>> call(Galpon galpon) {
    return _repository.editarGalpon(galpon);
  }
}
