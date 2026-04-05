import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/errors/failure_message_mapper.dart';
import '../../domain/entities/registro_alimentacion.dart';
import '../../domain/usecases/registrar_alimentacion.dart';
import '../../domain/usecases/obtener_historial_alimentacion.dart';
import '../../../../config/di/injector.dart';

/// Estado para alimentación
class AlimentacionState {
  final bool isLoading;
  final List<RegistroAlimentacion> historial;
  final String? errorMessage;
  final String? selectedGalponId;

  const AlimentacionState({
    this.isLoading = false,
    this.historial = const [],
    this.errorMessage,
    this.selectedGalponId,
  });

  AlimentacionState copyWith({
    bool? isLoading,
    List<RegistroAlimentacion>? historial,
    String? errorMessage,
    String? selectedGalponId,
  }) {
    return AlimentacionState(
      isLoading: isLoading ?? this.isLoading,
      historial: historial ?? this.historial,
      errorMessage: errorMessage,
      selectedGalponId: selectedGalponId ?? this.selectedGalponId,
    );
  }
}

/// Controller para alimentación
class AlimentacionController extends StateNotifier<AlimentacionState> {
  final RegistrarAlimentacionUseCase _registrarAlimentacion;
  final ObtenerHistorialAlimentacionUseCase _obtenerHistorial;

  AlimentacionController({
    required RegistrarAlimentacionUseCase registrarAlimentacion,
    required ObtenerHistorialAlimentacionUseCase obtenerHistorial,
  })  : _registrarAlimentacion = registrarAlimentacion,
        _obtenerHistorial = obtenerHistorial,
        super(const AlimentacionState());

  /// Obtener historial de alimentación
  Future<void> obtenerHistorial(String galponId) async {
    state = state.copyWith(isLoading: true, selectedGalponId: galponId);

    final result = await _obtenerHistorial(galponId);

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: mapFailureMessage(failure),
      ),
      (historial) => state = state.copyWith(
        isLoading: false,
        historial: historial,
      ),
    );
  }

  /// Registrar alimentación
  Future<bool> registrarAlimentacion({
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
  }) async {
    state = state.copyWith(isLoading: true);

    final result = await _registrarAlimentacion(
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

    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, errorMessage: mapFailureMessage(failure));
        return false;
      },
      (registro) {
        state = state.copyWith(
          isLoading: false,
          historial: [registro, ...state.historial],
        );
        return true;
      },
    );
  }

  /// Total de kg consumidos en el período
  double get totalKgConsumidos =>
      state.historial.fold(0, (sum, r) => sum + r.cantidadKg);

  /// Costo total
  double get costoTotal => state.historial.fold(
        0,
        (sum, r) => sum + (r.costoTotal ?? 0),
      );

  /// Promedio diario
  double get promedioDiario =>
      state.historial.isNotEmpty ? totalKgConsumidos / state.historial.length : 0;

  /// Limpiar error
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

/// Provider del controller
final alimentacionControllerProvider =
    StateNotifierProvider<AlimentacionController, AlimentacionState>((ref) {
  return AlimentacionController(
    registrarAlimentacion: getIt<RegistrarAlimentacionUseCase>(),
    obtenerHistorial: getIt<ObtenerHistorialAlimentacionUseCase>(),
  );
});
