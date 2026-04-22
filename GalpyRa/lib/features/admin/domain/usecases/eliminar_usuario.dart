import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../repositories/admin_repository.dart';

class EliminarUsuarioUseCase {
  final AdminRepository _repository;

  EliminarUsuarioUseCase(this._repository);

  Future<Either<Failure, void>> call(String id) {
    return _repository.eliminarUsuario(id);
  }
}
