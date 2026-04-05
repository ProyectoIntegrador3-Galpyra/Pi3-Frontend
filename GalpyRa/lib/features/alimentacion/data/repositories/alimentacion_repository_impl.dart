import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/registro_alimentacion.dart';
import '../../domain/repositories/alimentacion_repository.dart';
import '../datasources/alimentacion_remote_ds.dart';

/// Implementación del repositorio de alimentación
class AlimentacionRepositoryImpl implements AlimentacionRepository {
  final AlimentacionRemoteDataSource _remoteDataSource;

  AlimentacionRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<RegistroAlimentacion>>> obtenerHistorial(
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
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, RegistroAlimentacion>> registrarAlimentacion({
    required String galponId,
    required DateTime fecha,
    required TipoAlimento tipoAlimento,
    required String nombreAlimento,
    required double cantidadKg,
    double? costoUnitario,
    int? numeroAves,
    String? loteAlimento,
    String? proveedor,
    String? observaciones,
  }) async {
    try {
      final registro = await _remoteDataSource.registrarAlimentacion(
        galponId: galponId,
        fecha: fecha,
        tipoAlimento: tipoAlimento,
        nombreAlimento: nombreAlimento,
        cantidadKg: cantidadKg,
        costoUnitario: costoUnitario,
        numeroAves: numeroAves,
        loteAlimento: loteAlimento,
        proveedor: proveedor,
        observaciones: observaciones,
      );
      return Right(registro.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> obtenerConsumoPromedio(
    String galponId, {
    required DateTime desde,
    required DateTime hasta,
  }) async {
    try {
      final consumo = await _remoteDataSource.obtenerConsumoPromedio(
        galponId,
        desde: desde,
        hasta: hasta,
      );
      return Right(consumo);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, double>>> obtenerInventarioAlimentos() async {
    try {
      final inventario = await _remoteDataSource.obtenerInventarioAlimentos();
      return Right(inventario);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}
