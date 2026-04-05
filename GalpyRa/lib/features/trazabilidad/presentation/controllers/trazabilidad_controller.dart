import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/di/injector.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/failure_message_mapper.dart';
import '../../data/datasources/trazabilidad_remote_ds.dart';

class TrazabilidadState {
  final bool isLoading;
  final String? generatedToken;
  final Map<String, dynamic>? consultaData;
  final String? error;

  const TrazabilidadState({
    this.isLoading = false,
    this.generatedToken,
    this.consultaData,
    this.error,
  });

  TrazabilidadState copyWith({
    bool? isLoading,
    String? generatedToken,
    Map<String, dynamic>? consultaData,
    String? error,
  }) {
    return TrazabilidadState(
      isLoading: isLoading ?? this.isLoading,
      generatedToken: generatedToken ?? this.generatedToken,
      consultaData: consultaData ?? this.consultaData,
      error: error,
    );
  }
}

class TrazabilidadController extends StateNotifier<TrazabilidadState> {
  final TrazabilidadRemoteDataSource _remoteDataSource;

  TrazabilidadController(this._remoteDataSource)
      : super(const TrazabilidadState());

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
