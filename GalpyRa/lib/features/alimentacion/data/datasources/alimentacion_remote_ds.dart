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
      // Backend GET /api/alimentacion no soporta filtro por galpon_id en query params;
      // se filtra localmente después de recibir la lista completa.
      final response = await _httpClient.get(ApiEndpoints.alimentacion);

      final list = ApiResponseParser.extractDataList(response.data);
      if (list.isEmpty) return <RegistroAlimentacionModel>[];

      var registros = list
          .map((item) => ApiResponseParser.asMap(item))
          .where((m) => m['galpon_id']?.toString() == galponId)
          .map((m) => RegistroAlimentacionModel.fromJson(m))
          .toList();

      if (desde != null) {
        registros = registros.where((r) => !r.fecha.isBefore(desde)).toList();
      }
      if (hasta != null) {
        registros = registros.where((r) => !r.fecha.isAfter(hasta)).toList();
      }

      return registros;
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(
        e,
        fallbackMessage: 'Error al obtener historial de alimentacion',
      );
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
          'fecha': fecha.toIso8601String().split('T').first,
          'tipo_alimento': tipoAlimento.name,
          'cantidad_kg': cantidadKg,
          // Backend field is 'costo'; frontend uses 'costo_unitario'.
          if (costoUnitario != null) 'costo': costoUnitario,
          if (observaciones != null && observaciones.isNotEmpty)
            'observaciones': observaciones,
        },
      );

      final data = ApiResponseParser.extractDataMap(response.data);
      // Merge the original request fields (nombre_alimento etc.) not returned
      // by the backend so the model can be constructed without nulls.
      final merged = {
        'nombre_alimento': nombreAlimento,
        'costo_unitario': costoUnitario,
        'numero_aves': numeroAves,
        'lote_alimento': loteAlimento,
        'proveedor': proveedor,
        ...data,
      };
      return RegistroAlimentacionModel.fromJson(merged);
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(
        e,
        fallbackMessage: 'Error al registrar alimentacion',
      );
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(
        message: 'Error al registrar alimentacion',
        originalException: e,
      );
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
        ApiEndpoints.alimentacion,
        queryParameters: {
          'fecha_inicio': desde.toIso8601String(),
          'fecha_fin': hasta.toIso8601String(),
        },
      );
      return ApiResponseParser.extractDataMap(response.data);
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(
        e,
        fallbackMessage: 'Error al obtener consumo promedio',
      );
    }
  }

  @override
  Future<Map<String, double>> obtenerInventarioAlimentos() async {
    try {
      final response = await _httpClient.get(ApiEndpoints.alimentacion);

      final list = ApiResponseParser.extractDataList(response.data);
      final map = <String, double>{};
      for (final item in list) {
        final row = ApiResponseParser.asMap(item);
        final nombre =
            (row['nombre_alimento'] ?? row['tipo_alimento'] ?? row['nombre'])
                ?.toString();
        final cantidad =
            row['cantidad_kg'] ?? row['cantidad'] ?? row['stock_kg'];
        if (nombre != null && cantidad is num) {
          map[nombre] = cantidad.toDouble();
        }
      }
      return map;
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(
        e,
        fallbackMessage: 'Error al obtener inventario de alimentos',
      );
    }
  }
}
