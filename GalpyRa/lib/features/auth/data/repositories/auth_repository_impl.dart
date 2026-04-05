import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_ds.dart';
import '../datasources/auth_local_ds.dart';
import '../models/user_model.dart';

/// Auth repository implementation
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _remoteDataSource.login(
        email: email,
        password: password,
      );

      final accessToken = (response['access_token'] ?? '').toString();
      final refreshToken = (response['refresh_token'] ?? '').toString();
      if (accessToken.isEmpty || refreshToken.isEmpty) {
        throw const ServerException(
          message: 'Respuesta de autenticacion incompleta',
          statusCode: 500,
        );
      }
      final userData = response['user'] as Map<String, dynamic>;
      final user = UserModel.fromJson(userData);

      // Cache tokens and user
      await _localDataSource.cacheToken(accessToken);
      await _localDataSource.cacheRefreshToken(refreshToken);
      await _localDataSource.cacheUser(user);

      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
      ));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _remoteDataSource.logout();
      await _localDataSource.clearAuthData();
      return const Right(null);
    } on ServerException catch (e) {
      // Still clear local data even if remote logout fails
      await _localDataSource.clearAuthData();
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      await _localDataSource.clearAuthData();
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getProfile() async {
    try {
      final user = await _remoteDataSource.getProfile();
      await _localDataSource.cacheUser(user);
      return Right(user);
    } on ServerException catch (e) {
      // Try to return cached user if remote fails
      final cachedUser = await _localDataSource.getCachedUser();
      if (cachedUser != null) {
        return Right(cachedUser);
      }
      return Left(ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
      ));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await _localDataSource.getToken();
    return token != null && token.isNotEmpty;
  }

  @override
  Future<User?> getCachedUser() async {
    return await _localDataSource.getCachedUser();
  }
}
