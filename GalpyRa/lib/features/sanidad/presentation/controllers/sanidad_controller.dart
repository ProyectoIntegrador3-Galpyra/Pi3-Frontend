import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/errors/failure_message_mapper.dart';
import '../../domain/entities/registro_sanitario.dart';
import '../../domain/usecases/registrar_evento_sanitario.dart';
import '../../domain/usecases/obtener_historial_sanitario.dart';
import '../../../../config/di/injector.dart';

/// Estado para sanidad
class SanidadState {
  final bool isLoading;
  final List<RegistroSanitario> historial;
  final List<RegistroSanitario> pendientes;
  final String? errorMessage;
  final String? selectedGalponId;
  final TipoEventoSanitario? filtroTipo;

  const SanidadState({
    this.isLoading = false,
    this.historial = const [],
    this.pendientes = const [],
    this.errorMessage,
    this.selectedGalponId,
    this.filtroTipo,
  });

  SanidadState copyWith({
    bool? isLoading,
    List<RegistroSanitario>? historial,
    List<RegistroSanitario>? pendientes,
    String? errorMessage,
    String? selectedGalponId,
    TipoEventoSanitario? filtroTipo,
  }) {
    return SanidadState(
      isLoading: isLoading ?? this.isLoading,
      historial: historial ?? this.historial,
      pendientes: pendientes ?? this.pendientes,
      errorMessage: errorMessage,
      selectedGalponId: selectedGalponId ?? this.selectedGalponId,
      filtroTipo: filtroTipo ?? this.filtroTipo,
    );
  }
}

/// Controller para sanidad
class SanidadController extends StateNotifier<SanidadState> {
  final RegistrarEventoSanitarioUseCase _registrarEvento;
  final ObtenerHistorialSanitarioUseCase _obtenerHistorial;

  SanidadController({
    required RegistrarEventoSanitarioUseCase registrarEvento,
    required ObtenerHistorialSanitarioUseCase obtenerHistorial,
  })  : _registrarEvento = registrarEvento,
        _obtenerHistorial = obtenerHistorial,
        super(const SanidadState());

  /// Obtener historial sanitario
  Future<void> obtenerHistorial(
    String galponId, {
    TipoEventoSanitario? tipo,
  }) async {
    state = state.copyWith(
      isLoading: true,
      selectedGalponId: galponId,
      filtroTipo: tipo,
    );

    final result = await _obtenerHistorial(galponId, tipo: tipo);

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

  /// Registrar evento sanitario
  Future<bool> registrarEvento({
    required String galponId,
    required TipoEventoSanitario tipo,
    required DateTime fecha,
    required String descripcion,
    String? medicamento,
    String? dosis,
    String? veterinario,
    int? avesAfectadas,
    DateTime? fechaProximaAplicacion,
    String? observaciones,
  }) async {
    state = state.copyWith(isLoading: true);

    final result = await _registrarEvento(
      galponId: galponId,
      tipo: tipo,
      fecha: fecha,
      descripcion: descripcion,
      medicamento: medicamento,
      dosis: dosis,
      veterinario: veterinario,
      avesAfectadas: avesAfectadas,
      fechaProximaAplicacion: fechaProximaAplicacion,
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

  /// Filtrar por tipo
  void filtrarPorTipo(TipoEventoSanitario? tipo) {
    if (state.selectedGalponId != null) {
      obtenerHistorial(state.selectedGalponId!, tipo: tipo);
    }
  }

  /// Limpiar filtro
  void limpiarFiltro() {
    if (state.selectedGalponId != null) {
      obtenerHistorial(state.selectedGalponId!);
    }
  }

  /// Limpiar error
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

/// Provider del controller
final sanidadControllerProvider =
    StateNotifierProvider<SanidadController, SanidadState>((ref) {
  return SanidadController(
    registrarEvento: getIt<RegistrarEventoSanitarioUseCase>(),
    obtenerHistorial: getIt<ObtenerHistorialSanitarioUseCase>(),
  );
});
