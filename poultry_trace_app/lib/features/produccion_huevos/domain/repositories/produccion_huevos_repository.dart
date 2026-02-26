import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/produccion_huevos.dart';

/// Repositorio para producción de huevos
abstract class ProduccionHuevosRepository {
  /// Obtener historial de producción por galpón
  Future<Either<Failure, List<ProduccionHuevos>>> obtenerHistorial(
    String galponId, {
    DateTime? desde,
    DateTime? hasta,
  });

  /// Registrar producción diaria
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
  });

  /// Obtener estadísticas de producción
  Future<Either<Failure, Map<String, dynamic>>> obtenerEstadisticas(
    String galponId, {
    required DateTime desde,
    required DateTime hasta,
  });

  /// Obtener producción de hoy
  Future<Either<Failure, ProduccionHuevos?>> obtenerProduccionHoy(String galponId);
}
