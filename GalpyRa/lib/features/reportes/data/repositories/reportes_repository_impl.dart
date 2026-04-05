import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/reporte.dart';
import '../../domain/repositories/reportes_repository.dart';
import '../datasources/reportes_remote_ds.dart';
import '../models/reporte_model.dart';

/// Implementación del repositorio de reportes
class ReportesRepositoryImpl implements ReportesRepository {
  final ReportesRemoteDataSource remoteDataSource;

  ReportesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Reporte>> generarReporte(
    ParametrosReporte parametros,
  ) async {
    try {
      final modelo = ParametrosReporteModel.fromEntity(parametros);
      final result = await remoteDataSource.generarReporte(modelo);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: 'Error al generar reporte: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Reporte>>> obtenerHistorialReportes({
    TipoReporte? tipo,
    int limit = 20,
  }) async {
    try {
      final result = await remoteDataSource.obtenerHistorialReportes(
        tipo: tipo,
        limit: limit,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: 'Error al obtener historial: $e'));
    }
  }

  @override
  Future<Either<Failure, Reporte>> obtenerReportePorId(String id) async {
    try {
      final result = await remoteDataSource.obtenerReportePorId(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: 'Error al obtener reporte: $e'));
    }
  }

  @override
  Future<Either<Failure, String>> exportarReporte(
    String reporteId,
    FormatoExportacion formato,
  ) async {
    try {
      final url = await remoteDataSource.exportarReporte(reporteId, formato);
      return Right(url);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: 'Error al exportar reporte: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> eliminarReporte(String id) async {
    try {
      await remoteDataSource.eliminarReporte(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: 'Error al eliminar reporte: $e'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> obtenerDatosDashboard(
    DateTime fechaInicio,
    DateTime fechaFin,
  ) async {
    try {
      final result = await remoteDataSource.obtenerDatosDashboard(
        fechaInicio,
        fechaFin,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: 'Error al obtener datos dashboard: $e'));
    }
  }
}
