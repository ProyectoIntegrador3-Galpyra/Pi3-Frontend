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

  /// Send password recovery email
  Future<Either<Failure, void>> forgotPassword({required String email});

  /// Reset password with deep-link token
  Future<Either<Failure, void>> resetPassword({
    required String token,
    required String nuevaPassword,
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
