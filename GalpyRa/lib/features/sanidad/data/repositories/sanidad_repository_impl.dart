import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/registro_sanitario.dart';
import '../../domain/repositories/sanidad_repository.dart';
import '../datasources/sanidad_remote_ds.dart';

/// Implementación del repositorio de sanidad
class SanidadRepositoryImpl implements SanidadRepository {
  final SanidadRemoteDataSource _remoteDataSource;

  SanidadRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<RegistroSanitario>>> obtenerHistorial(
    String galponId, {
    TipoEventoSanitario? tipo,
    DateTime? desde,
    DateTime? hasta,
  }) async {
    try {
      final registros = await _remoteDataSource.obtenerHistorial(
        galponId,
        tipo: tipo,
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
  Future<Either<Failure, RegistroSanitario>> registrarEvento({
    required String galponId,
    required TipoEventoSanitario tipo,
    required DateTime fecha,
    required String descripcion,
    String? medicamento,
    String? dosis,
    String? veterinario,
    int? avesAfectadas,
    DateTime? fechaProximaAplicacion,
    String? observaciones,
  }) async {
    try {
      final registro = await _remoteDataSource.registrarEvento(
        galponId: galponId,
        tipo: tipo,
        fecha: fecha,
        descripcion: descripcion,
        medicamento: medicamento,
        dosis: dosis,
        veterinario: veterinario,
        avesAfectadas: avesAfectadas,
        fechaProximaAplicacion: fechaProximaAplicacion,
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
  Future<Either<Failure, List<RegistroSanitario>>> obtenerPendientes() async {
    try {
      final pendientes = await _remoteDataSource.obtenerPendientes();
      return Right(pendientes.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> obtenerResumen(String galponId) async {
    try {
      final resumen = await _remoteDataSource.obtenerResumen(galponId);
      return Right(resumen);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}
