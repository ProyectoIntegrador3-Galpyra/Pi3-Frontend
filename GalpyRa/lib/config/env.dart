import 'package:flutter/foundation.dart';

/// Environment configuration for the app
class Env {
  Env._();

  /// Optional override for API URL passed with:
  /// --dart-define=API_BASE_URL_OVERRIDE=https://your-api
  static const String apiBaseUrlOverride =
      String.fromEnvironment('API_BASE_URL_OVERRIDE', defaultValue: '');

  /// Base URL for API calls
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://galpyra-1776052294.us-east-2.elasticbeanstalk.com',
  );

  /// Development base URL
  static const String devBaseUrl = String.fromEnvironment(
    'API_DEV_BASE_URL',
    defaultValue: 'http://galpyra-1776052294.us-east-2.elasticbeanstalk.com',
  );

  /// Current environment
  static bool get isProduction =>
      const bool.fromEnvironment('APP_PRODUCTION', defaultValue: false) ||
      kReleaseMode;

  /// Enable debug logs
  static const bool enableLogs = true;

  /// API timeout in milliseconds
  static const int apiTimeout = 30000;

  /// Enable offline mode
  static const bool offlineModeEnabled = true;

  /// Vision API endpoint for image processing
  static const String visionApiUrl = 'https://vision.poultrytrace.com/v1';

  /// Get current base URL based on environment
  static String get currentBaseUrl {
    if (apiBaseUrlOverride.isNotEmpty) {
      return apiBaseUrlOverride;
    }
    return isProduction ? baseUrl : devBaseUrl;
  }
}
