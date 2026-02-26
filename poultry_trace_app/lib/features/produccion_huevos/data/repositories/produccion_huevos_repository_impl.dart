import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/produccion_huevos.dart';
import '../../domain/repositories/produccion_huevos_repository.dart';
import '../datasources/produccion_huevos_remote_ds.dart';

/// Implementación del repositorio de producción de huevos
class ProduccionHuevosRepositoryImpl implements ProduccionHuevosRepository {
  final ProduccionHuevosRemoteDataSource _remoteDataSource;

  ProduccionHuevosRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<ProduccionHuevos>>> obtenerHistorial(
    String galponId, {
    DateTime? desde,
    DateTime? hasta,
  }) async {
    try {
      final registros = await _remoteDataSource.obtenerHistorial(
        galponId,
        desde: desde,
        hasta: hasta,
      );
      return Right(registros.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProduccionHuevos>> registrarProduccion({
    required String galponId,
    required DateTime fecha,
    required int cantidadTotal,
    int huevosRotos = 0,
    int huevosSucios = 0,
    int huevosGrandeAA = 0,
    int huevosGrandeA = 0,
    int huevosMediano = 0,
    int huevosPequeno = 0,
    String? observaciones,
  }) async {
    try {
      final registro = await _remoteDataSource.registrarProduccion(
        galponId: galponId,
        fecha: fecha,
        cantidadTotal: cantidadTotal,
        huevosRotos: huevosRotos,
        huevosSucios: huevosSucios,
        huevosGrandeAA: huevosGrandeAA,
        huevosGrandeA: huevosGrandeA,
        huevosMediano: huevosMediano,
        huevosPequeno: huevosPequeno,
        observaciones: observaciones,
      );
      return Right(registro.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> obtenerEstadisticas(
    String galponId, {
    required DateTime desde,
    required DateTime hasta,
  }) async {
    try {
      final stats = await _remoteDataSource.obtenerEstadisticas(
        galponId,
        desde: desde,
        hasta: hasta,
      );
      return Right(stats);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProduccionHuevos?>> obtenerProduccionHoy(String galponId) async {
    try {
      final registro = await _remoteDataSource.obtenerProduccionHoy(galponId);
      return Right(registro?.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}
