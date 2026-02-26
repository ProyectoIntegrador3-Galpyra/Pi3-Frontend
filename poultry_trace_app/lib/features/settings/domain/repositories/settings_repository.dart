import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/app_settings.dart';

/// Repositorio abstracto para configuraciones
abstract class SettingsRepository {
  /// Obtiene la configuración actual
  Future<Either<Failure, AppSettings>> obtenerSettings();

  /// Guarda la configuración
  Future<Either<Failure, void>> guardarSettings(AppSettings settings);

  /// Obtiene un valor específico de configuración
  Future<Either<Failure, T>> obtenerValor<T>(String key);

  /// Guarda un valor específico de configuración
  Future<Either<Failure, void>> guardarValor<T>(String key, T value);

  /// Resetea a valores por defecto
  Future<Either<Failure, AppSettings>> resetearSettings();

  /// Exporta configuración (backup)
  Future<Either<Failure, String>> exportarSettings();

  /// Importa configuración (restore)
  Future<Either<Failure, AppSettings>> importarSettings(String data);
}
