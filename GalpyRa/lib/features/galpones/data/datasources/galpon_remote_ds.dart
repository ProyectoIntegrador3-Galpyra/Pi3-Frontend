import '../../../../core/network/http_client.dart';
import '../../../../config/constants/api_endpoints.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_response_parser.dart';
import 'package:dio/dio.dart';
import '../models/galpon_model.dart';

/// Galpon remote data source interface
abstract class GalponRemoteDataSource {
  Future<List<GalponModel>> listarGalpones();
  Future<GalponModel> obtenerGalpon(String id);
  Future<GalponModel> crearGalpon(GalponModel galpon);
  Future<GalponModel> editarGalpon(GalponModel galpon);
  Future<void> eliminarGalpon(String id);
}

/// Galpon remote data source implementation
class GalponRemoteDataSourceImpl implements GalponRemoteDataSource {
  final HttpClient _httpClient;

  GalponRemoteDataSourceImpl(this._httpClient);

  @override
  Future<List<GalponModel>> listarGalpones() async {
    try {
      final response = await _httpClient.get(ApiEndpoints.galpones);
      final list = ApiResponseParser.extractDataList(response.data);

      if (list.isNotEmpty) {
        return list
            .map((item) => GalponModel.fromJson(ApiResponseParser.asMap(item)))
            .toList();
      }

      final data = ApiResponseParser.extractDataMap(response.data);
      final fallbackList = data['items'] ?? data['galpones'] ?? data['lista'];
      if (fallbackList is List) {
        return fallbackList
            .map((item) => GalponModel.fromJson(ApiResponseParser.asMap(item)))
            .toList();
      }

      return <GalponModel>[];
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(e, fallbackMessage: 'Error al obtener galpones');
    } catch (e) {
      throw ServerException(
        message: 'Error al obtener galpones',
        originalException: e,
      );
    }
  }

  @override
  Future<GalponModel> obtenerGalpon(String id) async {
    try {
      final response = await _httpClient.get(ApiEndpoints.galponById(id));
      final data = ApiResponseParser.extractDataMap(response.data);
      return GalponModel.fromJson(data);
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(e, fallbackMessage: 'Error al obtener galpon');
    } catch (e) {
      throw ServerException(
        message: 'Error al obtener galpon',
        originalException: e,
      );
    }
  }

  @override
  Future<GalponModel> crearGalpon(GalponModel galpon) async {
    try {
      final response = await _httpClient.post(
        ApiEndpoints.galpones,
        data: galpon.toJson(),
      );
      final data = ApiResponseParser.extractDataMap(response.data);
      return GalponModel.fromJson(data.isEmpty ? galpon.toJson() : data);
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(e, fallbackMessage: 'Error al crear galpon');
    } catch (e) {
      throw ServerException(
        message: 'Error al crear galpon',
        originalException: e,
      );
    }
  }

  @override
  Future<GalponModel> editarGalpon(GalponModel galpon) async {
    try {
      final response = await _httpClient.put(
        ApiEndpoints.galponById(galpon.id),
        data: galpon.toJson(),
      );
      final data = ApiResponseParser.extractDataMap(response.data);
      return GalponModel.fromJson(data.isEmpty ? galpon.toJson() : data);
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(e, fallbackMessage: 'Error al editar galpon');
    } catch (e) {
      throw ServerException(
        message: 'Error al editar galpon',
        originalException: e,
      );
    }
  }

  @override
  Future<void> eliminarGalpon(String id) async {
    try {
      await _httpClient.delete(ApiEndpoints.galponById(id));
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(e, fallbackMessage: 'Error al eliminar galpon');
    } catch (e) {
      throw ServerException(
        message: 'Error al eliminar galpon',
        originalException: e,
      );
    }
  }
}
