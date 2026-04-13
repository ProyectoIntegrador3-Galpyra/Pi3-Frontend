import 'package:dio/dio.dart';

import '../../../../config/constants/api_endpoints.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_response_parser.dart';
import '../../../../core/network/http_client.dart';

abstract class TrazabilidadRemoteDataSource {
  Future<String> generarToken({required String loteId});
  Future<Map<String, dynamic>> consultarPublica({required String token});
  Future<List<Map<String, String>>> listarLotes();
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
      final token = (data['token'] ?? '').toString();

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

  @override
  Future<List<Map<String, String>>> listarLotes() async {
    try {
      final galponesResponse = await _httpClient.get(ApiEndpoints.galpones);
      final lotesResponse = await _httpClient.get(ApiEndpoints.lotes);

      final galpones = ApiResponseParser.extractDataList(galponesResponse.data);
      final lotes = ApiResponseParser.extractDataList(lotesResponse.data);

      final galponNombreById = <String, String>{
        for (final item in galpones)
          ApiResponseParser.asMap(item)['id']?.toString() ?? '':
              (ApiResponseParser.asMap(item)['nombre'] ?? 'Galpón').toString(),
      };

      return lotes
          .map((item) {
            final lote = ApiResponseParser.asMap(item);
            final id = (lote['id'] ?? '').toString();
            final galponId = (lote['galpon_id'] ?? '').toString();
            final nombreLote =
                (lote['codigo_lote'] ?? lote['nombre_lote'] ?? 'Lote')
                    .toString();
            final nombreGalpon = galponNombreById[galponId] ?? 'Sin galpón';

            return {
              'id': id,
              'nombre_lote': nombreLote,
              'nombre_galpon': nombreGalpon,
            };
          })
          .where((e) => (e['id'] ?? '').isNotEmpty)
          .toList();
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(
        e,
        fallbackMessage: 'Error al cargar lotes para trazabilidad',
      );
    }
  }
}
