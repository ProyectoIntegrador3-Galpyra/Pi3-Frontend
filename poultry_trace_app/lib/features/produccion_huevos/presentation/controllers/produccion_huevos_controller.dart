import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/produccion_huevos.dart';
import '../../domain/usecases/registrar_produccion.dart';
import '../../domain/usecases/obtener_historial_produccion.dart';
import '../../../../config/di/injector.dart';

/// Estado para la feature de producción de huevos
class ProduccionHuevosState {
  final bool isLoading;
  final List<ProduccionHuevos> historial;
  final ProduccionHuevos? produccionHoy;
  final Map<String, dynamic>? estadisticas;
  final String? errorMessage;
  final String? selectedGalponId;

  const ProduccionHuevosState({
    this.isLoading = false,
    this.historial = const [],
    this.produccionHoy,
    this.estadisticas,
    this.errorMessage,
    this.selectedGalponId,
  });

  ProduccionHuevosState copyWith({
    bool? isLoading,
    List<ProduccionHuevos>? historial,
    ProduccionHuevos? produccionHoy,
    Map<String, dynamic>? estadisticas,
    String? errorMessage,
    String? selectedGalponId,
  }) {
    return ProduccionHuevosState(
      isLoading: isLoading ?? this.isLoading,
      historial: historial ?? this.historial,
      produccionHoy: produccionHoy ?? this.produccionHoy,
      estadisticas: estadisticas ?? this.estadisticas,
      errorMessage: errorMessage,
      selectedGalponId: selectedGalponId ?? this.selectedGalponId,
    );
  }
}

/// Controller para producción de huevos
class ProduccionHuevosController extends StateNotifier<ProduccionHuevosState> {
  final RegistrarProduccionUseCase _registrarProduccion;
  final ObtenerHistorialProduccionUseCase _obtenerHistorial;

  ProduccionHuevosController({
    required RegistrarProduccionUseCase registrarProduccion,
    required ObtenerHistorialProduccionUseCase obtenerHistorial,
  })  : _registrarProduccion = registrarProduccion,
        _obtenerHistorial = obtenerHistorial,
        super(const ProduccionHuevosState());

  /// Obtener historial de producción
  Future<void> obtenerHistorial(
    String galponId, {
    DateTime? desde,
    DateTime? hasta,
  }) async {
    state = state.copyWith(isLoading: true, selectedGalponId: galponId);

    final result = await _obtenerHistorial(galponId, desde: desde, hasta: hasta);

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      ),
      (historial) => state = state.copyWith(
        isLoading: false,
        historial: historial,
        produccionHoy: historial.isNotEmpty ? historial.first : null,
      ),
    );
  }

  /// Registrar producción
  Future<bool> registrarProduccion({
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
  }) async {
    state = state.copyWith(isLoading: true);

    final result = await _registrarProduccion(
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

    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, errorMessage: failure.message);
        return false;
      },
      (registro) {
        state = state.copyWith(
          isLoading: false,
          historial: [registro, ...state.historial],
          produccionHoy: registro,
        );
        return true;
      },
    );
  }

  /// Total de huevos en el período actual
  int get totalHuevosPeriodo =>
      state.historial.fold(0, (sum, r) => sum + r.cantidadTotal);

  /// Promedio diario
  double get promedioDiario =>
      state.historial.isNotEmpty ? totalHuevosPeriodo / state.historial.length : 0;

  /// Limpiar error
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

/// Provider del controller
final produccionHuevosControllerProvider =
    StateNotifierProvider<ProduccionHuevosController, ProduccionHuevosState>((ref) {
  return ProduccionHuevosController(
    registrarProduccion: getIt<RegistrarProduccionUseCase>(),
    obtenerHistorial: getIt<ObtenerHistorialProduccionUseCase>(),
  );
});
