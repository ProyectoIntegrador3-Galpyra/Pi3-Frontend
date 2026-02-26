import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/registro_sanitario.dart';
import '../repositories/sanidad_repository.dart';

/// Registrar evento sanitario use case
class RegistrarEventoSanitarioUseCase {
  final SanidadRepository _repository;

  RegistrarEventoSanitarioUseCase(this._repository);

  Future<Either<Failure, RegistroSanitario>> call({
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
  }) {
    return _repository.registrarEvento(
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
  }
}
