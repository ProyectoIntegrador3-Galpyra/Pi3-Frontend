import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/di/injector.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_response_parser.dart';
import '../../data/datasources/reportes_admin_remote_ds.dart';
import '../../domain/entities/reporte_data.dart';

class ReportesAdminState {
  final int anio;
  final int? mes;
  final String? galponId;
  final List<ReporteProduccionItem> produccion;
  final List<ReporteAlimentacionItem> alimentacion;
  final List<ReporteMortalidadItem> mortalidad;
  final List<ReporteInventarioItem> inventario;
  final bool isLoading;
  final String? error;

  const ReportesAdminState({
    required this.anio,
    this.mes,
    this.galponId,
    this.produccion = const [],
    this.alimentacion = const [],
    this.mortalidad = const [],
    this.inventario = const [],
    this.isLoading = false,
    this.error,
  });

  factory ReportesAdminState.initial() {
    return ReportesAdminState(anio: DateTime.now().year);
  }

  ReportesAdminState copyWith({
    int? anio,
    int? mes,
    bool clearMes = false,
    String? galponId,
    bool clearGalpon = false,
    List<ReporteProduccionItem>? produccion,
    List<ReporteAlimentacionItem>? alimentacion,
    List<ReporteMortalidadItem>? mortalidad,
    List<ReporteInventarioItem>? inventario,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) {
    return ReportesAdminState(
      anio: anio ?? this.anio,
      mes: clearMes ? null : (mes ?? this.mes),
      galponId: clearGalpon ? null : (galponId ?? this.galponId),
      produccion: produccion ?? this.produccion,
      alimentacion: alimentacion ?? this.alimentacion,
      mortalidad: mortalidad ?? this.mortalidad,
      inventario: inventario ?? this.inventario,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : error,
    );
  }
}

class ReportesAdminController extends StateNotifier<ReportesAdminState> {
  final ReportesAdminRemoteDataSource _remoteDataSource;

  ReportesAdminController()
      : _remoteDataSource = getIt<ReportesAdminRemoteDataSource>(),
        super(ReportesAdminState.initial());

  void actualizarFiltros({
    required int anio,
    int? mes,
    String? galponId,
    bool limpiarGalpon = false,
  }) {
    state = state.copyWith(
      anio: anio,
      mes: mes,
      clearMes: mes == null,
      galponId: galponId,
      clearGalpon: limpiarGalpon,
      clearError: true,
    );
  }

  Future<void> cargarReportes() async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final results = await Future.wait([
        _remoteDataSource.obtenerReporteProduccion(
          anio: state.anio,
          mes: state.mes,
          galponId: state.galponId,
        ),
        _remoteDataSource.obtenerReporteAlimentacion(
          anio: state.anio,
          mes: state.mes,
          galponId: state.galponId,
        ),
        _remoteDataSource.obtenerReporteMortalidad(
          anio: state.anio,
          mes: state.mes,
          galponId: state.galponId,
        ),
        _remoteDataSource.obtenerReporteInventario(
          anio: state.anio,
          mes: state.mes,
          galponId: state.galponId,
        ),
      ]);

      state = state.copyWith(
        isLoading: false,
        produccion: results[0] as List<ReporteProduccionItem>,
        alimentacion: results[1] as List<ReporteAlimentacionItem>,
        mortalidad: results[2] as List<ReporteMortalidadItem>,
        inventario: results[3] as List<ReporteInventarioItem>,
      );
    } on ServerException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: ApiResponseParser.extractMessage(
          {'error': e.toString()},
          fallback: 'No se pudieron cargar los reportes',
        ),
      );
    }
  }
}

final reportesAdminControllerProvider =
    StateNotifierProvider<ReportesAdminController, ReportesAdminState>(
  (ref) => ReportesAdminController(),
);
