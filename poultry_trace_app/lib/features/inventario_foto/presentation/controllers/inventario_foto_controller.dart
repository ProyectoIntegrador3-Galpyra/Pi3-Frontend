import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/conteo_foto.dart';
import '../../domain/usecases/procesar_imagen_conteo.dart';
import '../../domain/usecases/confirmar_inventario.dart';
import '../../domain/repositories/inventario_foto_repository.dart';
import '../../../../config/di/injector.dart';

/// Estado para inventario por foto
class InventarioFotoState {
  final bool isLoading;
  final bool isProcesando;
  final ConteoFoto? conteoActual;
  final List<ConteoFoto> historial;
  final String? imagePath;
  final String? errorMessage;
  final String? selectedGalponId;

  const InventarioFotoState({
    this.isLoading = false,
    this.isProcesando = false,
    this.conteoActual,
    this.historial = const [],
    this.imagePath,
    this.errorMessage,
    this.selectedGalponId,
  });

  InventarioFotoState copyWith({
    bool? isLoading,
    bool? isProcesando,
    ConteoFoto? conteoActual,
    List<ConteoFoto>? historial,
    String? imagePath,
    String? errorMessage,
    String? selectedGalponId,
  }) {
    return InventarioFotoState(
      isLoading: isLoading ?? this.isLoading,
      isProcesando: isProcesando ?? this.isProcesando,
      conteoActual: conteoActual ?? this.conteoActual,
      historial: historial ?? this.historial,
      imagePath: imagePath ?? this.imagePath,
      errorMessage: errorMessage,
      selectedGalponId: selectedGalponId ?? this.selectedGalponId,
    );
  }
}

/// Controller para inventario por foto
class InventarioFotoController extends StateNotifier<InventarioFotoState> {
  final ProcesarImagenConteoUseCase _procesarImagen;
  final ConfirmarInventarioUseCase _confirmarInventario;
  final InventarioFotoRepository _repository;

  InventarioFotoController({
    required ProcesarImagenConteoUseCase procesarImagen,
    required ConfirmarInventarioUseCase confirmarInventario,
    required InventarioFotoRepository repository,
  })  : _procesarImagen = procesarImagen,
        _confirmarInventario = confirmarInventario,
        _repository = repository,
        super(const InventarioFotoState());

  /// Establecer imagen capturada
  void setImagePath(String path) {
    state = state.copyWith(imagePath: path);
  }

  /// Establecer galpón seleccionado
  void setGalponId(String galponId) {
    state = state.copyWith(selectedGalponId: galponId);
  }

  /// Procesar imagen para conteo automático
  Future<bool> procesarImagen() async {
    if (state.imagePath == null || state.selectedGalponId == null) {
      state = state.copyWith(errorMessage: 'Seleccione una imagen y galpón');
      return false;
    }

    state = state.copyWith(isProcesando: true);

    final result = await _procesarImagen(
      galponId: state.selectedGalponId!,
      imagePath: state.imagePath!,
    );

    return result.fold(
      (failure) {
        state = state.copyWith(
          isProcesando: false,
          errorMessage: failure.message,
        );
        return false;
      },
      (conteo) {
        state = state.copyWith(
          isProcesando: false,
          conteoActual: conteo,
        );
        return true;
      },
    );
  }

  /// Actualizar conteo manual
  Future<bool> actualizarConteoManual(int conteoManual) async {
    if (state.conteoActual == null) return false;

    state = state.copyWith(isLoading: true);

    final result = await _repository.actualizarConteo(
      conteoId: state.conteoActual!.id,
      conteoManual: conteoManual,
    );

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        );
        return false;
      },
      (conteo) {
        state = state.copyWith(
          isLoading: false,
          conteoActual: conteo,
        );
        return true;
      },
    );
  }

  /// Confirmar y guardar inventario
  Future<bool> confirmarInventario(int cantidadFinal) async {
    if (state.conteoActual == null || state.selectedGalponId == null) {
      return false;
    }

    state = state.copyWith(isLoading: true);

    final result = await _confirmarInventario(
      galponId: state.selectedGalponId!,
      conteoId: state.conteoActual!.id,
      cantidadFinal: cantidadFinal,
    );

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        );
        return false;
      },
      (_) {
        // Actualizar conteo actual con cantidad final
        final conteoFinalizado = state.conteoActual!.copyWith(
          conteoFinal: cantidadFinal,
        );
        state = state.copyWith(
          isLoading: false,
          conteoActual: conteoFinalizado,
          historial: [conteoFinalizado, ...state.historial],
        );
        return true;
      },
    );
  }

  /// Obtener historial de conteos
  Future<void> obtenerHistorial(String galponId) async {
    state = state.copyWith(isLoading: true, selectedGalponId: galponId);

    final result = await _repository.obtenerHistorial(galponId);

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      ),
      (historial) => state = state.copyWith(
        isLoading: false,
        historial: historial,
      ),
    );
  }

  /// Reiniciar proceso de conteo
  void reiniciarConteo() {
    state = state.copyWith(
      conteoActual: null,
      imagePath: null,
    );
  }

  /// Limpiar error
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

/// Provider del controller
final inventarioFotoControllerProvider =
    StateNotifierProvider<InventarioFotoController, InventarioFotoState>((ref) {
  return InventarioFotoController(
    procesarImagen: getIt<ProcesarImagenConteoUseCase>(),
    confirmarInventario: getIt<ConfirmarInventarioUseCase>(),
    repository: getIt<InventarioFotoRepository>(),
  );
});
