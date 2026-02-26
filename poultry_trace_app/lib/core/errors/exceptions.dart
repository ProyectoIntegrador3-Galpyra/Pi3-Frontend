/// Base exception for app errors
class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalException;

  const AppException({
    required this.message,
    this.code,
    this.originalException,
  });

  @override
  String toString() => 'AppException: $message (code: $code)';
}

/// Server exception for API errors
class ServerException extends AppException {
  final int? statusCode;

  const ServerException({
    required super.message,
    super.code,
    super.originalException,
    this.statusCode,
  });
}

/// Cache exception for local storage errors
class CacheException extends AppException {
  const CacheException({
    required super.message,
    super.code,
    super.originalException,
  });
}

/// Network exception for connectivity issues
class NetworkException extends AppException {
  const NetworkException({
    super.message = 'Sin conexión a internet',
    super.code = 'NO_NETWORK',
    super.originalException,
  });
}

/// Authentication exception
class AuthException extends AppException {
  const AuthException({
    required super.message,
    super.code,
    super.originalException,
  });
}

/// Validation exception
class ValidationException extends AppException {
  final Map<String, String>? fieldErrors;

  const ValidationException({
    required super.message,
    super.code,
    super.originalException,
    this.fieldErrors,
  });
}

/// Permission exception
class PermissionException extends AppException {
  const PermissionException({
    required super.message,
    super.code = 'PERMISSION_DENIED',
    super.originalException,
  });
}

/// Not found exception
class NotFoundException extends AppException {
  const NotFoundException({
    required super.message,
    super.code = 'NOT_FOUND',
    super.originalException,
  });
}

/// Timeout exception
class TimeoutException extends AppException {
  const TimeoutException({
    super.message = 'La solicitud tardó demasiado tiempo',
    super.code = 'TIMEOUT',
    super.originalException,
  });
}
