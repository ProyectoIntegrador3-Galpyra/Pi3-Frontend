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
    String? nombreLote,
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

  /// Obtiene el ID del primer lote activo del galpón, necesario para mortalidad y sanidad.
  Future<String> _getActiveLoteId(String galponId) async {
    final response = await _httpClient.get(ApiEndpoints.avesByGalpon(galponId));
    final list = ApiResponseParser.extractDataList(response.data);
    if (list.isEmpty) {
      throw const ServerException(
        message:
            'No hay lotes registrados para este galpon. Registra un ingreso primero.',
      );
    }
    final lote = ApiResponseParser.asMap(list.first);
    final id = lote['id']?.toString() ?? '';
    if (id.isEmpty) {
      throw const ServerException(
          message: 'Lote sin ID valido en el servidor.');
    }
    return id;
  }

  @override
  Future<List<LoteAvesModel>> consultarInventario(String galponId) async {
    try {
      final response =
          await _httpClient.get(ApiEndpoints.avesByGalpon(galponId));

      final list = ApiResponseParser.extractDataList(response.data);
      if (list.isNotEmpty) {
        return list
            .map(
                (item) => LoteAvesModel.fromJson(ApiResponseParser.asMap(item)))
            .toList();
      }

      return <LoteAvesModel>[];
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(e,
          fallbackMessage: 'Error al consultar inventario');
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
      // Backend requires lote_id; fetch the active lote for this galpon first.
      final loteId = await _getActiveLoteId(galponId);

      await _httpClient.post(
        ApiEndpoints.mortalidad,
        data: {
          'lote_id': loteId,
          'cantidad': cantidad,
          'causa': causa,
          'fecha': fecha.toIso8601String(),
          if (observaciones != null && observaciones.isNotEmpty)
            'observaciones': observaciones,
        },
      );
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(e,
          fallbackMessage: 'Error al registrar mortalidad');
    }
  }

  @override
  Future<LoteAvesModel> registrarIngreso({
    required String galponId,
    String? nombreLote,
    required String raza,
    required int cantidad,
    required DateTime fechaIngreso,
    int? edadSemanas,
    double? pesoPromedio,
    String? observaciones,
  }) async {
    try {
      // Backend creates a Lote (POST /api/lotes) which represents the ingreso.
      final codigoLote = (nombreLote != null && nombreLote.trim().isNotEmpty)
          ? nombreLote.trim()
          : 'LOTE-${DateTime.now().millisecondsSinceEpoch}';
      final response = await _httpClient.post(
        ApiEndpoints.ingresoAves,
        data: {
          'codigo_lote': codigoLote,
          'nombre_lote': codigoLote,
          'tipo_ave': 'ponedora',
          'raza': raza,
          'cantidad_inicial': cantidad,
          'fecha_ingreso': fechaIngreso.toIso8601String().split('T').first,
          'galpon_id': galponId,
          if (observaciones != null && observaciones.isNotEmpty)
            'observaciones': observaciones,
        },
      );

      final data = ApiResponseParser.extractDataMap(response.data);
      return LoteAvesModel.fromJson(data);
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(e,
          fallbackMessage: 'Error al registrar ingreso');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(
          message: 'Error al registrar ingreso', originalException: e);
    }
  }
}
