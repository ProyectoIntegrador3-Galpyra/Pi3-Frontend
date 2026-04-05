import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/di/injector.dart';
import '../../../../core/errors/failure_message_mapper.dart';
import '../../domain/entities/reporte.dart';
import '../../domain/usecases/generar_reporte.dart';
import '../../domain/usecases/exportar_reporte.dart';
import '../../domain/usecases/obtener_datos_dashboard.dart';
import '../../domain/repositories/reportes_repository.dart';

/// Estado del controlador de reportes
class ReportesState {
  final bool isLoading;
  final bool isGenerando;
  final List<Reporte> reportes;
  final Reporte? reporteActual;
  final Map<String, dynamic>? datosDashboard;
  final String? errorMessage;

  const ReportesState({
    this.isLoading = false,
    this.isGenerando = false,
    this.reportes = const [],
    this.reporteActual,
    this.datosDashboard,
    this.errorMessage,
  });

  ReportesState copyWith({
    bool? isLoading,
    bool? isGenerando,
    List<Reporte>? reportes,
    Reporte? reporteActual,
    Map<String, dynamic>? datosDashboard,
    String? errorMessage,
    bool clearReporteActual = false,
    bool clearError = false,
  }) {
    return ReportesState(
      isLoading: isLoading ?? this.isLoading,
      isGenerando: isGenerando ?? this.isGenerando,
      reportes: reportes ?? this.reportes,
      reporteActual: clearReporteActual ? null : (reporteActual ?? this.reporteActual),
      datosDashboard: datosDashboard ?? this.datosDashboard,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

/// Controlador de reportes
class ReportesController extends StateNotifier<ReportesState> {
  final GenerarReporte _generarReporte;
  final ExportarReporte _exportarReporte;
  final ObtenerDatosDashboard _obtenerDatosDashboard;
  final ReportesRepository _repository;

  ReportesController({
    required GenerarReporte generarReporte,
    required ExportarReporte exportarReporte,
    required ObtenerDatosDashboard obtenerDatosDashboard,
    required ReportesRepository repository,
  })  : _generarReporte = generarReporte,
        _exportarReporte = exportarReporte,
        _obtenerDatosDashboard = obtenerDatosDashboard,
        _repository = repository,
        super(const ReportesState());

  /// Carga historial de reportes
  Future<void> cargarHistorial({TipoReporte? tipo}) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _repository.obtenerHistorialReportes(tipo: tipo);

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: mapFailureMessage(failure),
      ),
      (reportes) => state = state.copyWith(
        isLoading: false,
        reportes: reportes,
      ),
    );
  }

  /// Genera un nuevo reporte
  Future<Reporte?> generarReporte(ParametrosReporte parametros) async {
    state = state.copyWith(isGenerando: true, clearError: true);

    final result = await _generarReporte(parametros);

    return result.fold(
      (failure) {
        state = state.copyWith(
          isGenerando: false,
          errorMessage: mapFailureMessage(failure),
        );
        return null;
      },
      (reporte) {
        state = state.copyWith(
          isGenerando: false,
          reporteActual: reporte,
          reportes: [reporte, ...state.reportes],
        );
        return reporte;
      },
    );
  }

  /// Exporta un reporte
  Future<String?> exportarReporte(
    String reporteId,
    FormatoExportacion formato,
  ) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _exportarReporte(reporteId, formato);

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: mapFailureMessage(failure),
        );
        return null;
      },
      (url) {
        state = state.copyWith(isLoading: false);
        return url;
      },
    );
  }

  /// Carga datos del dashboard
  Future<void> cargarDatosDashboard({
    DateTime? fechaInicio,
    DateTime? fechaFin,
  }) async {
    final inicio = fechaInicio ?? DateTime.now().subtract(const Duration(days: 30));
    final fin = fechaFin ?? DateTime.now();

    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _obtenerDatosDashboard(inicio, fin);

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: mapFailureMessage(failure),
      ),
      (datos) => state = state.copyWith(
        isLoading: false,
        datosDashboard: datos,
      ),
    );
  }

  /// Selecciona un reporte
  Future<void> seleccionarReporte(String id) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _repository.obtenerReportePorId(id);

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: mapFailureMessage(failure),
      ),
      (reporte) => state = state.copyWith(
        isLoading: false,
        reporteActual: reporte,
      ),
    );
  }

  /// Elimina un reporte
  Future<bool> eliminarReporte(String id) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _repository.eliminarReporte(id);

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: mapFailureMessage(failure),
        );
        return false;
      },
      (_) {
        state = state.copyWith(
          isLoading: false,
          reportes: state.reportes.where((r) => r.id != id).toList(),
          clearReporteActual: state.reporteActual?.id == id,
        );
        return true;
      },
    );
  }

  /// Limpia errores
  void clearError() {
    state = state.copyWith(clearError: true);
  }
}

/// Provider del controlador de reportes
final reportesControllerProvider =
    StateNotifierProvider<ReportesController, ReportesState>((ref) {
  return ReportesController(
    generarReporte: getIt<GenerarReporte>(),
    exportarReporte: getIt<ExportarReporte>(),
    obtenerDatosDashboard: getIt<ObtenerDatosDashboard>(),
    repository: getIt<ReportesRepository>(),
  );
});
