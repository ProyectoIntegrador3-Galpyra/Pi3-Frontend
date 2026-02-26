import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/galpon.dart';
import '../repositories/galpon_repository.dart';

/// Listar galpones use case
class ListarGalponesUseCase {
  final GalponRepository _repository;

  ListarGalponesUseCase(this._repository);

  Future<Either<Failure, List<Galpon>>> call() {
    return _repository.listarGalpones();
  }
}
