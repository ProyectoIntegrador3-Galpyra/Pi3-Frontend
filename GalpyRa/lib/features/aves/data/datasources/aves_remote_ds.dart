import 'package:dio/dio.dart';

import '../../../../config/constants/api_endpoints.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_response_parser.dart';
import '../../../../core/network/http_client.dart';
import '../models/lote_aves_model.dart';

/// Remote data source para aves
abstract class AvesRemoteDataSource {
  Future<List<LoteAvesModel>> consultarInventario(String galponId);
  Future<void> registrarMortalidad({
    required String galponId,
    required int cantidad,
    required String causa,
    required DateTime fecha,
    String? observaciones,
  });
  Future<LoteAvesModel> registrarIngreso({
    required String galponId,
    required String raza,
    required int cantidad,
    required DateTime fechaIngreso,
    int? edadSemanas,
    double? pesoPromedio,
    String? observaciones,
  });
}

/// Implementación del data source remoto
class AvesRemoteDataSourceImpl implements AvesRemoteDataSource {
  final HttpClient _httpClient;

  AvesRemoteDataSourceImpl(this._httpClient);

  @override
  Future<List<LoteAvesModel>> consultarInventario(String galponId) async {
    try {
      final response = await _httpClient.get(
        ApiEndpoints.inventarioAves,
        queryParameters: {'galpon_id': galponId},
      );

      final list = ApiResponseParser.extractDataList(response.data);
      if (list.isNotEmpty) {
        return list
            .map((item) => LoteAvesModel.fromJson(ApiResponseParser.asMap(item)))
            .toList();
      }

      final data = ApiResponseParser.extractDataMap(response.data);
      final fallbackList = data['items'] ?? data['lotes'] ?? data['inventario'];
      if (fallbackList is List) {
        return fallbackList
            .map((item) => LoteAvesModel.fromJson(ApiResponseParser.asMap(item)))
            .toList();
      }

      return <LoteAvesModel>[];
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(e, fallbackMessage: 'Error al consultar inventario');
    }
  }

  @override
  Future<void> registrarMortalidad({
    required String galponId,
    required int cantidad,
    required String causa,
    required DateTime fecha,
    String? observaciones,
  }) async {
    try {
      await _httpClient.post(
        ApiEndpoints.mortalidad,
        data: {
          'galpon_id': galponId,
          'cantidad': cantidad,
          'causa': causa,
          'fecha': fecha.toIso8601String(),
          if (observaciones != null && observaciones.isNotEmpty) 'observaciones': observaciones,
        },
      );
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(e, fallbackMessage: 'Error al registrar mortalidad');
    }
  }

  @override
  Future<LoteAvesModel> registrarIngreso({
    required String galponId,
    required String raza,
    required int cantidad,
    required DateTime fechaIngreso,
    int? edadSemanas,
    double? pesoPromedio,
    String? observaciones,
  }) async {
    try {
      final response = await _httpClient.post(
        ApiEndpoints.ingresoAves,
        data: {
          'galpon_id': galponId,
          'raza': raza,
          'cantidad': cantidad,
          'fecha_ingreso': fechaIngreso.toIso8601String(),
          if (edadSemanas != null) 'edad_semanas': edadSemanas,
          if (pesoPromedio != null) 'peso_promedio': pesoPromedio,
          if (observaciones != null && observaciones.isNotEmpty) 'observaciones': observaciones,
        },
      );

      final data = ApiResponseParser.extractDataMap(response.data);
      return LoteAvesModel.fromJson(data);
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(e, fallbackMessage: 'Error al registrar ingreso');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: 'Error al registrar ingreso', originalException: e);
    }
  }
}
