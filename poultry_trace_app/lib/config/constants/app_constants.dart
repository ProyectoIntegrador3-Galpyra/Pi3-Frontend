/// Application constants
class AppConstants {
  AppConstants._();

  /// App name
  static const String appName = 'Poultry Trace';

  /// App version
  static const String appVersion = '1.0.0';

  /// Default page size for pagination
  static const int defaultPageSize = 20;

  /// Cache duration in hours
  static const int cacheDurationHours = 24;

  /// Max image size for upload (in bytes)
  static const int maxImageSize = 10 * 1024 * 1024; // 10MB

  /// Supported image formats
  static const List<String> supportedImageFormats = ['jpg', 'jpeg', 'png'];

  /// Animation duration
  static const Duration animationDuration = Duration(milliseconds: 300);

  /// Debounce duration for search
  static const Duration debounceDuration = Duration(milliseconds: 500);

  /// Storage keys
  static const String tokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userKey = 'user_data';
  static const String themeKey = 'theme_mode';
  static const String localeKey = 'locale';
  static const String onboardingKey = 'onboarding_completed';
}
