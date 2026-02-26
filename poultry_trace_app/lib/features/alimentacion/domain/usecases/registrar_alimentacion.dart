import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/registro_alimentacion.dart';
import '../repositories/alimentacion_repository.dart';

/// Registrar alimentación use case
class RegistrarAlimentacionUseCase {
  final AlimentacionRepository _repository;

  RegistrarAlimentacionUseCase(this._repository);

  Future<Either<Failure, RegistroAlimentacion>> call({
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
  }) {
    return _repository.registrarAlimentacion(
      galponId: galponId,
      fecha: fecha,
      tipoAlimento: tipoAlimento,
      nombreAlimento: nombreAlimento,
      cantidadKg: cantidadKg,
      costoUnitario: costoUnitario,
      numeroAves: numeroAves,
      loteAlimento: loteAlimento,
      proveedor: proveedor,
      observaciones: observaciones,
    );
  }
}
