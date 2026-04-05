import 'package:dio/dio.dart';

import '../../../../config/constants/api_endpoints.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_response_parser.dart';
import '../../../../core/network/http_client.dart';
import '../../domain/entities/conteo_foto.dart';
import '../models/conteo_foto_model.dart';

/// Remote data source para inventario por foto
abstract class InventarioFotoRemoteDataSource {
  Future<ConteoFotoModel> procesarImagen({
    required String galponId,
    required String imagePath,
  });

  Future<ConteoFotoModel> actualizarConteo({
    required String conteoId,
    required int conteoManual,
    int? conteoFinal,
  });

  Future<void> confirmarInventario({
    required String galponId,
    required String conteoId,
    required int cantidadFinal,
  });

  Future<List<ConteoFotoModel>> obtenerHistorial(String galponId);
  Future<ConteoFotoModel> obtenerConteo(String conteoId);
}

/// Implementación del data source remoto
class InventarioFotoRemoteDataSourceImpl implements InventarioFotoRemoteDataSource {
  final HttpClient _httpClient;

  InventarioFotoRemoteDataSourceImpl(this._httpClient);

  ConteoFotoModel _mapJobToConteo(Map<String, dynamic> job) {
    final estadoRaw = (job['estado'] ?? job['status'] ?? 'pendiente').toString().toLowerCase();
    EstadoConteo estado;
    switch (estadoRaw) {
      case 'completado':
      case 'completed':
      case 'done':
        estado = EstadoConteo.completado;
        break;
      case 'procesando':
      case 'processing':
      case 'pending':
      case 'queued':
        estado = EstadoConteo.procesando;
        break;
      case 'error':
      case 'failed':
        estado = EstadoConteo.error;
        break;
      default:
        estado = EstadoConteo.pendiente;
    }

    final createdAtRaw = (job['created_at'] ?? job['fecha_captura'] ?? DateTime.now().toIso8601String()).toString();
    final fechaCaptura = DateTime.tryParse(createdAtRaw) ?? DateTime.now();
    final conteoAutomatico = (job['conteo_automatico'] ?? job['conteo_detectado']) as num?;
    final conteoManual = (job['conteo_manual'] ?? job['conteo_confirmado']) as num?;

    return ConteoFotoModel(
      id: (job['job_id'] ?? job['id'] ?? '').toString(),
      galponId: (job['galpon_id'] ?? '').toString(),
      imagePath: (job['imagen_url'] ?? job['image_path'] ?? '').toString(),
      fechaCaptura: fechaCaptura,
      estado: estado,
      conteoAutomatico: conteoAutomatico?.toInt(),
      conteoManual: conteoManual?.toInt(),
      conteoFinal: (job['conteo_final'] as num?)?.toInt(),
      confianza: (job['confianza'] as num?)?.toDouble(),
      mensajeError: job['error']?.toString(),
      metadatos: ApiResponseParser.asMap(job['detalles'] ?? job['metadatos']),
      createdAt: fechaCaptura,
    );
  }

  @override
  Future<ConteoFotoModel> procesarImagen({
    required String galponId,
    required String imagePath,
  }) async {
    try {
      final response = await _httpClient.uploadFile(
        ApiEndpoints.inventarioProcesar,
        filePath: imagePath,
        fieldName: 'imagen',
        extraData: {'galpon_id': galponId},
      );

      final data = ApiResponseParser.extractDataMap(response.data);
      return _mapJobToConteo(data);
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(e, fallbackMessage: 'Error al procesar imagen');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: 'Error al procesar imagen', originalException: e);
    }
  }

  @override
  Future<ConteoFotoModel> actualizarConteo({
    required String conteoId,
    required int conteoManual,
    int? conteoFinal,
  }) async {
    try {
      final response = await _httpClient.post(
        ApiEndpoints.inventarioConfirmar,
        data: {
          'job_id': conteoId,
          'conteo_manual': conteoManual,
          if (conteoFinal != null) 'conteo_final': conteoFinal,
        },
      );
      final data = ApiResponseParser.extractDataMap(response.data);
      return _mapJobToConteo(data);
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(e, fallbackMessage: 'Error al actualizar conteo');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: 'Error al actualizar conteo', originalException: e);
    }
  }

  @override
  Future<void> confirmarInventario({
    required String galponId,
    required String conteoId,
    required int cantidadFinal,
  }) async {
    try {
      await _httpClient.post(
        ApiEndpoints.inventarioConfirmar,
        data: {
          'job_id': conteoId,
          'galpon_id': galponId,
          'cantidad_final': cantidadFinal,
          'conteo_final': cantidadFinal,
        },
      );
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(e, fallbackMessage: 'Error al confirmar inventario');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: 'Error al confirmar inventario', originalException: e);
    }
  }

  @override
  Future<List<ConteoFotoModel>> obtenerHistorial(String galponId) async {
    try {
      final response = await _httpClient.get(
        ApiEndpoints.inventarioJobs,
        queryParameters: {'galpon_id': galponId},
      );
      final items = ApiResponseParser.extractDataList(response.data);
      return items
          .map((job) => _mapJobToConteo(ApiResponseParser.asMap(job)))
          .where((item) => item.galponId == galponId || item.galponId.isEmpty)
          .toList();
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(e, fallbackMessage: 'Error al obtener historial');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: 'Error al obtener historial', originalException: e);
    }
  }

  @override
  Future<ConteoFotoModel> obtenerConteo(String conteoId) async {
    try {
      final response = await _httpClient.get(ApiEndpoints.inventarioJobById(conteoId));
      final data = ApiResponseParser.extractDataMap(response.data);
      return _mapJobToConteo(data);
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(e, fallbackMessage: 'Error al obtener conteo');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: 'Error al obtener conteo', originalException: e);
    }
  }
}
