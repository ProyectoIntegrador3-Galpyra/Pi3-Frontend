import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_ds.dart';
import '../models/app_settings_model.dart';

/// Implementación del repositorio de configuraciones
class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, AppSettings>> obtenerSettings() async {
    try {
      final settings = await localDataSource.obtenerSettings();
      return Right(settings);
    } catch (e) {
      return Left(CacheFailure(message: 'Error al obtener configuración: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> guardarSettings(AppSettings settings) async {
    try {
      final model = AppSettingsModel.fromEntity(settings);
      await localDataSource.guardarSettings(model);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: 'Error al guardar configuración: $e'));
    }
  }

  @override
  Future<Either<Failure, T>> obtenerValor<T>(String key) async {
    try {
      final value = await localDataSource.obtenerValor<T>(key);
      if (value == null) {
        return Left(CacheFailure(message: 'Valor no encontrado'));
      }
      return Right(value);
    } catch (e) {
      return Left(CacheFailure(message: 'Error al obtener valor: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> guardarValor<T>(String key, T value) async {
    try {
      await localDataSource.guardarValor<T>(key, value);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: 'Error al guardar valor: $e'));
    }
  }

  @override
  Future<Either<Failure, AppSettings>> resetearSettings() async {
    try {
      await localDataSource.limpiarTodo();
      const defaultSettings = AppSettingsModel();
      await localDataSource.guardarSettings(defaultSettings);
      return const Right(defaultSettings);
    } catch (e) {
      return Left(CacheFailure(message: 'Error al resetear configuración: $e'));
    }
  }

  @override
  Future<Either<Failure, String>> exportarSettings() async {
    try {
      final data = await localDataSource.exportarSettings();
      return Right(data);
    } catch (e) {
      return Left(CacheFailure(message: 'Error al exportar configuración: $e'));
    }
  }

  @override
  Future<Either<Failure, AppSettings>> importarSettings(String data) async {
    try {
      final settings = await localDataSource.importarSettings(data);
      return Right(settings);
    } catch (e) {
      return Left(CacheFailure(message: 'Error al importar configuración: $e'));
    }
  }
}
