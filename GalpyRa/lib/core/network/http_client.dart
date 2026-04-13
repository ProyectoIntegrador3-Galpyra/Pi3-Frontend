import 'dart:typed_data';
import 'package:dio/dio.dart';
import '../../config/env.dart';
import 'interceptors.dart';
import '../storage/secure_storage.dart';

/// HTTP Client using Dio
class HttpClient {
  late final Dio _dio;
  final SecureStorage _secureStorage;

  HttpClient(this._secureStorage) {
    _dio = Dio(
      BaseOptions(
        baseUrl: Env.currentBaseUrl,
        connectTimeout: Duration(milliseconds: Env.apiTimeout),
        receiveTimeout: Duration(milliseconds: Env.apiTimeout),
        sendTimeout: Duration(milliseconds: Env.apiTimeout),
        headers: {
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.addAll([
      AuthInterceptor(_secureStorage, _dio),
      RetryInterceptor(dio: _dio),
      LoggingInterceptor(),
    ]);
  }

  Dio get dio => _dio;

  /// GET request
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  /// POST request
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  /// PUT request
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  /// PATCH request
  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _dio.patch<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  /// DELETE request
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  /// Upload file with multipart (mobile/desktop — uses dart:io)
  Future<Response<T>> uploadFile<T>(
    String path, {
    required String filePath,
    required String fieldName,
    Map<String, dynamic>? extraData,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
  }) async {
    final formData = FormData.fromMap({
      fieldName: await MultipartFile.fromFile(filePath),
      ...?extraData,
    });

    return _dio.post<T>(
      path,
      data: formData,
      options: Options(contentType: Headers.multipartFormDataContentType),
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
    );
  }

  /// Upload file from bytes (web-compatible)
  Future<Response<T>> uploadFileBytes<T>(
    String path, {
    required Uint8List bytes,
    required String filename,
    required String fieldName,
    Map<String, dynamic>? extraData,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
  }) async {
    final formData = FormData.fromMap({
      fieldName: MultipartFile.fromBytes(bytes, filename: filename),
      ...?extraData,
    });

    return _dio.post<T>(
      path,
      data: formData,
      options: Options(contentType: Headers.multipartFormDataContentType),
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
    );
  }
}
