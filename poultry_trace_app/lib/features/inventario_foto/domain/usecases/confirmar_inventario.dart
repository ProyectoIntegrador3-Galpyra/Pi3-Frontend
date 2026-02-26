import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../repositories/inventario_foto_repository.dart';

/// Confirmar inventario use case
class ConfirmarInventarioUseCase {
  final InventarioFotoRepository _repository;

  ConfirmarInventarioUseCase(this._repository);

  Future<Either<Failure, void>> call({
    required String galponId,
    required String conteoId,
    required int cantidadFinal,
  }) {
    return _repository.confirmarInventario(
      galponId: galponId,
      conteoId: conteoId,
      cantidadFinal: cantidadFinal,
    );
  }
}
