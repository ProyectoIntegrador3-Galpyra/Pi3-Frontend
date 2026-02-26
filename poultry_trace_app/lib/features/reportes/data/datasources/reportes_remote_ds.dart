import 'dart:math';
import '../../domain/entities/reporte.dart';
import '../models/reporte_model.dart';

/// Data source remoto para reportes
abstract class ReportesRemoteDataSource {
  Future<ReporteModel> generarReporte(ParametrosReporteModel parametros);
  Future<List<ReporteModel>> obtenerHistorialReportes({
    TipoReporte? tipo,
    int limit = 20,
  });
  Future<ReporteModel> obtenerReportePorId(String id);
  Future<String> exportarReporte(String reporteId, FormatoExportacion formato);
  Future<void> eliminarReporte(String id);
  Future<Map<String, dynamic>> obtenerDatosDashboard(
    DateTime fechaInicio,
    DateTime fechaFin,
  );
}

class ReportesRemoteDataSourceImpl implements ReportesRemoteDataSource {
  // TODO: Inject HttpClient for real API calls

  final List<ReporteModel> _reportesCache = [];

  @override
  Future<ReporteModel> generarReporte(ParametrosReporteModel parametros) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate processing

    final random = Random();
    final reporte = ReporteModel(
      id: 'REP-${DateTime.now().millisecondsSinceEpoch}',
      tipo: parametros.tipo,
      titulo: _getTitulo(parametros.tipo),
      descripcion: 'Reporte generado automáticamente',
      fechaInicio: parametros.fechaInicio,
      fechaFin: parametros.fechaFin,
      fechaGeneracion: DateTime.now(),
      galponId: parametros.galponId,
      datos: _generarDatosMock(parametros.tipo, random),
      resumen: _generarResumenMock(parametros.tipo, random),
      formato: parametros.formato,
    );

    _reportesCache.insert(0, reporte);
    return reporte;
  }

  @override
  Future<List<ReporteModel>> obtenerHistorialReportes({
    TipoReporte? tipo,
    int limit = 20,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (_reportesCache.isEmpty) {
      _reportesCache.addAll(_generarReportesMock());
    }

    var reportes = _reportesCache;
    if (tipo != null) {
      reportes = reportes.where((r) => r.tipo == tipo).toList();
    }

    return reportes.take(limit).toList();
  }

  @override
  Future<ReporteModel> obtenerReportePorId(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final reporte = _reportesCache.firstWhere(
      (r) => r.id == id,
      orElse: () => throw Exception('Reporte no encontrado'),
    );
    return reporte;
  }

  @override
  Future<String> exportarReporte(
    String reporteId,
    FormatoExportacion formato,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
    // TODO: Implement real export
    final extension = formato.name;
    return 'https://storage.example.com/reportes/$reporteId.$extension';
  }

  @override
  Future<void> eliminarReporte(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _reportesCache.removeWhere((r) => r.id == id);
  }

  @override
  Future<Map<String, dynamic>> obtenerDatosDashboard(
    DateTime fechaInicio,
    DateTime fechaFin,
  ) async {
    await Future.delayed(const Duration(milliseconds: 800));
    final random = Random();

    return {
      'totalAves': 12500 + random.nextInt(500),
      'produccionHuevos': {
        'total': 8500 + random.nextInt(1000),
        'promedioDiario': 280 + random.nextInt(50),
        'tendencia': random.nextDouble() * 10 - 5,
      },
      'mortalidad': {
        'total': 15 + random.nextInt(10),
        'tasa': 0.1 + random.nextDouble() * 0.1,
      },
      'alimentacion': {
        'consumoTotal': 2500 + random.nextInt(500),
        'costoPromedio': 150 + random.nextInt(50),
      },
      'sanidad': {
        'eventosRegistrados': 8 + random.nextInt(5),
        'vacunacionesPendientes': random.nextInt(3),
      },
      'galpones': {
        'total': 5,
        'activos': 5,
        'capacidadPromedio': 85 + random.nextInt(10),
      },
      'graficos': {
        'produccionSemanal': List.generate(
          7,
          (i) => {'dia': i + 1, 'cantidad': 250 + random.nextInt(100)},
        ),
        'mortalidadMensual': List.generate(
          4,
          (i) => {'semana': i + 1, 'cantidad': 3 + random.nextInt(5)},
        ),
      },
    };
  }

  String _getTitulo(TipoReporte tipo) {
    switch (tipo) {
      case TipoReporte.produccion:
        return 'Reporte de Producción de Huevos';
      case TipoReporte.mortalidad:
        return 'Reporte de Mortalidad';
      case TipoReporte.alimentacion:
        return 'Reporte de Alimentación';
      case TipoReporte.sanitario:
        return 'Reporte Sanitario';
      case TipoReporte.inventario:
        return 'Reporte de Inventario';
      case TipoReporte.financiero:
        return 'Reporte Financiero';
    }
  }

  Map<String, dynamic> _generarDatosMock(TipoReporte tipo, Random random) {
    switch (tipo) {
      case TipoReporte.produccion:
        return {
          'totalHuevos': 8500 + random.nextInt(1000),
          'huevosGrandeAA': 3000 + random.nextInt(500),
          'huevosGrandeA': 2500 + random.nextInt(500),
          'huevosMedianoA': 2000 + random.nextInt(500),
          'huevosPequeno': 1000 + random.nextInt(300),
          'tasaProduccion': 0.85 + random.nextDouble() * 0.1,
        };
      case TipoReporte.mortalidad:
        return {
          'totalMortalidad': 15 + random.nextInt(10),
          'porEnfermedad': 5 + random.nextInt(5),
          'porAccidente': 3 + random.nextInt(3),
          'porDesconocido': 2 + random.nextInt(2),
          'tasaMortalidad': 0.1 + random.nextDouble() * 0.1,
        };
      case TipoReporte.alimentacion:
        return {
          'consumoTotal': 2500 + random.nextInt(500),
          'costoTotal': 7500 + random.nextInt(1500),
          'consumoPromedioDiario': 350 + random.nextInt(50),
          'conversionAlimenticia': 1.8 + random.nextDouble() * 0.5,
        };
      case TipoReporte.sanitario:
        return {
          'vacunacionesRealizadas': 3 + random.nextInt(3),
          'tratamientosAplicados': 2 + random.nextInt(2),
          'inspeccionesRealizadas': 5 + random.nextInt(5),
        };
      case TipoReporte.inventario:
        return {
          'totalAves': 12500 + random.nextInt(500),
          'ingresos': 500 + random.nextInt(200),
          'bajas': 15 + random.nextInt(10),
          'diferencia': random.nextInt(50) - 25,
        };
      case TipoReporte.financiero:
        return {
          'ingresos': 45000 + random.nextInt(10000),
          'gastos': 25000 + random.nextInt(5000),
          'utilidad': 20000 + random.nextInt(5000),
          'margen': 0.4 + random.nextDouble() * 0.1,
        };
    }
  }

  Map<String, dynamic> _generarResumenMock(TipoReporte tipo, Random random) {
    return {
      'indicadorPrincipal': '${85 + random.nextInt(10)}%',
      'tendencia': random.nextBool() ? 'positiva' : 'estable',
      'alertas': random.nextInt(3),
    };
  }

  List<ReporteModel> _generarReportesMock() {
    final random = Random();
    final tipos = TipoReporte.values;

    return List.generate(10, (index) {
      final tipo = tipos[index % tipos.length];
      final fechaGen = DateTime.now().subtract(Duration(days: index * 3));
      return ReporteModel(
        id: 'REP-MOCK-${1000 + index}',
        tipo: tipo,
        titulo: _getTitulo(tipo),
        descripcion: 'Reporte histórico generado',
        fechaInicio: fechaGen.subtract(const Duration(days: 7)),
        fechaFin: fechaGen,
        fechaGeneracion: fechaGen,
        datos: _generarDatosMock(tipo, random),
        resumen: _generarResumenMock(tipo, random),
      );
    });
  }
}
