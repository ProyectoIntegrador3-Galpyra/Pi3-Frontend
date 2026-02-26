import 'dart:convert';
import '../../../../core/storage/secure_storage.dart';
import '../../../../core/storage/local_db.dart';
import '../../../../config/constants/app_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/user_model.dart';

/// Auth local data source interface
abstract class AuthLocalDataSource {
  Future<void> cacheToken(String token);
  Future<void> cacheRefreshToken(String token);
  Future<void> cacheUser(UserModel user);
  Future<String?> getToken();
  Future<String?> getRefreshToken();
  Future<UserModel?> getCachedUser();
  Future<void> clearAuthData();
}

/// Auth local data source implementation
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SecureStorage _secureStorage;
  final LocalDb _localDb;

  AuthLocalDataSourceImpl(this._secureStorage, this._localDb);

  @override
  Future<void> cacheToken(String token) async {
    try {
      await _secureStorage.write(AppConstants.tokenKey, token);
    } catch (e) {
      throw CacheException(
        message: 'Error al guardar token',
        originalException: e,
      );
    }
  }

  @override
  Future<void> cacheRefreshToken(String token) async {
    try {
      await _secureStorage.write(AppConstants.refreshTokenKey, token);
    } catch (e) {
      throw CacheException(
        message: 'Error al guardar refresh token',
        originalException: e,
      );
    }
  }

  @override
  Future<void> cacheUser(UserModel user) async {
    try {
      final userJson = jsonEncode(user.toJson());
      await _localDb.setSetting(AppConstants.userKey, userJson);
    } catch (e) {
      throw CacheException(
        message: 'Error al guardar usuario',
        originalException: e,
      );
    }
  }

  @override
  Future<String?> getToken() async {
    try {
      return await _secureStorage.read(AppConstants.tokenKey);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<String?> getRefreshToken() async {
    try {
      return await _secureStorage.read(AppConstants.refreshTokenKey);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<UserModel?> getCachedUser() async {
    try {
      final userJson = await _localDb.getSetting<String>(AppConstants.userKey);
      if (userJson != null) {
        final userMap = jsonDecode(userJson) as Map<String, dynamic>;
        return UserModel.fromJson(userMap);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> clearAuthData() async {
    try {
      await _secureStorage.delete(AppConstants.tokenKey);
      await _secureStorage.delete(AppConstants.refreshTokenKey);
      await _localDb.removeSetting(AppConstants.userKey);
    } catch (e) {
      throw CacheException(
        message: 'Error al limpiar datos de autenticación',
        originalException: e,
      );
    }
  }
}
