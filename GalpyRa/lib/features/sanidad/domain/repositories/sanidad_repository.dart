import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/registro_sanitario.dart';

/// Repositorio para sanidad
abstract class SanidadRepository {
  /// Obtener historial sanitario por galpón
  Future<Either<Failure, List<RegistroSanitario>>> obtenerHistorial(
    String galponId, {
    TipoEventoSanitario? tipo,
    DateTime? desde,
    DateTime? hasta,
  });

  /// Registrar evento sanitario
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
  });

  /// Obtener eventos pendientes (próximas aplicaciones)
  Future<Either<Failure, List<RegistroSanitario>>> obtenerPendientes();

  /// Obtener resumen sanitario
  Future<Either<Failure, Map<String, dynamic>>> obtenerResumen(String galponId);
}
