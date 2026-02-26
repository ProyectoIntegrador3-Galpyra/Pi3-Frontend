import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/galpon.dart';

/// Galpon repository interface
abstract class GalponRepository {
  Future<Either<Failure, List<Galpon>>> listarGalpones();
  Future<Either<Failure, Galpon>> obtenerGalpon(String id);
  Future<Either<Failure, Galpon>> crearGalpon(Galpon galpon);
  Future<Either<Failure, Galpon>> editarGalpon(Galpon galpon);
  Future<Either<Failure, void>> eliminarGalpon(String id);
}
