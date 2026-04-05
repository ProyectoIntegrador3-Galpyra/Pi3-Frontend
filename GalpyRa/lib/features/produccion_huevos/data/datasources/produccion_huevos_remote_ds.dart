import 'package:dio/dio.dart';

import '../../../../config/constants/api_endpoints.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_response_parser.dart';
import '../../../../core/network/http_client.dart';
import '../models/produccion_huevos_model.dart';

/// Remote data source para producción de huevos
abstract class ProduccionHuevosRemoteDataSource {
  Future<List<ProduccionHuevosModel>> obtenerHistorial(
    String galponId, {
    DateTime? desde,
    DateTime? hasta,
  });

  Future<ProduccionHuevosModel> registrarProduccion({
    required String galponId,
    required DateTime fecha,
    required int cantidadTotal,
    int huevosRotos = 0,
    int huevosSucios = 0,
    int huevosGrandeAA = 0,
    int huevosGrandeA = 0,
    int huevosMediano = 0,
    int huevosPequeno = 0,
    String? observaciones,
  });

  Future<Map<String, dynamic>> obtenerEstadisticas(
    String galponId, {
    required DateTime desde,
    required DateTime hasta,
  });

  Future<ProduccionHuevosModel?> obtenerProduccionHoy(String galponId);
}

/// Implementación del data source remoto
class ProduccionHuevosRemoteDataSourceImpl implements ProduccionHuevosRemoteDataSource {
  final HttpClient _httpClient;

  ProduccionHuevosRemoteDataSourceImpl(this._httpClient);

  @override
  Future<List<ProduccionHuevosModel>> obtenerHistorial(
    String galponId, {
    DateTime? desde,
    DateTime? hasta,
  }) async {
    try {
      final response = await _httpClient.get(
        ApiEndpoints.produccionByGalpon(galponId),
        queryParameters: {
          if (desde != null) 'fecha_inicio': desde.toIso8601String(),
          if (hasta != null) 'fecha_fin': hasta.toIso8601String(),
        },
      );

      final list = ApiResponseParser.extractDataList(response.data);
      if (list.isNotEmpty) {
        return list
            .map((item) => ProduccionHuevosModel.fromJson(ApiResponseParser.asMap(item)))
            .toList();
      }

      return <ProduccionHuevosModel>[];
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(e, fallbackMessage: 'Error al obtener historial de produccion');
    }
  }

  @override
  Future<ProduccionHuevosModel> registrarProduccion({
    required String galponId,
    required DateTime fecha,
    required int cantidadTotal,
    int huevosRotos = 0,
    int huevosSucios = 0,
    int huevosGrandeAA = 0,
    int huevosGrandeA = 0,
    int huevosMediano = 0,
    int huevosPequeno = 0,
    String? observaciones,
  }) async {
    try {
      final response = await _httpClient.post(
        ApiEndpoints.produccion,
        data: {
          'galpon_id': galponId,
          'fecha': fecha.toIso8601String(),
          'cantidad_total': cantidadTotal,
          'huevos_rotos': huevosRotos,
          'huevos_sucios': huevosSucios,
          'huevos_grande_aa': huevosGrandeAA,
          'huevos_grande_a': huevosGrandeA,
          'huevos_mediano': huevosMediano,
          'huevos_pequeno': huevosPequeno,
          if (observaciones != null && observaciones.isNotEmpty) 'observaciones': observaciones,
        },
      );

      final data = ApiResponseParser.extractDataMap(response.data);
      return ProduccionHuevosModel.fromJson(data);
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(e, fallbackMessage: 'Error al registrar produccion');
    }
  }

  @override
  Future<Map<String, dynamic>> obtenerEstadisticas(
    String galponId, {
    required DateTime desde,
    required DateTime hasta,
  }) async {
    try {
      final response = await _httpClient.get(
        ApiEndpoints.produccionRango,
        queryParameters: {
          'galpon_id': galponId,
          'fecha_inicio': desde.toIso8601String(),
          'fecha_fin': hasta.toIso8601String(),
        },
      );
      return ApiResponseParser.extractDataMap(response.data);
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(e, fallbackMessage: 'Error al obtener estadisticas de produccion');
    }
  }

  @override
  Future<ProduccionHuevosModel?> obtenerProduccionHoy(String galponId) async {
    try {
      final fechaHoy = DateTime.now().toIso8601String().split('T').first;
      final response = await _httpClient.get(
        ApiEndpoints.produccionByGalpon(galponId),
        queryParameters: {
          'fecha': fechaHoy,
          'limit': 1,
        },
      );

      final list = ApiResponseParser.extractDataList(response.data);
      if (list.isNotEmpty) {
        return ProduccionHuevosModel.fromJson(ApiResponseParser.asMap(list.first));
      }

      final data = ApiResponseParser.extractDataMap(response.data);
      if (data.isEmpty) {
        return null;
      }
      return ProduccionHuevosModel.fromJson(data);
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(e, fallbackMessage: 'Error al obtener la produccion de hoy');
    }
  }
}
