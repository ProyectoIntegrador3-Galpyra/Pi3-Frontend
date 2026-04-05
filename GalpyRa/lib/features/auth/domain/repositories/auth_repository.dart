import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/user.dart';

/// Auth repository interface
abstract class AuthRepository {
  /// Login with email and password
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });

  /// Logout current user
  Future<Either<Failure, void>> logout();

  /// Get current user profile
  Future<Either<Failure, User>> getProfile();

  /// Check if user is logged in
  Future<bool> isLoggedIn();

  /// Get cached user
  Future<User?> getCachedUser();
}
