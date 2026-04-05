import '../storage/local_db.dart';

/// Manager for caching API responses
class CacheManager {
  CacheManager();

  /// Cache keys
  static const String galponesKey = 'galpones_list';
  static const String avesInventoryKey = 'aves_inventory';
  static const String produccionKey = 'produccion';
  static const String sanidadKey = 'sanidad';
  static const String alimentacionKey = 'alimentacion';
  static const String reportesKey = 'reportes';

  /// Default cache duration
  static const Duration defaultCacheDuration = Duration(hours: 1);

  /// Cache API response
  Future<void> cacheResponse(
    String key,
    dynamic data, {
    Duration? duration,
  }) async {
    final ttlHours = (duration ?? defaultCacheDuration).inHours;
    await LocalDb.cacheData(key, data, ttlHours: ttlHours > 0 ? ttlHours : 1);
  }

  /// Get cached response
  Future<dynamic> getCachedResponse(String key) async {
    return await LocalDb.getCachedData(key);
  }

  /// Check if cache is valid
  Future<bool> isCacheValid(String key) async {
    return await LocalDb.isCacheValid(key);
  }

  /// Invalidate specific cache
  Future<void> invalidateCache(String key) async {
    await LocalDb.clearCache(key);
  }

  /// Invalidate all caches
  Future<void> invalidateAll() async {
    await LocalDb.clearAllCache();
  }

  /// Cache galpones list
  Future<void> cacheGalpones(List<Map<String, dynamic>> galpones) async {
    await cacheResponse(galponesKey, galpones);
  }

  /// Get cached galpones
  Future<List<Map<String, dynamic>>?> getCachedGalpones() async {
    final data = await getCachedResponse(galponesKey);
    if (data != null) {
      return List<Map<String, dynamic>>.from(data);
    }
    return null;
  }

  /// Generate cache key with parameters
  String generateKey(String baseKey, Map<String, dynamic>? params) {
    if (params == null || params.isEmpty) {
      return baseKey;
    }
    final sortedParams = params.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    final paramString = sortedParams
        .map((e) => '${e.key}=${e.value}')
        .join('&');
    return '$baseKey?$paramString';
  }
}
