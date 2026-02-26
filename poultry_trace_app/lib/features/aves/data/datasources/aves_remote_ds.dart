import '../models/lote_aves_model.dart';

/// Remote data source para aves
abstract class AvesRemoteDataSource {
  Future<List<LoteAvesModel>> consultarInventario(String galponId);
  Future<void> registrarMortalidad({
    required String galponId,
    required int cantidad,
    required String causa,
    required DateTime fecha,
    String? observaciones,
  });
  Future<LoteAvesModel> registrarIngreso({
    required String galponId,
    required String raza,
    required int cantidad,
    required DateTime fechaIngreso,
    int? edadSemanas,
    double? pesoPromedio,
    String? observaciones,
  });
}

/// Implementación del data source remoto
class AvesRemoteDataSourceImpl implements AvesRemoteDataSource {
  // TODO: Inject HttpClient when API is ready
  // final HttpClient _client;
  // AvesRemoteDataSourceImpl(this._client);

  AvesRemoteDataSourceImpl();

  @override
  Future<List<LoteAvesModel>> consultarInventario(String galponId) async {
    // TODO: Implement API call
    // final response = await _client.get('/aves/inventario/$galponId');
    // return (response.data as List).map((e) => LoteAvesModel.fromJson(e)).toList();
    
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      LoteAvesModel(
        id: '1',
        galponId: galponId,
        raza: 'Hy-Line Brown',
        cantidad: 5000,
        fechaIngreso: DateTime(2024, 1, 15),
        edadSemanas: 22,
        pesoPromedio: 1.85,
        observaciones: 'Lote en producción',
        createdAt: DateTime(2024, 1, 15),
      ),
      LoteAvesModel(
        id: '2',
        galponId: galponId,
        raza: 'Lohmann LSL',
        cantidad: 3500,
        fechaIngreso: DateTime(2024, 2, 1),
        edadSemanas: 18,
        pesoPromedio: 1.72,
        observaciones: 'Lote reciente',
        createdAt: DateTime(2024, 2, 1),
      ),
    ];
  }

  @override
  Future<void> registrarMortalidad({
    required String galponId,
    required int cantidad,
    required String causa,
    required DateTime fecha,
    String? observaciones,
  }) async {
    // TODO: Implement API call
    // await _client.post('/aves/mortalidad', data: {...});
    
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<LoteAvesModel> registrarIngreso({
    required String galponId,
    required String raza,
    required int cantidad,
    required DateTime fechaIngreso,
    int? edadSemanas,
    double? pesoPromedio,
    String? observaciones,
  }) async {
    // TODO: Implement API call
    // final response = await _client.post('/aves/ingreso', data: {...});
    // return LoteAvesModel.fromJson(response.data);
    
    await Future.delayed(const Duration(milliseconds: 500));
    return LoteAvesModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      galponId: galponId,
      raza: raza,
      cantidad: cantidad,
      fechaIngreso: fechaIngreso,
      edadSemanas: edadSemanas ?? 0,
      pesoPromedio: pesoPromedio,
      observaciones: observaciones,
      createdAt: DateTime.now(),
    );
  }
}
