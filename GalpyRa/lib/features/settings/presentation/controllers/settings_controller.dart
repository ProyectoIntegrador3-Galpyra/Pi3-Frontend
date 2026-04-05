import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/di/injector.dart';
import '../../domain/entities/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';

/// Estado del controlador de configuraciones
class SettingsState {
  final bool isLoading;
  final AppSettings settings;
  final String? errorMessage;
  final String? successMessage;

  const SettingsState({
    this.isLoading = false,
    this.settings = const AppSettings(),
    this.errorMessage,
    this.successMessage,
  });

  SettingsState copyWith({
    bool? isLoading,
    AppSettings? settings,
    String? errorMessage,
    String? successMessage,
    bool clearError = false,
    bool clearSuccess = false,
  }) {
    return SettingsState(
      isLoading: isLoading ?? this.isLoading,
      settings: settings ?? this.settings,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      successMessage: clearSuccess ? null : (successMessage ?? this.successMessage),
    );
  }
}

/// Controlador de configuraciones
class SettingsController extends StateNotifier<SettingsState> {
  final SettingsRepository _repository;

  SettingsController({required SettingsRepository repository})
      : _repository = repository,
        super(const SettingsState()) {
    cargarSettings();
  }

  /// Carga la configuración actual
  Future<void> cargarSettings() async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _repository.obtenerSettings();

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      ),
      (settings) => state = state.copyWith(
        isLoading: false,
        settings: settings,
      ),
    );
  }

  /// Actualiza la configuración
  Future<bool> actualizarSettings(AppSettings settings) async {
    state = state.copyWith(isLoading: true, clearError: true, clearSuccess: true);

    final result = await _repository.guardarSettings(settings);

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        );
        return false;
      },
      (_) {
        state = state.copyWith(
          isLoading: false,
          settings: settings,
          successMessage: 'Configuración guardada',
        );
        return true;
      },
    );
  }

  /// Cambia un valor específico
  Future<void> cambiarValor<T>({
    required String campo,
    required T valor,
  }) async {
    AppSettings nuevoSettings;

    switch (campo) {
      case 'idioma':
        nuevoSettings = state.settings.copyWith(idioma: valor as String);
        break;
      case 'notificacionesActivas':
        nuevoSettings = state.settings.copyWith(notificacionesActivas: valor as bool);
        break;
      case 'modOscuro':
        nuevoSettings = state.settings.copyWith(modOscuro: valor as bool);
        break;
      case 'sincronizacionAutomatica':
        nuevoSettings = state.settings.copyWith(sincronizacionAutomatica: valor as bool);
        break;
      case 'intervaloSincronizacion':
        nuevoSettings = state.settings.copyWith(intervaloSincronizacion: valor as int);
        break;
      case 'alertasProduccion':
        nuevoSettings = state.settings.copyWith(alertasProduccion: valor as bool);
        break;
      case 'alertasSanidad':
        nuevoSettings = state.settings.copyWith(alertasSanidad: valor as bool);
        break;
      case 'alertasInventario':
        nuevoSettings = state.settings.copyWith(alertasInventario: valor as bool);
        break;
      case 'umbralProduccionBaja':
        nuevoSettings = state.settings.copyWith(umbralProduccionBaja: valor as double);
        break;
      case 'umbralMortalidadAlta':
        nuevoSettings = state.settings.copyWith(umbralMortalidadAlta: valor as double);
        break;
      case 'nombreGranja':
        nuevoSettings = state.settings.copyWith(nombreGranja: valor as String);
        break;
      default:
        return;
    }

    await actualizarSettings(nuevoSettings);
  }

  /// Resetea a valores por defecto
  Future<bool> resetearSettings() async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _repository.resetearSettings();

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        );
        return false;
      },
      (settings) {
        state = state.copyWith(
          isLoading: false,
          settings: settings,
          successMessage: 'Configuración restablecida',
        );
        return true;
      },
    );
  }

  /// Exporta configuración
  Future<String?> exportarSettings() async {
    final result = await _repository.exportarSettings();
    return result.fold(
      (failure) {
        state = state.copyWith(errorMessage: failure.message);
        return null;
      },
      (data) => data,
    );
  }

  /// Importa configuración
  Future<bool> importarSettings(String data) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _repository.importarSettings(data);

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        );
        return false;
      },
      (settings) {
        state = state.copyWith(
          isLoading: false,
          settings: settings,
          successMessage: 'Configuración importada',
        );
        return true;
      },
    );
  }

  /// Limpia mensajes
  void clearMessages() {
    state = state.copyWith(clearError: true, clearSuccess: true);
  }
}

/// Provider del controlador de configuraciones
final settingsControllerProvider =
    StateNotifierProvider<SettingsController, SettingsState>((ref) {
  return SettingsController(
    repository: getIt<SettingsRepository>(),
  );
});

/// Provider para el modo oscuro
final isDarkModeProvider = Provider<bool>((ref) {
  return ref.watch(settingsControllerProvider).settings.modOscuro;
});
