import 'dart:convert';
import 'database/app_database.dart';
import 'database/daos/galpones_dao.dart';
import 'database/daos/produccion_dao.dart';
import 'database/daos/sanidad_dao.dart';
import 'database/daos/sync_queue_dao.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Local database service using Drift/SQLite
class LocalDb {
  static AppDatabase? _database;
  static SharedPreferences? _prefs;
  
  // DAOs
  static GalponesDao? _galponesDao;
  static ProduccionDao? _produccionDao;
  static SanidadDao? _sanidadDao;
  static SyncQueueDao? _syncQueueDao;

  // Cache duration in hours
  static const int _cacheDurationHours = 24;

  /// Initialize database
  static Future<void> init() async {
    _database = AppDatabase();
    _prefs = await SharedPreferences.getInstance();
    _galponesDao = GalponesDao(_database!);
    _produccionDao = ProduccionDao(_database!);
    _sanidadDao = SanidadDao(_database!);
    _syncQueueDao = SyncQueueDao(_database!);
  }

  /// Get database instance
  static AppDatabase get database {
    if (_database == null) {
      throw Exception('Database not initialized. Call LocalDb.init() first.');
    }
    return _database!;
  }

  /// Get Galpones DAO
  static GalponesDao get galponesDao {
    if (_galponesDao == null) {
      throw Exception('Database not initialized. Call LocalDb.init() first.');
    }
    return _galponesDao!;
  }

  /// Get Produccion DAO
  static ProduccionDao get produccionDao {
    if (_produccionDao == null) {
      throw Exception('Database not initialized. Call LocalDb.init() first.');
    }
    return _produccionDao!;
  }

  /// Get Sanidad DAO
  static SanidadDao get sanidadDao {
    if (_sanidadDao == null) {
      throw Exception('Database not initialized. Call LocalDb.init() first.');
    }
    return _sanidadDao!;
  }

  /// Get SyncQueue DAO
  static SyncQueueDao get syncQueueDao {
    if (_syncQueueDao == null) {
      throw Exception('Database not initialized. Call LocalDb.init() first.');
    }
    return _syncQueueDao!;
  }

  // ========== CACHE METHODS ==========
  
  /// Cache data with optional TTL
  static Future<void> cacheData(String key, dynamic data, {int? ttlHours}) async {
    _ensurePrefs();
    final cacheEntry = {
      'data': data,
      'cached_at': DateTime.now().toIso8601String(),
      'ttl_hours': ttlHours ?? _cacheDurationHours,
    };
    await _prefs!.setString('cache_$key', jsonEncode(cacheEntry));
  }
  
  /// Get cached data
  static Future<dynamic> getCachedData(String key) async {
    _ensurePrefs();
    final cached = _prefs!.getString('cache_$key');
    if (cached == null) return null;
    
    try {
      final entry = jsonDecode(cached) as Map<String, dynamic>;
      return entry['data'];
    } catch (e) {
      return null;
    }
  }
  
  /// Check if cache is still valid
  static Future<bool> isCacheValid(String key) async {
    _ensurePrefs();
    final cached = _prefs!.getString('cache_$key');
    if (cached == null) return false;
    
    try {
      final entry = jsonDecode(cached) as Map<String, dynamic>;
      final cachedAt = DateTime.parse(entry['cached_at'] as String);
      final ttlHours = entry['ttl_hours'] as int? ?? _cacheDurationHours;
      final expiresAt = cachedAt.add(Duration(hours: ttlHours));
      return DateTime.now().isBefore(expiresAt);
    } catch (e) {
      return false;
    }
  }
  
  /// Clear specific cache
  static Future<void> clearCache(String key) async {
    _ensurePrefs();
    await _prefs!.remove('cache_$key');
  }
  
  /// Clear all cache
  static Future<void> clearAllCache() async {
    _ensurePrefs();
    final keys = _prefs!.getKeys().where((k) => k.startsWith('cache_')).toList();
    for (final key in keys) {
      await _prefs!.remove(key);
    }
  }

  // ========== SETTINGS METHODS ==========
  
  /// Set setting value
  static Future<void> setSetting<T>(String key, T value) async {
    _ensurePrefs();
    if (value is String) {
      await _prefs!.setString('setting_$key', value);
    } else if (value is int) {
      await _prefs!.setInt('setting_$key', value);
    } else if (value is double) {
      await _prefs!.setDouble('setting_$key', value);
    } else if (value is bool) {
      await _prefs!.setBool('setting_$key', value);
    } else {
      await _prefs!.setString('setting_$key', jsonEncode(value));
    }
  }
  
  /// Get setting value
  static Future<T?> getSetting<T>(String key) async {
    _ensurePrefs();
    final value = _prefs!.get('setting_$key');
    if (value == null) return null;
    
    if (T == String && value is String) {
      return value as T;
    }
    return value as T?;
  }
  
  /// Remove setting
  static Future<void> removeSetting(String key) async {
    _ensurePrefs();
    await _prefs!.remove('setting_$key');
  }

  // ========== UTILITY ==========
  
  static void _ensurePrefs() {
    if (_prefs == null) {
      throw Exception('Database not initialized. Call LocalDb.init() first.');
    }
  }

  /// Close database
  static Future<void> close() async {
    await _database?.close();
    _database = null;
    _galponesDao = null;
    _produccionDao = null;
    _sanidadDao = null;
    _syncQueueDao = null;
    _prefs = null;
  }

  /// Check if database is initialized
  static bool get isInitialized => _database != null && _prefs != null;
}
