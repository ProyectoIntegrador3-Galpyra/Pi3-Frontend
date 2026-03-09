import 'package:dio/dio.dart';
import '../../config/env.dart';
import '../../config/constants/app_constants.dart';
import '../../config/constants/api_endpoints.dart';
import '../storage/secure_storage.dart';

/// Auth interceptor to add token to requests and handle token refresh
class AuthInterceptor extends Interceptor {
  final SecureStorage _secureStorage;
  final Dio _dio;
  bool _isRefreshing = false;

  AuthInterceptor(this._secureStorage, this._dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _secureStorage.read(AppConstants.tokenKey);
    
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && !_isRefreshing) {
      _isRefreshing = true;
      
      try {
        final refreshToken = await _secureStorage.read(AppConstants.refreshTokenKey);
        
        if (refreshToken != null && refreshToken.isNotEmpty) {
          // Intentar refrescar el token
          final newTokens = await _refreshToken(refreshToken);
          
          if (newTokens != null) {
            // Guardar nuevos tokens
            await _secureStorage.write(AppConstants.tokenKey, newTokens['access_token']);
            if (newTokens['refresh_token'] != null) {
              await _secureStorage.write(AppConstants.refreshTokenKey, newTokens['refresh_token']);
            }
            
            // Reintentar la petición original con el nuevo token
            final opts = err.requestOptions;
            opts.headers['Authorization'] = 'Bearer ${newTokens['access_token']}';
            
            _isRefreshing = false;
            
            final response = await _dio.fetch(opts);
            return handler.resolve(response);
          }
        }
        
        // Si no hay refresh token o falló, limpiar sesión
        await _clearSession();
        
      } catch (e) {
        // Error al refrescar, limpiar sesión
        await _clearSession();
      } finally {
        _isRefreshing = false;
      }
    }
    
    handler.next(err);
  }

  /// Refresca el access token usando el refresh token
  Future<Map<String, dynamic>?> _refreshToken(String refreshToken) async {
    try {
      // Crear un Dio separado sin interceptores para evitar loops
      final refreshDio = Dio(BaseOptions(
        baseUrl: _dio.options.baseUrl,
        connectTimeout: _dio.options.connectTimeout,
        receiveTimeout: _dio.options.receiveTimeout,
      ));
      
      final response = await refreshDio.post(
        ApiEndpoints.refreshToken,
        data: {'refresh_token': refreshToken},
      );
      
      if (response.statusCode == 200 && response.data != null) {
        return response.data as Map<String, dynamic>;
      }
      
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Limpia la sesión del usuario
  Future<void> _clearSession() async {
    await _secureStorage.delete(AppConstants.tokenKey);
    await _secureStorage.delete(AppConstants.refreshTokenKey);
    await _secureStorage.delete(AppConstants.userKey);
  }
}

/// Logging interceptor for debugging
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (Env.enableLogs) {
      print('┌──────────────────────────────────────────────────────────────');
      print('│ REQUEST: ${options.method} ${options.uri}');
      print('│ Headers: ${options.headers}');
      if (options.data != null) {
        print('│ Body: ${options.data}');
      }
      print('└──────────────────────────────────────────────────────────────');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (Env.enableLogs) {
      print('┌──────────────────────────────────────────────────────────────');
      print('│ RESPONSE: ${response.statusCode} ${response.requestOptions.uri}');
      print('│ Data: ${response.data}');
      print('└──────────────────────────────────────────────────────────────');
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (Env.enableLogs) {
      print('┌──────────────────────────────────────────────────────────────');
      print('│ ERROR: ${err.type}');
      print('│ URL: ${err.requestOptions.uri}');
      print('│ Message: ${err.message}');
      print('│ Response: ${err.response?.data}');
      print('└──────────────────────────────────────────────────────────────');
    }
    handler.next(err);
  }
}

/// Retry interceptor for failed requests
class RetryInterceptor extends Interceptor {
  final int maxRetries;
  final Duration retryDelay;

  RetryInterceptor({
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 1),
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final retryCount = err.requestOptions.extra['retryCount'] ?? 0;

    if (_shouldRetry(err) && retryCount < maxRetries) {
      await Future.delayed(retryDelay * (retryCount + 1));
      
      err.requestOptions.extra['retryCount'] = retryCount + 1;
      
      try {
        final response = await Dio().fetch(err.requestOptions);
        return handler.resolve(response);
      } catch (e) {
        // Continue to error handler
      }
    }
    
    handler.next(err);
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        (err.response?.statusCode != null && err.response!.statusCode! >= 500);
  }
}
