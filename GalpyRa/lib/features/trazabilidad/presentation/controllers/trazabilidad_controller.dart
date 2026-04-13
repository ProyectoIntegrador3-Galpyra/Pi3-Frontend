import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/di/injector.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/failure_message_mapper.dart';
import '../../data/datasources/trazabilidad_remote_ds.dart';

class TrazabilidadLoteOption {
  final String id;
  final String nombreLote;
  final String nombreGalpon;

  const TrazabilidadLoteOption({
    required this.id,
    required this.nombreLote,
    required this.nombreGalpon,
  });

  String get label => '$nombreLote — $nombreGalpon';
}

class TrazabilidadState {
  final bool isLoading;
  final String? generatedToken;
  final Map<String, dynamic>? consultaData;
  final List<TrazabilidadLoteOption> lotes;
  final String? error;

  const TrazabilidadState({
    this.isLoading = false,
    this.generatedToken,
    this.consultaData,
    this.lotes = const [],
    this.error,
  });

  TrazabilidadState copyWith({
    bool? isLoading,
    String? generatedToken,
    Map<String, dynamic>? consultaData,
    List<TrazabilidadLoteOption>? lotes,
    String? error,
  }) {
    return TrazabilidadState(
      isLoading: isLoading ?? this.isLoading,
      generatedToken: generatedToken ?? this.generatedToken,
      consultaData: consultaData ?? this.consultaData,
      lotes: lotes ?? this.lotes,
      error: error,
    );
  }
}

class TrazabilidadController extends StateNotifier<TrazabilidadState> {
  final TrazabilidadRemoteDataSource _remoteDataSource;

  TrazabilidadController(this._remoteDataSource)
      : super(const TrazabilidadState());

  Future<void> cargarLotes() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final lotesRaw = await _remoteDataSource.listarLotes();
      final lotes = lotesRaw
          .map(
            (l) => TrazabilidadLoteOption(
              id: (l['id'] ?? '').toString(),
              nombreLote: (l['nombre_lote'] ?? 'Lote').toString(),
              nombreGalpon: (l['nombre_galpon'] ?? 'Sin galpón').toString(),
            ),
          )
          .toList();

      state = state.copyWith(isLoading: false, lotes: lotes);
    } on ServerException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: mapFailureMessage(
          ServerFailure(message: e.message, statusCode: e.statusCode),
        ),
      );
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        error: const UnknownFailure().message,
      );
    }
  }

  Future<void> generarToken(String loteId) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final token = await _remoteDataSource.generarToken(loteId: loteId);
      state = state.copyWith(
        isLoading: false,
        generatedToken: token,
      );
    } on ServerException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: mapFailureMessage(
          ServerFailure(message: e.message, statusCode: e.statusCode),
        ),
      );
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        error: const UnknownFailure().message,
      );
    }
  }

  Future<void> consultarPublica(String token) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final data = await _remoteDataSource.consultarPublica(token: token);
      state = state.copyWith(
        isLoading: false,
        consultaData: data,
      );
    } on ServerException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: mapFailureMessage(
          ServerFailure(message: e.message, statusCode: e.statusCode),
        ),
      );
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        error: const UnknownFailure().message,
      );
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

final trazabilidadControllerProvider =
    StateNotifierProvider<TrazabilidadController, TrazabilidadState>((ref) {
  return TrazabilidadController(getIt<TrazabilidadRemoteDataSource>());
});

final lotesProvider = Provider<List<TrazabilidadLoteOption>>((ref) {
  return ref.watch(trazabilidadControllerProvider).lotes;
});
