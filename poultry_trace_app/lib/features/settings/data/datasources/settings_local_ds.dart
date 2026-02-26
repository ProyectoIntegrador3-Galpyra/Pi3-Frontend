import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_settings_model.dart';

/// Data source local para configuraciones
abstract class SettingsLocalDataSource {
  Future<AppSettingsModel> obtenerSettings();
  Future<void> guardarSettings(AppSettingsModel settings);
  Future<T?> obtenerValor<T>(String key);
  Future<void> guardarValor<T>(String key, T value);
  Future<void> eliminarValor(String key);
  Future<void> limpiarTodo();
  Future<String> exportarSettings();
  Future<AppSettingsModel> importarSettings(String data);
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  static const String _settingsKey = 'app_settings';

  SharedPreferences? _prefs;

  Future<SharedPreferences> get _prefsInstance async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  @override
  Future<AppSettingsModel> obtenerSettings() async {
    final prefs = await _prefsInstance;
    final jsonString = prefs.getString(_settingsKey);

    if (jsonString == null) {
      return const AppSettingsModel();
    }

    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return AppSettingsModel.fromJson(json);
    } catch (e) {
      return const AppSettingsModel();
    }
  }

  @override
  Future<void> guardarSettings(AppSettingsModel settings) async {
    final prefs = await _prefsInstance;
    final jsonString = jsonEncode(settings.toJson());
    await prefs.setString(_settingsKey, jsonString);
  }

  @override
  Future<T?> obtenerValor<T>(String key) async {
    final prefs = await _prefsInstance;

    if (T == String) {
      return prefs.getString(key) as T?;
    } else if (T == int) {
      return prefs.getInt(key) as T?;
    } else if (T == double) {
      return prefs.getDouble(key) as T?;
    } else if (T == bool) {
      return prefs.getBool(key) as T?;
    } else if (T == List<String>) {
      return prefs.getStringList(key) as T?;
    }

    return null;
  }

  @override
  Future<void> guardarValor<T>(String key, T value) async {
    final prefs = await _prefsInstance;

    if (value is String) {
      await prefs.setString(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key, value);
    }
  }

  @override
  Future<void> eliminarValor(String key) async {
    final prefs = await _prefsInstance;
    await prefs.remove(key);
  }

  @override
  Future<void> limpiarTodo() async {
    final prefs = await _prefsInstance;
    await prefs.clear();
  }

  @override
  Future<String> exportarSettings() async {
    final settings = await obtenerSettings();
    return jsonEncode(settings.toJson());
  }

  @override
  Future<AppSettingsModel> importarSettings(String data) async {
    final json = jsonDecode(data) as Map<String, dynamic>;
    final settings = AppSettingsModel.fromJson(json);
    await guardarSettings(settings);
    return settings;
  }
}
