import 'package:dio/dio.dart';

import '../../../../config/constants/api_endpoints.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_response_parser.dart';
import '../../../../core/network/http_client.dart';
import '../models/usuario_admin_model.dart';

abstract class AdminRemoteDataSource {
  Future<List<UsuarioAdminModel>> listarUsuarios();

  Future<UsuarioAdminModel> crearUsuario({
    required String nombre,
    required String email,
    required String password,
    required String role,
  });

  Future<UsuarioAdminModel> actualizarUsuario(
    String id, {
    String? nombre,
    String? email,
    String? password,
    String? role,
  });

  Future<void> eliminarUsuario(String id);
}

class AdminRemoteDataSourceImpl implements AdminRemoteDataSource {
  final HttpClient _httpClient;

  AdminRemoteDataSourceImpl(this._httpClient);

  @override
  Future<List<UsuarioAdminModel>> listarUsuarios() async {
    try {
      final response = await _httpClient.get(ApiEndpoints.adminUsers);
      return UsuarioAdminModel.fromList(response.data);
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(
        e,
        fallbackMessage: 'Error al listar usuarios',
      );
    }
  }

  @override
  Future<UsuarioAdminModel> crearUsuario({
    required String nombre,
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      final response = await _httpClient.post(
        ApiEndpoints.adminUsers,
        data: {
          'nombre': nombre,
          'email': email,
          'password': password,
          'rol': role,
        },
      );
      final data = ApiResponseParser.extractDataMap(response.data);
      return UsuarioAdminModel.fromJson(data);
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(
        e,
        fallbackMessage: 'Error al crear usuario',
      );
    }
  }

  @override
  Future<UsuarioAdminModel> actualizarUsuario(
    String id, {
    String? nombre,
    String? email,
    String? password,
    String? role,
  }) async {
    try {
      final payload = <String, dynamic>{
        if (nombre != null) 'nombre': nombre,
        if (email != null) 'email': email,
        if (password != null && password.trim().isNotEmpty) 'password': password,
        if (role != null) 'rol': role,
      };

      final response = await _httpClient.patch(
        ApiEndpoints.adminUserById(id),
        data: payload,
      );
      final data = ApiResponseParser.extractDataMap(response.data);
      return UsuarioAdminModel.fromJson(data);
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(
        e,
        fallbackMessage: 'Error al actualizar usuario',
      );
    }
  }

  @override
  Future<void> eliminarUsuario(String id) async {
    try {
      await _httpClient.delete(ApiEndpoints.adminUserById(id));
    } on DioException catch (e) {
      throw ApiResponseParser.toServerException(
        e,
        fallbackMessage: 'Error al eliminar usuario',
      );
    } catch (e) {
      throw ServerException(
        message: 'Error al eliminar usuario',
        originalException: e,
      );
    }
  }
}
