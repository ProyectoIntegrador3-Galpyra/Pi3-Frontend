import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/conteo_foto.dart';

/// Repositorio de inventario por foto
abstract class InventarioFotoRepository {
  /// Procesar imagen para conteo automático
  Future<Either<Failure, ConteoFoto>> procesarImagen({
    required String galponId,
    required String imagePath,
  });

  /// Actualizar conteo manual después de revisión
  Future<Either<Failure, ConteoFoto>> actualizarConteo({
    required String conteoId,
    required int conteoManual,
    int? conteoFinal,
  });

  /// Confirmar y guardar inventario
  Future<Either<Failure, void>> confirmarInventario({
    required String galponId,
    required String conteoId,
    required int cantidadFinal,
  });

  /// Obtener historial de conteos por foto
  Future<Either<Failure, List<ConteoFoto>>> obtenerHistorial(String galponId);

  /// Obtener conteo por ID
  Future<Either<Failure, ConteoFoto>> obtenerConteo(String conteoId);
}
