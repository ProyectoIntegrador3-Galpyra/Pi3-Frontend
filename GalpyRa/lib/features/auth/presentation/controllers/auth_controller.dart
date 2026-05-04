import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/di/injector.dart';
import '../../../../config/constants/app_constants.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/failure_message_mapper.dart';
import '../../../../core/storage/secure_storage.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/forgot_password.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/reset_password.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/usecases/get_profile.dart';

/// Auth state
class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final User? user;
  final String? error;

  const AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.user,
    this.error,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    User? user,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
      error: error,
    );
  }
}

/// Auth controller notifier
class AuthController extends StateNotifier<AuthState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetProfileUseCase _getProfileUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  AuthController({
    required LoginUseCase loginUseCase,
    required LogoutUseCase logoutUseCase,
    required GetProfileUseCase getProfileUseCase,
    required ForgotPasswordUseCase forgotPasswordUseCase,
    required ResetPasswordUseCase resetPasswordUseCase,
  })  : _loginUseCase = loginUseCase,
        _logoutUseCase = logoutUseCase,
        _getProfileUseCase = getProfileUseCase,
        _forgotPasswordUseCase = forgotPasswordUseCase,
        _resetPasswordUseCase = resetPasswordUseCase,
        super(const AuthState());

  /// Login with email and password
  Future<bool> login(String email, String password) async {
    if (state.isLoading) return false;

    state = state.copyWith(isLoading: true, error: null);

    final result = await _loginUseCase(email: email, password: password);

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: mapFailureMessage(failure),
        );
        return false;
      },
      (user) {
        state = state.copyWith(
          isLoading: false,
          isAuthenticated: true,
          user: user,
        );
        return true;
      },
    );
  }

  /// Logout current user
  Future<void> logout() async {
    state = state.copyWith(isLoading: true);

    await _logoutUseCase();

    state = const AuthState();
  }

  /// Get current user profile
  Future<void> getProfile() async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _getProfileUseCase();

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: mapFailureMessage(failure),
        );
      },
      (user) {
        state = state.copyWith(
          isLoading: false,
          isAuthenticated: true,
          user: user,
        );
      },
    );
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// Send password recovery email
  Future<bool> requestPasswordReset(String email) async {
    if (state.isLoading) return false;

    state = state.copyWith(isLoading: true, error: null);

    final result = await _forgotPasswordUseCase(email: email);

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: mapFailureMessage(failure),
        );
        return false;
      },
      (_) {
        state = state.copyWith(isLoading: false, error: null);
        return true;
      },
    );
  }

  /// Reset password using the token from the deep link
  Future<void> resetPassword({
    required String token,
    required String nuevaPassword,
  }) async {
    final result = await _resetPasswordUseCase(
      token: token,
      nuevaPassword: nuevaPassword,
    );

    result.fold(
      (failure) {
        throw Exception(_resetPasswordMessage(failure));
      },
      (_) {},
    );
  }

  String _resetPasswordMessage(Failure failure) {
    if (failure is ServerFailure &&
        (failure.statusCode == 400 || failure.statusCode == 410)) {
      return 'El enlace expiró o ya fue usado. Solicita uno nuevo desde la app.';
    }

    final message = mapFailureMessage(failure).trim();
    if (message.isNotEmpty) {
      return message;
    }

    return 'El enlace expiró o ya fue usado. Solicita uno nuevo desde la app.';
  }
}

/// Auth controller provider
final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(
    loginUseCase: getIt<LoginUseCase>(),
    logoutUseCase: getIt<LogoutUseCase>(),
    getProfileUseCase: getIt<GetProfileUseCase>(),
    forgotPasswordUseCase: getIt<ForgotPasswordUseCase>(),
    resetPasswordUseCase: getIt<ResetPasswordUseCase>(),
  );
});

final userRoleProvider = FutureProvider<String?>((ref) async {
  return getIt<SecureStorage>().read(AppConstants.userRoleKey);
});
