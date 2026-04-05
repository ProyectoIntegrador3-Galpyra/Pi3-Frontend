import 'package:dio/dio.dart';

import '../../../../config/constants/api_endpoints.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_response_parser.dart';
import '../../../../core/network/http_client.dart';

abstract class TrazabilidadRemoteDataSource {
  Future<String> generarToken({required String loteId});
  Future<Map<String, dynamic>> consultarPublica({required String token});
}

class TrazabilidadRemoteDataSourceImpl implements TrazabilidadRemoteDataSource {
  final HttpClient _httpClient;

  TrazabilidadRemoteDataSourceImpl(this._httpClient);

  @override
  Future<String> generarToken({required String loteId}) async {
    try {
      final response = await _httpClient.post(
        ApiEndpoints.trazabilidadToken,
        data: {'lote_id': loteId},
      );

      final data = ApiResponseParser.extractDataMap(response.data);
      final token =
          (data['token'] ?? data['trazabilidad_token'] ?? '').toString();

      if (token.isEmpty) {
        throw const ServerException(
            message: 'No se recibio token de trazabilidad');
      }

      return token;
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(
        e,
        fallbackMessage: 'Error al generar token de trazabilidad',
      );
    }
  }

  @override
  Future<Map<String, dynamic>> consultarPublica({required String token}) async {
    try {
      final response = await _httpClient.get(
        ApiEndpoints.trazabilidadPublica(token),
        options: Options(extra: {'skipAuth': true}),
      );

      return ApiResponseParser.extractDataMap(response.data);
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(
        e,
        fallbackMessage: 'Error al consultar trazabilidad publica',
      );
    }
  }
}
