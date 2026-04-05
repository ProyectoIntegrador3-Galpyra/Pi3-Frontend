import 'package:dio/dio.dart';

import '../errors/exceptions.dart';

/// Helper to parse the backend envelope: success/message/data/status_code/error.
class ApiResponseParser {
  ApiResponseParser._();

  static Map<String, dynamic> asMap(dynamic value) {
    if (value is Map<String, dynamic>) {
      return value;
    }
    if (value is Map) {
      return value.map((key, dynamic val) => MapEntry(key.toString(), val));
    }
    return <String, dynamic>{};
  }

  static bool isSuccess(dynamic body) {
    final map = asMap(body);
    final success = map['success'];
    if (success is bool) {
      return success;
    }
    return true;
  }

  static String extractMessage(dynamic body, {String fallback = 'Operacion completada'}) {
    final map = asMap(body);
    final message = map['message'];
    if (message is String && message.trim().isNotEmpty) {
      return message;
    }

    final error = map['error'];
    if (error is Map) {
      final errorMessage = error['message'];
      if (errorMessage is String && errorMessage.trim().isNotEmpty) {
        return errorMessage;
      }
    }

    return fallback;
  }

  static int? extractStatusCode(dynamic body) {
    final map = asMap(body);
    final value = map['status_code'];
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    if (value is String) {
      return int.tryParse(value);
    }
    return null;
  }

  static Map<String, dynamic> extractDataMap(
    dynamic body, {
    bool allowBodyAsData = true,
  }) {
    final map = asMap(body);
    final data = map['data'];
    if (data is Map<String, dynamic>) {
      return data;
    }
    if (data is Map) {
      return asMap(data);
    }
    return allowBodyAsData ? map : <String, dynamic>{};
  }

  static List<dynamic> extractDataList(dynamic body) {
    final map = asMap(body);
    final data = map['data'];
    if (data is List) {
      return data;
    }
    return <dynamic>[];
  }

  static ServerException toServerException(
    DioException exception, {
    String fallbackMessage = 'Error de servidor',
  }) {
    if (exception.type == DioExceptionType.connectionTimeout ||
        exception.type == DioExceptionType.sendTimeout ||
        exception.type == DioExceptionType.receiveTimeout) {
      return ServerException(
        message: 'Tiempo de espera agotado al conectar con el servidor',
        statusCode: exception.response?.statusCode,
        originalException: exception,
      );
    }

    if (exception.type == DioExceptionType.connectionError ||
        exception.response == null) {
      return ServerException(
        message: 'No se pudo conectar con el servidor. Verifica la URL del API y que el backend este activo.',
        statusCode: exception.response?.statusCode,
        originalException: exception,
      );
    }

    final body = exception.response?.data;
    return ServerException(
      message: extractMessage(body, fallback: fallbackMessage),
      statusCode: exception.response?.statusCode,
      originalException: exception,
    );
  }
}
