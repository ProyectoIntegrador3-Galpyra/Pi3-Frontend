import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/usuario_admin.dart';
import '../repositories/admin_repository.dart';

class CrearUsuarioUseCase {
  final AdminRepository _repository;

  CrearUsuarioUseCase(this._repository);

  Future<Either<Failure, UsuarioAdmin>> call({
    required String nombre,
    required String email,
    required String password,
    required String role,
  }) {
    return _repository.crearUsuario(
      nombre: nombre,
      email: email,
      password: password,
      role: role,
    );
  }
}
