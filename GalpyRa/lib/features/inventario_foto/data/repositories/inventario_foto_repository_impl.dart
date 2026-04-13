import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/storage/local_db.dart';
import '../../domain/entities/conteo_foto.dart';
import '../../domain/repositories/inventario_foto_repository.dart';
import '../datasources/inventario_foto_remote_ds.dart';

/// Implementación del repositorio de inventario por foto
class InventarioFotoRepositoryImpl implements InventarioFotoRepository {
  final InventarioFotoRemoteDataSource _remoteDataSource;

  InventarioFotoRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, ConteoFoto>> procesarImagen({
    required String galponId,
    required Uint8List imageBytes,
    required String imageFilename,
  }) async {
    try {
      final conteo = await _remoteDataSource.procesarImagen(
        galponId: galponId,
        imageBytes: imageBytes,
        imageFilename: imageFilename,
      );
      return Right(conteo.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ConteoFoto>> actualizarConteo({
    required String conteoId,
    required int conteoManual,
    int? conteoFinal,
  }) async {
    try {
      final conteo = await _remoteDataSource.actualizarConteo(
        conteoId: conteoId,
        conteoManual: conteoManual,
        conteoFinal: conteoFinal,
      );
      return Right(conteo.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> confirmarInventario({
    required String galponId,
    required String conteoId,
    required int cantidadFinal,
  }) async {
    try {
      await _remoteDataSource.confirmarInventario(
        galponId: galponId,
        conteoId: conteoId,
        cantidadFinal: cantidadFinal,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      final opId =
          'inventario-confirmar-${DateTime.now().millisecondsSinceEpoch}';
      try {
        await LocalDb.syncQueueDao.addToQueue(
          id: opId,
          operacion: 'UPSERT',
          entidad: 'inventario_foto',
          entidadId: conteoId,
          payload: {
            'job_id': conteoId,
            'galpon_id': galponId,
            'conteo_confirmado': cantidadFinal,
            'cantidad_final': cantidadFinal,
            'conteo_final': cantidadFinal,
            'endpoint': '/api/inventario/confirmar',
          },
        );
        return const Right(null);
      } catch (_) {
        return Left(NetworkFailure(message: e.message));
      }
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ConteoFoto>>> obtenerHistorial(
      String galponId) async {
    try {
      final historial = await _remoteDataSource.obtenerHistorial(galponId);
      return Right(historial.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ConteoFoto>> obtenerConteo(String conteoId) async {
    try {
      final conteo = await _remoteDataSource.obtenerConteo(conteoId);
      return Right(conteo.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}
