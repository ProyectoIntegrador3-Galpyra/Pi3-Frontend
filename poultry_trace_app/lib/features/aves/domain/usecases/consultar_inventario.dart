import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/lote_aves.dart';
import '../repositories/aves_repository.dart';

/// Consultar inventario use case
class ConsultarInventarioUseCase {
  final AvesRepository _repository;

  ConsultarInventarioUseCase(this._repository);

  Future<Either<Failure, List<LoteAves>>> call([String? galponId]) {
    return _repository.consultarInventario(galponId);
  }
}
