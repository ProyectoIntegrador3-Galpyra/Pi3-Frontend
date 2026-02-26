import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Get profile use case
class GetProfileUseCase {
  final AuthRepository _repository;

  GetProfileUseCase(this._repository);

  Future<Either<Failure, User>> call() {
    return _repository.getProfile();
  }
}
