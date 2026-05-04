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

/// Mapeo de enum frontend → valor string que espera el backend.
String _tipoToBackend(TipoEventoSanitario tipo) {
  switch (tipo) {
    case TipoEventoSanitario.vacunacion:
      return 'VACUNACION';
    case TipoEventoSanitario.tratamiento:
      return 'TRATAMIENTO';
    case TipoEventoSanitario.inspeccion:
      return 'INSPECCION';
    case TipoEventoSanitario.cuarentena:
      // Backend no tiene cuarentena; DIAGNOSTICO es el más cercano.
      return 'DIAGNOSTICO';
    case TipoEventoSanitario.desparasitacion:
      return 'TRATAMIENTO';
  }
}

/// Implementación del data source remoto
class SanidadRemoteDataSourceImpl implements SanidadRemoteDataSource {
  final HttpClient _httpClient;

  SanidadRemoteDataSourceImpl(this._httpClient);

  /// Obtiene el ID del primer lote del galpón (requerido por el backend para eventos sanitarios).
  Future<String> _getActiveLoteId(String galponId) async {
    final response = await _httpClient.get(ApiEndpoints.avesByGalpon(galponId));
    final list = ApiResponseParser.extractDataList(response.data);
    if (list.isEmpty) {
      throw const ServerException(
        message: 'No hay lotes registrados para este galpon. Registra un ingreso de aves primero.',
      );
    }
    final lote = ApiResponseParser.asMap(list.first);
    final id = lote['id']?.toString() ?? '';
    if (id.isEmpty) {
      throw const ServerException(message: 'Lote sin ID valido en el servidor.');
    }
    return id;
  }

  @override
  Future<List<RegistroSanitarioModel>> obtenerHistorial(
    String galponId, {
    TipoEventoSanitario? tipo,
    DateTime? desde,
    DateTime? hasta,
  }) async {
    try {
      // Backend GET /api/sanidad no soporta filtro por galpon_id vía query params;
      // se filtra localmente por galpon_id después de recibir la respuesta.
      final response = await _httpClient.get(ApiEndpoints.sanidad);

      final list = ApiResponseParser.extractDataList(response.data);
      if (list.isEmpty) return <RegistroSanitarioModel>[];

      var registros = list
          .map((item) => ApiResponseParser.asMap(item))
          .where((m) => m['galpon_id']?.toString() == galponId)
          .map((m) => RegistroSanitarioModel.fromJson(m))
          .toList();

      if (tipo != null) {
        final tipoBackend = _tipoToBackend(tipo).toLowerCase();
        registros = registros
            .where(
              (r) =>
                  r.tipo.name.toLowerCase() == tipoBackend ||
                  _tipoToBackend(r.tipo).toLowerCase() == tipoBackend,
            )
            .toList();
      }

      if (desde != null) {
        registros = registros.where((r) => !r.fecha.isBefore(desde)).toList();
      }
      if (hasta != null) {
        registros = registros.where((r) => !r.fecha.isAfter(hasta)).toList();
      }

      return registros;
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
      // Backend requires lote_id; fetch the active lote for this galpon.
      final loteId = await _getActiveLoteId(galponId);

      final response = await _httpClient.post(
        ApiEndpoints.sanidad,
        data: {
          'lote_id': loteId,
          'galpon_id': galponId,
          'tipo_evento': _tipoToBackend(tipo),
          'descripcion': descripcion,
          'fecha': fecha.toIso8601String().split('T').first,
          if (medicamento != null && medicamento.trim().isNotEmpty)
            'producto': medicamento.trim(),
          if (dosis != null && dosis.trim().isNotEmpty)
            'dosis': dosis.trim(),
          if (veterinario != null && veterinario.trim().isNotEmpty)
            'responsable': veterinario.trim(),
          if (observaciones != null && observaciones.trim().isNotEmpty)
            'observaciones': observaciones.trim(),
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
      // Backend no soporta filtro ?pendientes=true; devuelve todos y filtra localmente.
      final response = await _httpClient.get(ApiEndpoints.sanidad);

      final list = ApiResponseParser.extractDataList(response.data);
      if (list.isEmpty) return <RegistroSanitarioModel>[];

      final now = DateTime.now();
      return list
          .map((item) => RegistroSanitarioModel.fromJson(ApiResponseParser.asMap(item)))
          .where(
            (r) =>
                r.fechaProximaAplicacion != null &&
                r.fechaProximaAplicacion!.isAfter(now),
          )
          .toList();
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(e, fallbackMessage: 'Error al obtener pendientes sanitarios');
    }
  }

  @override
  Future<Map<String, dynamic>> obtenerResumen(String galponId) async {
    try {
      // Backend no tiene endpoint de resumen por galpon; devuelve vacío.
      return <String, dynamic>{};
    } catch (e) {
      return <String, dynamic>{};
    }
  }
}
