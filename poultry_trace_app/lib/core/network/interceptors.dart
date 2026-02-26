import 'package:dio/dio.dart';
import '../../config/env.dart';
import '../../config/constants/app_constants.dart';
import '../storage/secure_storage.dart';

/// Auth interceptor to add token to requests
class AuthInterceptor extends Interceptor {
  final SecureStorage _secureStorage;

  AuthInterceptor(this._secureStorage);

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
    if (err.response?.statusCode == 401) {
      // TODO: Implement token refresh logic
      // final refreshToken = await _secureStorage.read(AppConstants.refreshTokenKey);
      // if (refreshToken != null) {
      //   try {
      //     final newToken = await _refreshToken(refreshToken);
      //     await _secureStorage.write(AppConstants.tokenKey, newToken);
      //     // Retry the original request
      //     final opts = err.requestOptions;
      //     opts.headers['Authorization'] = 'Bearer $newToken';
      //     final response = await Dio().fetch(opts);
      //     return handler.resolve(response);
      //   } catch (e) {
      //     // Refresh failed, logout user
      //     await _secureStorage.deleteAll();
      //   }
      // }
    }
    handler.next(err);
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
