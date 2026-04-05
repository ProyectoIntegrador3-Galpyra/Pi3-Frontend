import 'package:dio/dio.dart';

import '../../../../config/constants/api_endpoints.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_response_parser.dart';
import '../../../../core/network/http_client.dart';
import '../../domain/entities/reporte.dart';
import '../models/reporte_model.dart';

/// Data source remoto para reportes
abstract class ReportesRemoteDataSource {
  Future<ReporteModel> generarReporte(ParametrosReporteModel parametros);
  Future<List<ReporteModel>> obtenerHistorialReportes({
    TipoReporte? tipo,
    int limit = 20,
  });
  Future<ReporteModel> obtenerReportePorId(String id);
  Future<String> exportarReporte(String reporteId, FormatoExportacion formato);
  Future<void> eliminarReporte(String id);
  Future<Map<String, dynamic>> obtenerDatosDashboard(
    DateTime fechaInicio,
    DateTime fechaFin,
  );
}

class ReportesRemoteDataSourceImpl implements ReportesRemoteDataSource {
  final HttpClient _httpClient;

  ReportesRemoteDataSourceImpl(this._httpClient);

  @override
  Future<ReporteModel> generarReporte(ParametrosReporteModel parametros) async {
    try {
      final response = await _httpClient.post(
        ApiEndpoints.generarReporte,
        data: parametros.toJson(),
      );
      final data = ApiResponseParser.extractDataMap(response.data);
      return ReporteModel.fromBackend(data);
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(e, fallbackMessage: 'Error al generar reporte');
    }
  }

  @override
  Future<List<ReporteModel>> obtenerHistorialReportes({
    TipoReporte? tipo,
    int limit = 20,
  }) async {
    try {
      final response = await _httpClient.get(
        ApiEndpoints.reportes,
        queryParameters: {
          if (tipo != null) 'tipo': tipo.name,
          'limit': limit,
        },
      );
      final items = ApiResponseParser.extractDataList(response.data);
      return items.map((item) => ReporteModel.fromBackend(ApiResponseParser.asMap(item))).toList();
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(e, fallbackMessage: 'Error al obtener reportes');
    }
  }

  @override
  Future<ReporteModel> obtenerReportePorId(String id) async {
    try {
      final response = await _httpClient.get(ApiEndpoints.reporteById(id));
      final data = ApiResponseParser.extractDataMap(response.data);
      return ReporteModel.fromBackend(data);
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(e, fallbackMessage: 'Error al obtener el reporte');
    }
  }

  @override
  Future<String> exportarReporte(
    String reporteId,
    FormatoExportacion formato,
  ) async {
    try {
      final response = await _httpClient.post(
        ApiEndpoints.generarReporte,
        data: {
          'reporte_id': reporteId,
          'formato': formato.name,
        },
      );
      final data = ApiResponseParser.extractDataMap(response.data);
      final url = data['url_reporte']?.toString();
      if (url == null || url.isEmpty) {
        throw const ServerException(message: 'No se recibio url_reporte');
      }
      return url;
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(e, fallbackMessage: 'Error al exportar reporte');
    }
  }

  @override
  Future<void> eliminarReporte(String id) async {
    try {
      await _httpClient.delete(ApiEndpoints.reporteById(id));
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(e, fallbackMessage: 'Error al eliminar reporte');
    }
  }

  @override
  Future<Map<String, dynamic>> obtenerDatosDashboard(
    DateTime fechaInicio,
    DateTime fechaFin,
  ) async {
    try {
      final response = await _httpClient.get(
        ApiEndpoints.dashboard,
        queryParameters: {
          'fecha_inicio': fechaInicio.toIso8601String(),
          'fecha_fin': fechaFin.toIso8601String(),
        },
      );

      final data = ApiResponseParser.extractDataMap(response.data);
      return {
        'total_aves_activas': data['total_aves_activas'] ?? 0,
        'produccion_ultimos_7_dias': data['produccion_ultimos_7_dias'] ?? 0,
        'tasa_mortalidad_porcentaje': data['tasa_mortalidad_porcentaje'] ?? 0,
        'alertas': data['alertas'] is List ? data['alertas'] : <dynamic>[],
      };
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(e, fallbackMessage: 'Error al obtener dashboard');
    }
  }
}
