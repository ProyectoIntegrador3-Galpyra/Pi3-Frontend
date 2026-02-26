/// Environment configuration for the app
class Env {
  Env._();

  /// Base URL for API calls
  static const String baseUrl = 'https://api.poultrytrace.com/v1';

  /// Development base URL
  static const String devBaseUrl = 'http://localhost:3000/api/v1';

  /// Current environment
  static const bool isProduction = false;

  /// Enable debug logs
  static const bool enableLogs = true;

  /// API timeout in milliseconds
  static const int apiTimeout = 30000;

  /// Enable offline mode
  static const bool offlineModeEnabled = true;

  /// Vision API endpoint for image processing
  static const String visionApiUrl = 'https://vision.poultrytrace.com/v1';

  /// Get current base URL based on environment
  static String get currentBaseUrl => isProduction ? baseUrl : devBaseUrl;
}
