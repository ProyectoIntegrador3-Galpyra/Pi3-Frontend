import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/registro_alimentacion.dart';

/// Repositorio de alimentación
abstract class AlimentacionRepository {
  /// Obtener historial de alimentación
  Future<Either<Failure, List<RegistroAlimentacion>>> obtenerHistorial(
    String galponId, {
    DateTime? desde,
    DateTime? hasta,
  });

  /// Registrar alimentación
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
  });

  /// Obtener consumo promedio
  Future<Either<Failure, Map<String, dynamic>>> obtenerConsumoPromedio(
    String galponId, {
    required DateTime desde,
    required DateTime hasta,
  });

  /// Obtener inventario de alimentos
  Future<Either<Failure, Map<String, double>>> obtenerInventarioAlimentos();
}
