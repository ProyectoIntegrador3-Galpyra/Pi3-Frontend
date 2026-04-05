import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/di/injector.dart';
import '../../../../core/errors/failure_message_mapper.dart';
import '../../domain/entities/galpon.dart';
import '../../domain/usecases/listar_galpones.dart';
import '../../domain/usecases/crear_galpon.dart';
import '../../domain/usecases/editar_galpon.dart';
import '../../domain/usecases/ver_detalle_galpon.dart';

/// Galpones state
class GalponesState {
  final bool isLoading;
  final List<Galpon> galpones;
  final Galpon? selectedGalpon;
  final String? error;

  const GalponesState({
    this.isLoading = false,
    this.galpones = const [],
    this.selectedGalpon,
    this.error,
  });

  GalponesState copyWith({
    bool? isLoading,
    List<Galpon>? galpones,
    Galpon? selectedGalpon,
    String? error,
  }) {
    return GalponesState(
      isLoading: isLoading ?? this.isLoading,
      galpones: galpones ?? this.galpones,
      selectedGalpon: selectedGalpon ?? this.selectedGalpon,
      error: error,
    );
  }
}

/// Galpones controller notifier
class GalponesController extends StateNotifier<GalponesState> {
  final ListarGalponesUseCase _listarGalpones;
  final CrearGalponUseCase _crearGalpon;
  final EditarGalponUseCase _editarGalpon;
  final VerDetalleGalponUseCase _verDetalleGalpon;

  GalponesController({
    required ListarGalponesUseCase listarGalpones,
    required CrearGalponUseCase crearGalpon,
    required EditarGalponUseCase editarGalpon,
    required VerDetalleGalponUseCase verDetalleGalpon,
  })  : _listarGalpones = listarGalpones,
        _crearGalpon = crearGalpon,
        _editarGalpon = editarGalpon,
        _verDetalleGalpon = verDetalleGalpon,
        super(const GalponesState());

  /// Cargar lista de galpones
  Future<void> cargarGalpones() async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _listarGalpones();

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: mapFailureMessage(failure),
        );
      },
      (galpones) {
        state = state.copyWith(
          isLoading: false,
          galpones: galpones,
        );
      },
    );
  }

  /// Obtener detalle de galpon
  Future<void> obtenerGalpon(String id) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _verDetalleGalpon(id);

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: mapFailureMessage(failure),
        );
      },
      (galpon) {
        state = state.copyWith(
          isLoading: false,
          selectedGalpon: galpon,
        );
      },
    );
  }

  /// Crear nuevo galpon
  Future<bool> crearGalpon(Galpon galpon) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _crearGalpon(galpon);

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: mapFailureMessage(failure),
        );
        return false;
      },
      (nuevoGalpon) {
        state = state.copyWith(
          isLoading: false,
          galpones: [...state.galpones, nuevoGalpon],
        );
        return true;
      },
    );
  }

  /// Editar galpon existente
  Future<bool> editarGalpon(Galpon galpon) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _editarGalpon(galpon);

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: mapFailureMessage(failure),
        );
        return false;
      },
      (galponEditado) {
        final updatedList = state.galpones
            .map((g) => g.id == galponEditado.id ? galponEditado : g)
            .toList();
        state = state.copyWith(
          isLoading: false,
          galpones: updatedList,
          selectedGalpon: galponEditado,
        );
        return true;
      },
    );
  }

  /// Clear selected galpon
  void clearSelectedGalpon() {
    state = state.copyWith(selectedGalpon: null);
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }
}

/// Galpones controller provider
final galponesControllerProvider =
    StateNotifierProvider<GalponesController, GalponesState>((ref) {
  return GalponesController(
    listarGalpones: getIt<ListarGalponesUseCase>(),
    crearGalpon: getIt<CrearGalponUseCase>(),
    editarGalpon: getIt<EditarGalponUseCase>(),
    verDetalleGalpon: getIt<VerDetalleGalponUseCase>(),
  );
});
