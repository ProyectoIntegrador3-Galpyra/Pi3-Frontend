import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../repositories/aves_repository.dart';

/// Registrar mortalidad use case
class RegistrarMortalidadUseCase {
  final AvesRepository _repository;

  RegistrarMortalidadUseCase(this._repository);

  Future<Either<Failure, void>> call({
    required String galponId,
    required int cantidad,
    required String causa,
    required DateTime fecha,
    String? observaciones,
  }) {
    return _repository.registrarMortalidad(
      galponId: galponId,
      cantidad: cantidad,
      causa: causa,
      fecha: fecha,
      observaciones: observaciones,
    );
  }
}
