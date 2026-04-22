import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/usuario_admin.dart';
import '../repositories/admin_repository.dart';

class ListarUsuariosUseCase {
  final AdminRepository _repository;

  ListarUsuariosUseCase(this._repository);

  Future<Either<Failure, List<UsuarioAdmin>>> call() {
    return _repository.listarUsuarios();
  }
}
