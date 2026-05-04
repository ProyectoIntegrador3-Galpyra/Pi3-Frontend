import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../repositories/auth_repository.dart';

/// Reset password use case
class ResetPasswordUseCase {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String token,
    required String nuevaPassword,
  }) {
    return repository.resetPassword(
      token: token,
      nuevaPassword: nuevaPassword,
    );
  }
}
