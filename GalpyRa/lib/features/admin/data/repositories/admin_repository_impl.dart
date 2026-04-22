import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/usuario_admin.dart';
import '../../domain/repositories/admin_repository.dart';
import '../datasources/admin_remote_ds.dart';

class AdminRepositoryImpl implements AdminRepository {
  final AdminRemoteDataSource _remoteDataSource;

  AdminRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<UsuarioAdmin>>> listarUsuarios() async {
    try {
      final result = await _remoteDataSource.listarUsuarios();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UsuarioAdmin>> crearUsuario({
    required String nombre,
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      final result = await _remoteDataSource.crearUsuario(
        nombre: nombre,
        email: email,
        password: password,
        role: role,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UsuarioAdmin>> actualizarUsuario(
    String id, {
    String? nombre,
    String? email,
    String? password,
    String? role,
  }) async {
    try {
      final result = await _remoteDataSource.actualizarUsuario(
        id,
        nombre: nombre,
        email: email,
        password: password,
        role: role,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> eliminarUsuario(String id) async {
    try {
      await _remoteDataSource.eliminarUsuario(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}
