import 'package:hive/hive.dart';
import '../models/lote_aves_model.dart';

/// Local data source para aves (cache)
abstract class AvesLocalDataSource {
  Future<List<LoteAvesModel>> getInventarioCached(String galponId);
  Future<void> cacheInventario(String galponId, List<LoteAvesModel> lotes);
  Future<void> clearCache();
}

/// Implementación con Hive
class AvesLocalDataSourceImpl implements AvesLocalDataSource {
  static const String _boxName = 'aves_cache';

  @override
  Future<List<LoteAvesModel>> getInventarioCached(String galponId) async {
    final box = await Hive.openBox<Map>(_boxName);
    final data = box.get('inventario_$galponId');
    if (data == null) return [];
    
    final list = data['items'] as List?;
    if (list == null) return [];
    
    return list
        .map((e) => LoteAvesModel.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  @override
  Future<void> cacheInventario(String galponId, List<LoteAvesModel> lotes) async {
    final box = await Hive.openBox<Map>(_boxName);
    await box.put('inventario_$galponId', {
      'items': lotes.map((e) => e.toJson()).toList(),
      'cached_at': DateTime.now().toIso8601String(),
    });
  }

  @override
  Future<void> clearCache() async {
    final box = await Hive.openBox<Map>(_boxName);
    await box.clear();
  }
}
