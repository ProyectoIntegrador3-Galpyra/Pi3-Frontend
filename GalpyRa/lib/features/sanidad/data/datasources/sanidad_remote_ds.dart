import 'package:dio/dio.dart';

import '../../../../config/constants/api_endpoints.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_response_parser.dart';
import '../../../../core/network/http_client.dart';
import '../../domain/entities/registro_sanitario.dart';
import '../models/registro_sanitario_model.dart';

/// Remote data source para sanidad
abstract class SanidadRemoteDataSource {
  Future<List<RegistroSanitarioModel>> obtenerHistorial(
    String galponId, {
    TipoEventoSanitario? tipo,
    DateTime? desde,
    DateTime? hasta,
  });

  Future<RegistroSanitarioModel> registrarEvento({
    required String galponId,
    required TipoEventoSanitario tipo,
    required DateTime fecha,
    required String descripcion,
    String? medicamento,
    String? dosis,
    String? veterinario,
    int? avesAfectadas,
    DateTime? fechaProximaAplicacion,
    String? observaciones,
  });

  Future<List<RegistroSanitarioModel>> obtenerPendientes();
  Future<Map<String, dynamic>> obtenerResumen(String galponId);
}

/// Implementación del data source remoto
class SanidadRemoteDataSourceImpl implements SanidadRemoteDataSource {
  final HttpClient _httpClient;

  SanidadRemoteDataSourceImpl(this._httpClient);

  @override
  Future<List<RegistroSanitarioModel>> obtenerHistorial(
    String galponId, {
    TipoEventoSanitario? tipo,
    DateTime? desde,
    DateTime? hasta,
  }) async {
    try {
      final response = await _httpClient.get(
        ApiEndpoints.sanidadByGalpon(galponId),
        queryParameters: {
          if (tipo != null) 'tipo': tipo.name,
          if (desde != null) 'fecha_inicio': desde.toIso8601String(),
          if (hasta != null) 'fecha_fin': hasta.toIso8601String(),
        },
      );

      final list = ApiResponseParser.extractDataList(response.data);
      if (list.isNotEmpty) {
        return list
            .map((item) => RegistroSanitarioModel.fromJson(ApiResponseParser.asMap(item)))
            .toList();
      }

      final data = ApiResponseParser.extractDataMap(response.data);
      final fallbackList = data['items'] ?? data['eventos'] ?? data['historial'];
      if (fallbackList is List) {
        return fallbackList
            .map((item) => RegistroSanitarioModel.fromJson(ApiResponseParser.asMap(item)))
            .toList();
      }

      return <RegistroSanitarioModel>[];
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(e, fallbackMessage: 'Error al obtener historial sanitario');
    }
  }

  @override
  Future<RegistroSanitarioModel> registrarEvento({
    required String galponId,
    required TipoEventoSanitario tipo,
    required DateTime fecha,
    required String descripcion,
    String? medicamento,
    String? dosis,
    String? veterinario,
    int? avesAfectadas,
    DateTime? fechaProximaAplicacion,
    String? observaciones,
  }) async {
    try {
      final response = await _httpClient.post(
        ApiEndpoints.sanidad,
        data: {
          'galpon_id': galponId,
          'tipo': tipo.name,
          'fecha': fecha.toIso8601String(),
          'descripcion': descripcion,
          if (medicamento != null && medicamento.isNotEmpty) 'medicamento': medicamento,
          if (dosis != null && dosis.isNotEmpty) 'dosis': dosis,
          if (veterinario != null && veterinario.isNotEmpty) 'veterinario': veterinario,
          if (avesAfectadas != null) 'aves_afectadas': avesAfectadas,
          if (fechaProximaAplicacion != null)
            'fecha_proxima_aplicacion': fechaProximaAplicacion.toIso8601String(),
          if (observaciones != null && observaciones.isNotEmpty) 'observaciones': observaciones,
        },
      );

      final data = ApiResponseParser.extractDataMap(response.data);
      return RegistroSanitarioModel.fromJson(data);
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(e, fallbackMessage: 'Error al registrar evento sanitario');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: 'Error al registrar evento sanitario', originalException: e);
    }
  }

  @override
  Future<List<RegistroSanitarioModel>> obtenerPendientes() async {
    try {
      final response = await _httpClient.get(
        ApiEndpoints.sanidad,
        queryParameters: {'pendientes': true},
      );

      final list = ApiResponseParser.extractDataList(response.data);
      if (list.isNotEmpty) {
        return list
            .map((item) => RegistroSanitarioModel.fromJson(ApiResponseParser.asMap(item)))
            .toList();
      }

      return <RegistroSanitarioModel>[];
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(e, fallbackMessage: 'Error al obtener pendientes sanitarios');
    }
  }

  @override
  Future<Map<String, dynamic>> obtenerResumen(String galponId) async {
    try {
      final response = await _httpClient.get(
        ApiEndpoints.sanidadByGalpon(galponId),
        queryParameters: {'resumen': true},
      );
      return ApiResponseParser.extractDataMap(response.data);
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(e, fallbackMessage: 'Error al obtener resumen sanitario');
    }
  }
}
