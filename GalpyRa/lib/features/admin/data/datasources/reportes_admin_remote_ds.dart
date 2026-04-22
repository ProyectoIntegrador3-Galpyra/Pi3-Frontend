import 'package:dio/dio.dart';

import '../../../../config/constants/api_endpoints.dart';
import '../../../../core/network/api_response_parser.dart';
import '../../../../core/network/http_client.dart';
import '../../domain/entities/reporte_data.dart';

abstract class ReportesAdminRemoteDataSource {
  Future<List<ReporteProduccionItem>> obtenerReporteProduccion({
    required int anio,
    int? mes,
    String? galponId,
  });

  Future<List<ReporteAlimentacionItem>> obtenerReporteAlimentacion({
    required int anio,
    int? mes,
    String? galponId,
  });

  Future<List<ReporteMortalidadItem>> obtenerReporteMortalidad({
    required int anio,
    int? mes,
    String? galponId,
  });

  Future<List<ReporteInventarioItem>> obtenerReporteInventario({
    required int anio,
    int? mes,
    String? galponId,
  });
}

class ReportesAdminRemoteDataSourceImpl
    implements ReportesAdminRemoteDataSource {
  final HttpClient _httpClient;

  ReportesAdminRemoteDataSourceImpl(this._httpClient);

  Map<String, dynamic> _query(int anio, int? mes, String? galponId) {
    return {
      'anio': anio,
      if (mes != null) 'mes': mes,
      if (galponId != null && galponId.trim().isNotEmpty) 'galpon_id': galponId,
    };
  }

  @override
  Future<List<ReporteProduccionItem>> obtenerReporteProduccion({
    required int anio,
    int? mes,
    String? galponId,
  }) async {
    try {
      final response = await _httpClient.get(
        ApiEndpoints.reportesProduccion,
        queryParameters: _query(anio, mes, galponId),
      );
      final data = ApiResponseParser.extractDataList(response.data);
      return data
          .map(
              (e) => ReporteProduccionItem.fromJson(ApiResponseParser.asMap(e)))
          .toList();
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(
        e,
        fallbackMessage: 'Error al cargar reporte de produccion',
      );
    }
  }

  @override
  Future<List<ReporteAlimentacionItem>> obtenerReporteAlimentacion({
    required int anio,
    int? mes,
    String? galponId,
  }) async {
    try {
      final response = await _httpClient.get(
        ApiEndpoints.reportesAlimentacion,
        queryParameters: _query(anio, mes, galponId),
      );
      final data = ApiResponseParser.extractDataList(response.data);
      return data
          .map((e) =>
              ReporteAlimentacionItem.fromJson(ApiResponseParser.asMap(e)))
          .toList();
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(
        e,
        fallbackMessage: 'Error al cargar reporte de alimentacion',
      );
    }
  }

  @override
  Future<List<ReporteMortalidadItem>> obtenerReporteMortalidad({
    required int anio,
    int? mes,
    String? galponId,
  }) async {
    try {
      final response = await _httpClient.get(
        ApiEndpoints.reportesMortalidad,
        queryParameters: _query(anio, mes, galponId),
      );
      final data = ApiResponseParser.extractDataList(response.data);
      return data
          .map(
              (e) => ReporteMortalidadItem.fromJson(ApiResponseParser.asMap(e)))
          .toList();
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(
        e,
        fallbackMessage: 'Error al cargar reporte de mortalidad',
      );
    }
  }

  @override
  Future<List<ReporteInventarioItem>> obtenerReporteInventario({
    required int anio,
    int? mes,
    String? galponId,
  }) async {
    try {
      final response = await _httpClient.get(
        ApiEndpoints.reportesInventario,
        queryParameters: _query(anio, mes, galponId),
      );
      final data = ApiResponseParser.extractDataList(response.data);
      return data
          .map(
              (e) => ReporteInventarioItem.fromJson(ApiResponseParser.asMap(e)))
          .toList();
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(
        e,
        fallbackMessage: 'Error al cargar reporte de inventario',
      );
    }
  }
}
