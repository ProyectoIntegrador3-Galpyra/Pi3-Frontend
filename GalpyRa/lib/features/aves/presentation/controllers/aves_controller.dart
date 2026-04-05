import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/errors/failure_message_mapper.dart';
import '../../domain/entities/lote_aves.dart';
import '../../domain/usecases/consultar_inventario.dart';
import '../../domain/usecases/registrar_ingreso.dart';
import '../../domain/usecases/registrar_mortalidad.dart';
import '../../../../config/di/injector.dart';

/// Estado para la feature de aves
class AvesState {
  final bool isLoading;
  final List<LoteAves> lotes;
  final String? errorMessage;
  final String? selectedGalponId;

  const AvesState({
    this.isLoading = false,
    this.lotes = const [],
    this.errorMessage,
    this.selectedGalponId,
  });

  AvesState copyWith({
    bool? isLoading,
    List<LoteAves>? lotes,
    String? errorMessage,
    String? selectedGalponId,
  }) {
    return AvesState(
      isLoading: isLoading ?? this.isLoading,
      lotes: lotes ?? this.lotes,
      errorMessage: errorMessage,
      selectedGalponId: selectedGalponId ?? this.selectedGalponId,
    );
  }
}

/// Notifier para manejar el estado de aves
class AvesController extends StateNotifier<AvesState> {
  final ConsultarInventarioUseCase _consultarInventario;
  final RegistrarMortalidadUseCase _registrarMortalidad;
  final RegistrarIngresoUseCase _registrarIngreso;

  AvesController({
    required ConsultarInventarioUseCase consultarInventario,
    required RegistrarMortalidadUseCase registrarMortalidad,
    required RegistrarIngresoUseCase registrarIngreso,
  })  : _consultarInventario = consultarInventario,
        _registrarMortalidad = registrarMortalidad,
        _registrarIngreso = registrarIngreso,
        super(const AvesState());

  /// Consultar inventario de aves por galpón
  Future<void> consultarInventario(String galponId) async {
    state = state.copyWith(isLoading: true, selectedGalponId: galponId);

    final result = await _consultarInventario(galponId);

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: mapFailureMessage(failure),
      ),
      (lotes) => state = state.copyWith(
        isLoading: false,
        lotes: lotes,
      ),
    );
  }

  /// Registrar mortalidad
  Future<bool> registrarMortalidad({
    required String galponId,
    required int cantidad,
    required String causa,
    required DateTime fecha,
    String? observaciones,
  }) async {
    state = state.copyWith(isLoading: true);

    final result = await _registrarMortalidad(
      galponId: galponId,
      cantidad: cantidad,
      causa: causa,
      fecha: fecha,
      observaciones: observaciones,
    );

    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, errorMessage: mapFailureMessage(failure));
        return false;
      },
      (_) {
        state = state.copyWith(isLoading: false);
        // Refresh inventory after registering mortality
        consultarInventario(galponId);
        return true;
      },
    );
  }

  /// Registrar ingreso de aves
  Future<bool> registrarIngreso({
    required String galponId,
    required String raza,
    required int cantidad,
    required DateTime fechaIngreso,
    int edadSemanas = 0,
    double? pesoPromedio,
    String? observaciones,
  }) async {
    state = state.copyWith(isLoading: true);

    final result = await _registrarIngreso(
      galponId: galponId,
      raza: raza,
      cantidad: cantidad,
      fechaIngreso: fechaIngreso,
      edadSemanas: edadSemanas,
      pesoPromedio: pesoPromedio,
      observaciones: observaciones,
    );

    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, errorMessage: mapFailureMessage(failure));
        return false;
      },
      (lote) {
        state = state.copyWith(
          isLoading: false,
          lotes: [...state.lotes, lote],
        );
        return true;
      },
    );
  }

  /// Total de aves en el inventario actual
  int get totalAves => state.lotes.fold(0, (sum, lote) => sum + lote.cantidad);

  /// Limpiar error
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

/// Provider para el controlador de aves
final avesControllerProvider = StateNotifierProvider<AvesController, AvesState>((ref) {
  return AvesController(
    consultarInventario: getIt<ConsultarInventarioUseCase>(),
    registrarMortalidad: getIt<RegistrarMortalidadUseCase>(),
    registrarIngreso: getIt<RegistrarIngresoUseCase>(),
  );
});
