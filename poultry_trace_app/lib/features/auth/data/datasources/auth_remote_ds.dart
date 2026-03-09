import '../../../../core/network/http_client.dart';
// ignore: unused_import
import '../../../../config/constants/api_endpoints.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../shared/enums/user_role.dart';
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
  // ignore: unused_field
  final HttpClient _httpClient;

  AuthRemoteDataSourceImpl(this._httpClient);

  @override
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      // TODO: Implement actual API call
      // final response = await _httpClient.post(
      //   ApiEndpoints.login,
      //   data: {'email': email, 'password': password},
      // );
      // return response.data;

      // Mock response for development
      await Future.delayed(const Duration(seconds: 1));
      
      if (email == 'demo@example.com' && password == 'password') {
        return {
          'access_token': 'mock_access_token_123',
          'refresh_token': 'mock_refresh_token_123',
          'user': {
            'id': '1',
            'email': email,
            'name': 'Usuario Demo',
            'role': 'admin',
            'created_at': DateTime.now().toIso8601String(),
          },
        };
      }
      
      throw const ServerException(
        message: 'Credenciales inválidas',
        statusCode: 401,
      );
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(
        message: 'Error al iniciar sesión',
        originalException: e,
      );
    }
  }

  @override
  Future<void> logout() async {
    try {
      // TODO: Implement actual API call
      // await _httpClient.post(ApiEndpoints.logout);
      await Future.delayed(const Duration(milliseconds: 500));
    } catch (e) {
      throw ServerException(
        message: 'Error al cerrar sesión',
        originalException: e,
      );
    }
  }

  @override
  Future<UserModel> getProfile() async {
    try {
      // TODO: Implement actual API call
      // final response = await _httpClient.get(ApiEndpoints.profile);
      // return UserModel.fromJson(response.data);

      // Mock response for development
      await Future.delayed(const Duration(milliseconds: 500));
      return UserModel(
        id: '1',
        email: 'demo@example.com',
        name: 'Usuario Demo',
        role: UserRole.admin,
        createdAt: DateTime.now(),
      );
    } catch (e) {
      throw ServerException(
        message: 'Error al obtener perfil',
        originalException: e,
      );
    }
  }
}
