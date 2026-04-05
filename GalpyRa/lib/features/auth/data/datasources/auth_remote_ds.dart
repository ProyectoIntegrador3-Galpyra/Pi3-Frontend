import '../../../../core/network/http_client.dart';
import '../../../../config/constants/api_endpoints.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_response_parser.dart';
import 'package:dio/dio.dart';
import '../../../../core/storage/secure_storage.dart';
import '../../../../config/constants/app_constants.dart';
import '../models/user_model.dart';

/// Auth remote data source interface
abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  });
  Future<void> logout();
  Future<UserModel> getProfile();
}

/// Auth remote data source implementation
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final HttpClient _httpClient;
  final SecureStorage _secureStorage;

  AuthRemoteDataSourceImpl(this._httpClient, this._secureStorage);

  @override
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _httpClient.post(
        ApiEndpoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      final responseData = response.data;
      if (!ApiResponseParser.isSuccess(responseData)) {
        throw ServerException(
          message: ApiResponseParser.extractMessage(responseData, fallback: 'Credenciales invalidas'),
          statusCode: ApiResponseParser.extractStatusCode(responseData) ?? response.statusCode,
        );
      }

      final data = ApiResponseParser.extractDataMap(responseData);
      return {
        'access_token': data['access_token'],
        'refresh_token': data['refresh_token'],
        'user': data['user'],
        'token_type': data['token_type'],
      };
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(e, fallbackMessage: 'Error al iniciar sesion');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(
        message: 'Error al iniciar sesion',
        originalException: e,
      );
    }
  }

  @override
  Future<void> logout() async {
    try {
      final refreshToken = await _secureStorage.read(AppConstants.refreshTokenKey);
      await _httpClient.post(
        ApiEndpoints.logout,
        data: refreshToken == null
            ? null
            : {
                'refresh_token': refreshToken,
              },
      );
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(e, fallbackMessage: 'Error al cerrar sesion');
    } catch (e) {
      throw ServerException(
        message: 'Error al cerrar sesion',
        originalException: e,
      );
    }
  }

  @override
  Future<UserModel> getProfile() async {
    try {
      final response = await _httpClient.get(ApiEndpoints.profile);
      final data = ApiResponseParser.extractDataMap(response.data);
      final userJson = ApiResponseParser.asMap(data['user'] ?? data);
      return UserModel.fromJson(userJson);
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(e, fallbackMessage: 'Error al obtener perfil');
    } catch (e) {
      throw ServerException(
        message: 'Error al obtener perfil',
        originalException: e,
      );
    }
  }
}
