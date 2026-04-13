import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/lote_aves.dart';

/// Aves repository interface
abstract class AvesRepository {
  Future<Either<Failure, List<LoteAves>>> consultarInventario(String? galponId);
  Future<Either<Failure, void>> registrarMortalidad({
    required String galponId,
    required int cantidad,
    required String causa,
    required DateTime fecha,
    String? observaciones,
  });
  Future<Either<Failure, LoteAves>> registrarIngreso(
    LoteAves lote, {
    String? nombreLote,
  });
}
