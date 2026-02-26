import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/lote_aves.dart';
import '../../domain/repositories/aves_repository.dart';
import '../datasources/aves_local_ds.dart';
import '../datasources/aves_remote_ds.dart';

/// Implementación del repositorio de aves
class AvesRepositoryImpl implements AvesRepository {
  final AvesRemoteDataSource _remoteDataSource;
  final AvesLocalDataSource _localDataSource;

  AvesRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, List<LoteAves>>> consultarInventario(String? galponId) async {
    if (galponId == null) {
      return const Left(ValidationFailure(message: 'ID de galpón requerido'));
    }
    try {
      final lotes = await _remoteDataSource.consultarInventario(galponId);
      // Cache the response
      await _localDataSource.cacheInventario(galponId, lotes);
      return Right(lotes.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      // Try to get from cache on server error
      try {
        final cached = await _localDataSource.getInventarioCached(galponId);
        if (cached.isNotEmpty) {
          return Right(cached.map((e) => e.toEntity()).toList());
        }
      } catch (_) {}
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      // Try to get from cache on network error
      try {
        final cached = await _localDataSource.getInventarioCached(galponId);
        if (cached.isNotEmpty) {
          return Right(cached.map((e) => e.toEntity()).toList());
        }
      } catch (_) {}
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> registrarMortalidad({
    required String galponId,
    required int cantidad,
    required String causa,
    required DateTime fecha,
    String? observaciones,
  }) async {
    try {
      await _remoteDataSource.registrarMortalidad(
        galponId: galponId,
        cantidad: cantidad,
        causa: causa,
        fecha: fecha,
        observaciones: observaciones,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, LoteAves>> registrarIngreso(LoteAves lote) async {
    try {
      final result = await _remoteDataSource.registrarIngreso(
        galponId: lote.galponId,
        raza: lote.raza ?? '',
        cantidad: lote.cantidad,
        fechaIngreso: lote.fechaIngreso,
        edadSemanas: lote.edadSemanas,
        pesoPromedio: lote.pesoPromedio,
        observaciones: lote.observaciones,
      );
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}
