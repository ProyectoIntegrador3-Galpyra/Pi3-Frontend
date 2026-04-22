import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/usuario_admin.dart';

abstract class AdminRepository {
  Future<Either<Failure, List<UsuarioAdmin>>> listarUsuarios();

  Future<Either<Failure, UsuarioAdmin>> crearUsuario({
    required String nombre,
    required String email,
    required String password,
    required String role,
  });

  Future<Either<Failure, UsuarioAdmin>> actualizarUsuario(
    String id, {
    String? nombre,
    String? email,
    String? password,
    String? role,
  });

  Future<Either<Failure, void>> eliminarUsuario(String id);
}
