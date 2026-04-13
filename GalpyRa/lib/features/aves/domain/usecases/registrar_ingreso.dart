import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/lote_aves.dart';
import '../repositories/aves_repository.dart';

/// Registrar ingreso de aves use case
class RegistrarIngresoUseCase {
  final AvesRepository _repository;

  RegistrarIngresoUseCase(this._repository);

  Future<Either<Failure, LoteAves>> call({
    required String galponId,
    required String nombreLote,
    required String raza,
    required int cantidad,
    required DateTime fechaIngreso,
    int edadSemanas = 0,
    double? pesoPromedio,
    String? observaciones,
  }) {
    final lote = LoteAves(
      id: '',
      galponId: galponId,
      raza: raza,
      cantidad: cantidad,
      fechaIngreso: fechaIngreso,
      edadSemanas: edadSemanas,
      pesoPromedio: pesoPromedio,
      observaciones: observaciones,
      createdAt: DateTime.now(),
    );
    return _repository.registrarIngreso(lote, nombreLote: nombreLote);
  }
}
