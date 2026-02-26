import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/produccion_huevos.dart';
import '../repositories/produccion_huevos_repository.dart';

/// Registrar producción diaria use case
class RegistrarProduccionUseCase {
  final ProduccionHuevosRepository _repository;

  RegistrarProduccionUseCase(this._repository);

  Future<Either<Failure, ProduccionHuevos>> call({
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
  }) {
    return _repository.registrarProduccion(
      galponId: galponId,
      fecha: fecha,
      cantidadTotal: cantidadTotal,
      huevosRotos: huevosRotos,
      huevosSucios: huevosSucios,
      huevosGrandeAA: huevosGrandeAA,
      huevosGrandeA: huevosGrandeA,
      huevosMediano: huevosMediano,
      huevosPequeno: huevosPequeno,
      observaciones: observaciones,
    );
  }
}
