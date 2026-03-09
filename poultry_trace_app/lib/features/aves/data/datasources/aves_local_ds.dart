import '../../../../core/storage/local_db.dart';
import '../models/lote_aves_model.dart';

/// Local data source para aves (cache)
abstract class AvesLocalDataSource {
  Future<List<LoteAvesModel>> getInventarioCached(String galponId);
  Future<void> cacheInventario(String galponId, List<LoteAvesModel> lotes);
  Future<void> clearCache();
}

/// Implementación con LocalDb/SharedPreferences
class AvesLocalDataSourceImpl implements AvesLocalDataSource {
  static const String _cachePrefix = 'aves_inventario';

  AvesLocalDataSourceImpl();

  @override
  Future<List<LoteAvesModel>> getInventarioCached(String galponId) async {
    final data = await LocalDb.getCachedData('${_cachePrefix}_$galponId');
    if (data == null) return [];
    
    final list = data['items'] as List?;
    if (list == null) return [];
    
    return list
        .map((e) => LoteAvesModel.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  @override
  Future<void> cacheInventario(String galponId, List<LoteAvesModel> lotes) async {
    await LocalDb.cacheData(
      '${_cachePrefix}_$galponId',
      {
        'items': lotes.map((e) => e.toJson()).toList(),
      },
    );
  }

  @override
  Future<void> clearCache() async {
    await LocalDb.clearAllCache();
  }
}
