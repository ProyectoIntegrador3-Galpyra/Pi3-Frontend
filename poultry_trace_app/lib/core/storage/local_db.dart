import 'package:hive_flutter/hive_flutter.dart';

/// Local database service using Hive
class LocalDb {
  static const String _settingsBox = 'settings';
  static const String _cacheBox = 'cache';
  static const String _syncQueueBox = 'sync_queue';

  static late Box _settings;
  static late Box _cache;
  static late Box _syncQueue;

  /// Initialize all Hive boxes
  static Future<void> init() async {
    _settings = await Hive.openBox(_settingsBox);
    _cache = await Hive.openBox(_cacheBox);
    _syncQueue = await Hive.openBox(_syncQueueBox);
  }

  // ========== Settings Operations ==========

  /// Get a setting value
  Future<T?> getSetting<T>(String key, {T? defaultValue}) async {
    return _settings.get(key, defaultValue: defaultValue);
  }

  /// Set a setting value
  Future<void> setSetting<T>(String key, T value) async {
    await _settings.put(key, value);
  }

  /// Remove a setting
  Future<void> removeSetting(String key) async {
    await _settings.delete(key);
  }

  // ========== Cache Operations ==========

  /// Cache data with optional expiration
  Future<void> cacheData(
    String key,
    dynamic data, {
    Duration? expiration,
  }) async {
    final cacheEntry = {
      'data': data,
      'cachedAt': DateTime.now().toIso8601String(),
      'expiresAt': expiration != null
          ? DateTime.now().add(expiration).toIso8601String()
          : null,
    };
    await _cache.put(key, cacheEntry);
  }

  /// Get cached data
  Future<dynamic> getCachedData(String key) async {
    final entry = _cache.get(key);
    if (entry == null) return null;

    final expiresAt = entry['expiresAt'];
    if (expiresAt != null) {
      final expiration = DateTime.parse(expiresAt);
      if (DateTime.now().isAfter(expiration)) {
        await _cache.delete(key);
        return null;
      }
    }

    return entry['data'];
  }

  /// Check if cache exists and is valid
  Future<bool> isCacheValid(String key) async {
    final data = await getCachedData(key);
    return data != null;
  }

  /// Clear specific cache
  Future<void> clearCache(String key) async {
    await _cache.delete(key);
  }

  /// Clear all cache
  Future<void> clearAllCache() async {
    await _cache.clear();
  }

  // ========== Sync Queue Operations ==========

  /// Add item to sync queue
  Future<void> addToSyncQueue(String id, Map<String, dynamic> data) async {
    await _syncQueue.put(id, data);
  }

  /// Get all items in sync queue
  Future<List<Map<String, dynamic>>> getSyncQueue() async {
    return _syncQueue.values.cast<Map<String, dynamic>>().toList();
  }

  /// Remove item from sync queue
  Future<void> removeFromSyncQueue(String id) async {
    await _syncQueue.delete(id);
  }

  /// Clear sync queue
  Future<void> clearSyncQueue() async {
    await _syncQueue.clear();
  }

  /// Get sync queue count
  int getSyncQueueCount() {
    return _syncQueue.length;
  }

  // ========== Box Management ==========

  /// Close all boxes
  Future<void> closeAll() async {
    await _settings.close();
    await _cache.close();
    await _syncQueue.close();
  }

  /// Clear all data
  Future<void> clearAll() async {
    await _settings.clear();
    await _cache.clear();
    await _syncQueue.clear();
  }
}
