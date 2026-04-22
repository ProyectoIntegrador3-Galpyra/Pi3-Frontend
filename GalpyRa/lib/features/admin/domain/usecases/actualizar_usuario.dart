import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/usuario_admin.dart';
import '../repositories/admin_repository.dart';

class ActualizarUsuarioUseCase {
  final AdminRepository _repository;

  ActualizarUsuarioUseCase(this._repository);

  Future<Either<Failure, UsuarioAdmin>> call(
    String id, {
    String? nombre,
    String? email,
    String? password,
    String? role,
  }) {
    return _repository.actualizarUsuario(
      id,
      nombre: nombre,
      email: email,
      password: password,
      role: role,
    );
  }
}
