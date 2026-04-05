import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/galpon.dart';
import '../../domain/repositories/galpon_repository.dart';
import '../datasources/galpon_remote_ds.dart';
import '../datasources/galpon_local_ds.dart';
import '../models/galpon_model.dart';

/// Galpon repository implementation
class GalponRepositoryImpl implements GalponRepository {
  final GalponRemoteDataSource _remoteDataSource;
  final GalponLocalDataSource _localDataSource;

  GalponRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, List<Galpon>>> listarGalpones() async {
    try {
      final galpones = await _remoteDataSource.listarGalpones();
      await _localDataSource.cacheGalpones(galpones);
      return Right(galpones);
    } on ServerException catch (e) {
      // Try to return cached data
      try {
        final cached = await _localDataSource.getCachedGalpones();
        if (cached.isNotEmpty) {
          return Right(cached);
        }
      } catch (_) {}
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, Galpon>> obtenerGalpon(String id) async {
    try {
      final galpon = await _remoteDataSource.obtenerGalpon(id);
      await _localDataSource.cacheGalpon(galpon);
      return Right(galpon);
    } on ServerException catch (e) {
      final cached = await _localDataSource.getCachedGalpon(id);
      if (cached != null) {
        return Right(cached);
      }
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, Galpon>> crearGalpon(Galpon galpon) async {
    try {
      final model = GalponModel.fromEntity(galpon);
      final result = await _remoteDataSource.crearGalpon(model);
      await _localDataSource.cacheGalpon(result);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, Galpon>> editarGalpon(Galpon galpon) async {
    try {
      final model = GalponModel.fromEntity(galpon);
      final result = await _remoteDataSource.editarGalpon(model);
      await _localDataSource.cacheGalpon(result);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> eliminarGalpon(String id) async {
    try {
      await _remoteDataSource.eliminarGalpon(id);
      await _localDataSource.clearCache();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }
}
