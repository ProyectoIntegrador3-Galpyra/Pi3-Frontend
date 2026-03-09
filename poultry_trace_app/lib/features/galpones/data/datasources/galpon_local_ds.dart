import 'dart:convert';
import '../../../../core/storage/local_db.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/galpon_model.dart';

/// Galpon local data source interface
abstract class GalponLocalDataSource {
  Future<List<GalponModel>> getCachedGalpones();
  Future<void> cacheGalpones(List<GalponModel> galpones);
  Future<GalponModel?> getCachedGalpon(String id);
  Future<void> cacheGalpon(GalponModel galpon);
  Future<void> clearCache();
}

/// Galpon local data source implementation
class GalponLocalDataSourceImpl implements GalponLocalDataSource {
  static const String _galponesKey = 'cached_galpones';

  GalponLocalDataSourceImpl();

  @override
  Future<List<GalponModel>> getCachedGalpones() async {
    try {
      final data = await LocalDb.getCachedData(_galponesKey);
      if (data != null) {
        final List<dynamic> jsonList = data is String ? jsonDecode(data) : data;
        return jsonList
            .map((json) => GalponModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      throw CacheException(
        message: 'Error al obtener galpones del cache',
        originalException: e,
      );
    }
  }

  @override
  Future<void> cacheGalpones(List<GalponModel> galpones) async {
    try {
      final jsonList = galpones.map((g) => g.toJson()).toList();
      await LocalDb.cacheData(_galponesKey, jsonList, ttlHours: 1);
    } catch (e) {
      throw CacheException(
        message: 'Error al guardar galpones en cache',
        originalException: e,
      );
    }
  }

  @override
  Future<GalponModel?> getCachedGalpon(String id) async {
    try {
      final galpones = await getCachedGalpones();
      return galpones.where((g) => g.id == id).firstOrNull;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> cacheGalpon(GalponModel galpon) async {
    try {
      final galpones = await getCachedGalpones();
      final index = galpones.indexWhere((g) => g.id == galpon.id);
      if (index >= 0) {
        galpones[index] = galpon;
      } else {
        galpones.add(galpon);
      }
      await cacheGalpones(galpones);
    } catch (e) {
      // Ignore cache errors
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await LocalDb.clearCache(_galponesKey);
    } catch (e) {
      // Ignore cache errors
    }
  }
}
