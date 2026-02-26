import 'package:equatable/equatable.dart';

/// Base failure class for error handling with Either
abstract class Failure extends Equatable {
  final String message;
  final String? code;

  const Failure({
    required this.message,
    this.code,
  });

  @override
  List<Object?> get props => [message, code];
}

/// Server failure for API errors
class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure({
    required super.message,
    super.code,
    this.statusCode,
  });

  @override
  List<Object?> get props => [message, code, statusCode];
}

/// Cache failure for local storage errors
class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    super.code,
  });
}

/// Network failure for connectivity issues
class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'Sin conexión a internet',
    super.code = 'NO_NETWORK',
  });
}

/// Authentication failure
class AuthFailure extends Failure {
  const AuthFailure({
    required super.message,
    super.code,
  });
}

/// Validation failure
class ValidationFailure extends Failure {
  final Map<String, String>? fieldErrors;

  const ValidationFailure({
    required super.message,
    super.code,
    this.fieldErrors,
  });

  @override
  List<Object?> get props => [message, code, fieldErrors];
}

/// Permission failure
class PermissionFailure extends Failure {
  const PermissionFailure({
    required super.message,
    super.code = 'PERMISSION_DENIED',
  });
}

/// Not found failure
class NotFoundFailure extends Failure {
  const NotFoundFailure({
    required super.message,
    super.code = 'NOT_FOUND',
  });
}

/// Unknown failure
class UnknownFailure extends Failure {
  const UnknownFailure({
    super.message = 'Ha ocurrido un error inesperado',
    super.code = 'UNKNOWN',
  });
}

/// Unexpected failure (alias for UnknownFailure)
class UnexpectedFailure extends Failure {
  const UnexpectedFailure({
    super.message = 'Ha ocurrido un error inesperado',
    super.code = 'UNEXPECTED',
  });
}
