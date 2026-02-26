import '../../domain/entities/registro_alimentacion.dart';
import '../models/registro_alimentacion_model.dart';

/// Remote data source para alimentación
abstract class AlimentacionRemoteDataSource {
  Future<List<RegistroAlimentacionModel>> obtenerHistorial(
    String galponId, {
    DateTime? desde,
    DateTime? hasta,
  });

  Future<RegistroAlimentacionModel> registrarAlimentacion({
    required String galponId,
    required DateTime fecha,
    required TipoAlimento tipoAlimento,
    required String nombreAlimento,
    required double cantidadKg,
    double? costoUnitario,
    int? numeroAves,
    String? loteAlimento,
    String? proveedor,
    String? observaciones,
  });

  Future<Map<String, dynamic>> obtenerConsumoPromedio(
    String galponId, {
    required DateTime desde,
    required DateTime hasta,
  });

  Future<Map<String, double>> obtenerInventarioAlimentos();
}

/// Implementación del data source remoto
class AlimentacionRemoteDataSourceImpl implements AlimentacionRemoteDataSource {
  // TODO: Inject HttpClient when API is ready

  AlimentacionRemoteDataSourceImpl();

  @override
  Future<List<RegistroAlimentacionModel>> obtenerHistorial(
    String galponId, {
    DateTime? desde,
    DateTime? hasta,
  }) async {
    // TODO: Implement API call
    await Future.delayed(const Duration(milliseconds: 500));

    final now = DateTime.now();
    return List.generate(7, (index) {
      final fecha = now.subtract(Duration(days: index));
      return RegistroAlimentacionModel(
        id: 'alim_$index',
        galponId: galponId,
        fecha: fecha,
        tipoAlimento: TipoAlimento.concentrado,
        nombreAlimento: 'Concentrado Ponedoras Fase 2',
        cantidadKg: 250.0 + (index * 5),
        costoUnitario: 1.25,
        numeroAves: 5000,
        consumoPorAve: (250.0 + (index * 5)) / 5000,
        loteAlimento: 'LOT-2024-001',
        proveedor: 'Nutriaves S.A.',
        observaciones: index == 0 ? 'Consumo normal' : null,
        createdAt: fecha,
      );
    });
  }

  @override
  Future<RegistroAlimentacionModel> registrarAlimentacion({
    required String galponId,
    required DateTime fecha,
    required TipoAlimento tipoAlimento,
    required String nombreAlimento,
    required double cantidadKg,
    double? costoUnitario,
    int? numeroAves,
    String? loteAlimento,
    String? proveedor,
    String? observaciones,
  }) async {
    // TODO: Implement API call
    await Future.delayed(const Duration(milliseconds: 500));

    return RegistroAlimentacionModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      galponId: galponId,
      fecha: fecha,
      tipoAlimento: tipoAlimento,
      nombreAlimento: nombreAlimento,
      cantidadKg: cantidadKg,
      costoUnitario: costoUnitario,
      numeroAves: numeroAves,
      consumoPorAve: numeroAves != null ? cantidadKg / numeroAves : null,
      loteAlimento: loteAlimento,
      proveedor: proveedor,
      observaciones: observaciones,
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<Map<String, dynamic>> obtenerConsumoPromedio(
    String galponId, {
    required DateTime desde,
    required DateTime hasta,
  }) async {
    // TODO: Implement API call
    await Future.delayed(const Duration(milliseconds: 300));

    return {
      'consumo_total_kg': 1750.0,
      'promedio_diario_kg': 250.0,
      'consumo_por_ave_g': 50.0,
      'costo_total': 2187.50,
      'costo_por_ave': 0.44,
    };
  }

  @override
  Future<Map<String, double>> obtenerInventarioAlimentos() async {
    // TODO: Implement API call
    await Future.delayed(const Duration(milliseconds: 300));

    return {
      'Concentrado Ponedoras Fase 1': 500.0,
      'Concentrado Ponedoras Fase 2': 1200.0,
      'Maíz molido': 800.0,
      'Vitaminas ADE': 25.0,
    };
  }
}
