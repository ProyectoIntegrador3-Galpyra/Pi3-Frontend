import 'package:dio/dio.dart';

import '../../../../config/constants/api_endpoints.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_response_parser.dart';
import '../../../../core/network/http_client.dart';
import '../../domain/entities/registro_alimentacion.dart';
import '../models/registro_alimentacion_model.dart';

/// Remote data source para alimentación
abstract class AlimentacionRemoteDataSource {
  Future<List<RegistroAlimentacionModel>> obtenerHistorial(
    String galponId, {
    DateTime? desde,
    DateTime? hasta,
  });

  Future<RegistroAlimentacionModel> registrarAlimentacion({
    required String galponId,
    required DateTime fecha,
    required TipoAlimento tipoAlimento,
    required String nombreAlimento,
    required double cantidadKg,
    double? costoUnitario,
    int? numeroAves,
    String? loteAlimento,
    String? proveedor,
    String? observaciones,
  });

  Future<Map<String, dynamic>> obtenerConsumoPromedio(
    String galponId, {
    required DateTime desde,
    required DateTime hasta,
  });

  Future<Map<String, double>> obtenerInventarioAlimentos();
}

/// Implementación del data source remoto
class AlimentacionRemoteDataSourceImpl implements AlimentacionRemoteDataSource {
  final HttpClient _httpClient;

  AlimentacionRemoteDataSourceImpl(this._httpClient);

  @override
  Future<List<RegistroAlimentacionModel>> obtenerHistorial(
    String galponId, {
    DateTime? desde,
    DateTime? hasta,
  }) async {
    try {
      final response = await _httpClient.get(
        ApiEndpoints.alimentacionByGalpon(galponId),
        queryParameters: {
          if (desde != null) 'fecha_inicio': desde.toIso8601String(),
          if (hasta != null) 'fecha_fin': hasta.toIso8601String(),
        },
      );

      final list = ApiResponseParser.extractDataList(response.data);
      if (list.isNotEmpty) {
        return list
            .map((item) => RegistroAlimentacionModel.fromJson(ApiResponseParser.asMap(item)))
            .toList();
      }

      final data = ApiResponseParser.extractDataMap(response.data);
      final fallbackList = data['items'] ?? data['registros'] ?? data['historial'];
      if (fallbackList is List) {
        return fallbackList
            .map((item) => RegistroAlimentacionModel.fromJson(ApiResponseParser.asMap(item)))
            .toList();
      }

      return <RegistroAlimentacionModel>[];
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(e, fallbackMessage: 'Error al obtener historial de alimentacion');
    }
  }

  @override
  Future<RegistroAlimentacionModel> registrarAlimentacion({
    required String galponId,
    required DateTime fecha,
    required TipoAlimento tipoAlimento,
    required String nombreAlimento,
    required double cantidadKg,
    double? costoUnitario,
    int? numeroAves,
    String? loteAlimento,
    String? proveedor,
    String? observaciones,
  }) async {
    try {
      final response = await _httpClient.post(
        ApiEndpoints.alimentacion,
        data: {
          'galpon_id': galponId,
          'fecha': fecha.toIso8601String(),
          'tipo_alimento': tipoAlimento.name,
          'nombre_alimento': nombreAlimento,
          'cantidad_kg': cantidadKg,
          if (costoUnitario != null) 'costo_unitario': costoUnitario,
          if (numeroAves != null) 'numero_aves': numeroAves,
          if (loteAlimento != null && loteAlimento.isNotEmpty) 'lote_alimento': loteAlimento,
          if (proveedor != null && proveedor.isNotEmpty) 'proveedor': proveedor,
          if (observaciones != null && observaciones.isNotEmpty) 'observaciones': observaciones,
        },
      );

      final data = ApiResponseParser.extractDataMap(response.data);
      return RegistroAlimentacionModel.fromJson(data);
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(e, fallbackMessage: 'Error al registrar alimentacion');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: 'Error al registrar alimentacion', originalException: e);
    }
  }

  @override
  Future<Map<String, dynamic>> obtenerConsumoPromedio(
    String galponId, {
    required DateTime desde,
    required DateTime hasta,
  }) async {
    try {
      final response = await _httpClient.get(
        ApiEndpoints.alimentacionByGalpon(galponId),
        queryParameters: {
          'resumen': true,
          'fecha_inicio': desde.toIso8601String(),
          'fecha_fin': hasta.toIso8601String(),
        },
      );
      return ApiResponseParser.extractDataMap(response.data);
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(e, fallbackMessage: 'Error al obtener consumo promedio');
    }
  }

  @override
  Future<Map<String, double>> obtenerInventarioAlimentos() async {
    try {
      final response = await _httpClient.get(
        ApiEndpoints.alimentacion,
        queryParameters: {'inventario': true},
      );

      final data = ApiResponseParser.extractDataMap(response.data);
      final map = <String, double>{};

      if (data.isNotEmpty) {
        for (final entry in data.entries) {
          if (entry.value is num) {
            map[entry.key] = (entry.value as num).toDouble();
          }
        }
      }

      if (map.isNotEmpty) {
        return map;
      }

      final list = ApiResponseParser.extractDataList(response.data);
      for (final item in list) {
        final row = ApiResponseParser.asMap(item);
        final nombre = (row['nombre_alimento'] ?? row['nombre'] ?? row['tipo'])?.toString();
        final cantidad = row['cantidad'] ?? row['stock_kg'] ?? row['cantidad_kg'];
        if (nombre != null && cantidad is num) {
          map[nombre] = cantidad.toDouble();
        }
      }
      return map;
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(e, fallbackMessage: 'Error al obtener inventario de alimentos');
    }
  }
}
