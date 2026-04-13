import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/conteo_foto.dart';
import '../repositories/inventario_foto_repository.dart';

/// Procesar imagen para conteo use case
class ProcesarImagenConteoUseCase {
  final InventarioFotoRepository _repository;

  ProcesarImagenConteoUseCase(this._repository);

  Future<Either<Failure, ConteoFoto>> call({
    required String galponId,
    required Uint8List imageBytes,
    required String imageFilename,
  }) {
    return _repository.procesarImagen(
      galponId: galponId,
      imageBytes: imageBytes,
      imageFilename: imageFilename,
    );
  }
}
