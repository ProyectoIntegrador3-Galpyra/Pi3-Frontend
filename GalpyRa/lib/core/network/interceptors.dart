import 'package:dio/dio.dart';
import 'dart:async';
import '../../config/env.dart';
import '../../config/constants/app_constants.dart';
import '../../config/constants/api_endpoints.dart';
import '../storage/secure_storage.dart';
import 'api_response_parser.dart';

/// Auth interceptor to add token to requests and handle token refresh
class AuthInterceptor extends Interceptor {
  final SecureStorage _secureStorage;
  final Dio _dio;
  bool _isRefreshing = false;
  Completer<String?>? _refreshCompleter;

  AuthInterceptor(this._secureStorage, this._dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final path = options.path;
    final skipAuth = options.extra['skipAuth'] == true ||
        path.contains(ApiEndpoints.login) ||
        path.contains(ApiEndpoints.refreshToken);
    if (skipAuth) {
      handler.next(options);
      return;
    }

    final token = await _secureStorage.read(AppConstants.tokenKey);

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;
    final skipAuth = err.requestOptions.extra['skipAuth'] == true;
    if (skipAuth) {
      handler.next(err);
      return;
    }

    if (statusCode == 410) {
      await _clearSession();
      handler.next(err);
      return;
    }

    final path = err.requestOptions.path;
    final isAuthRefreshCall = path.contains(ApiEndpoints.refreshToken);
    final isAuthLoginCall = path.contains(ApiEndpoints.login);
    final alreadyRetried = err.requestOptions.extra['authRetried'] == true;

    if (statusCode == 401 &&
        !isAuthRefreshCall &&
        !isAuthLoginCall &&
        !alreadyRetried) {
      try {
        final accessToken = await _refreshAndGetAccessToken();
        if (accessToken != null && accessToken.isNotEmpty) {
          final retryOptions = err.requestOptions;
          retryOptions.headers['Authorization'] = 'Bearer $accessToken';
          retryOptions.extra['authRetried'] = true;

          final response = await _dio.fetch(retryOptions);
          return handler.resolve(response);
        }

        await _clearSession();
      } catch (_) {
        await _clearSession();
      }
    }

    handler.next(err);
  }

  Future<String?> _refreshAndGetAccessToken() async {
    if (_isRefreshing) {
      return _refreshCompleter?.future;
    }

    _isRefreshing = true;
    _refreshCompleter = Completer<String?>();

    try {
      final refreshToken = await _secureStorage.read(AppConstants.refreshTokenKey);
      if (refreshToken == null || refreshToken.isEmpty) {
        _refreshCompleter?.complete(null);
        return null;
      }

      final newTokens = await _refreshToken(refreshToken);
      if (newTokens == null) {
        _refreshCompleter?.complete(null);
        return null;
      }

      final newAccessToken = (newTokens['access_token'] ?? '').toString();
      if (newAccessToken.isEmpty) {
        _refreshCompleter?.complete(null);
        return null;
      }

      await _secureStorage.write(AppConstants.tokenKey, newAccessToken);
      final newRefreshToken = (newTokens['refresh_token'] ?? '').toString();
      if (newRefreshToken.isNotEmpty) {
        await _secureStorage.write(AppConstants.refreshTokenKey, newRefreshToken);
      }

      _refreshCompleter?.complete(newAccessToken);
      return newAccessToken;
    } catch (_) {
      _refreshCompleter?.complete(null);
      return null;
    } finally {
      _isRefreshing = false;
      _refreshCompleter = null;
    }
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
        return ApiResponseParser.extractDataMap(response.data);
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
      print(
          '│ RESPONSE: ${response.statusCode} ${response.requestOptions.uri}');
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
  final Dio _dio;
  final int maxRetries;
  final Duration retryDelay;

  RetryInterceptor({
    required Dio dio,
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 1),
  }) : _dio = dio;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final noRetry = err.requestOptions.extra['noRetry'] == true;
    if (noRetry) {
      handler.next(err);
      return;
    }

    final retryCount = (err.requestOptions.extra['retryCount'] ?? 0) as int;

    if (_shouldRetry(err) && retryCount < maxRetries) {
      final waitDuration = _computeDelay(err, retryCount + 1);
      await Future.delayed(waitDuration);

      err.requestOptions.extra['retryCount'] = retryCount + 1;

      try {
        final response = await _dio.fetch(err.requestOptions);
        return handler.resolve(response);
      } catch (_) {
        // Continue to downstream error handler.
      }
    }

    handler.next(err);
  }

  bool _shouldRetry(DioException err) {
    if (err.type == DioExceptionType.cancel ||
        err.type == DioExceptionType.badCertificate ||
        err.type == DioExceptionType.badResponse) {
      final status = err.response?.statusCode;
      return status == 429 || (status != null && status >= 500);
    }

    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.unknown;
  }

  Duration _computeDelay(DioException err, int attempt) {
    final retryAfter = err.response?.headers.value('retry-after');
    if (retryAfter != null) {
      final seconds = int.tryParse(retryAfter);
      if (seconds != null && seconds > 0) {
        return Duration(seconds: seconds);
      }
    }

    final exponential = retryDelay.inMilliseconds * attempt;
    return Duration(milliseconds: exponential);
  }
}
