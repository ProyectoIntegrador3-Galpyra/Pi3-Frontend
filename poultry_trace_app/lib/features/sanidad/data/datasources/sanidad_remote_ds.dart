import '../../domain/entities/registro_sanitario.dart';
import '../models/registro_sanitario_model.dart';

/// Remote data source para sanidad
abstract class SanidadRemoteDataSource {
  Future<List<RegistroSanitarioModel>> obtenerHistorial(
    String galponId, {
    TipoEventoSanitario? tipo,
    DateTime? desde,
    DateTime? hasta,
  });

  Future<RegistroSanitarioModel> registrarEvento({
    required String galponId,
    required TipoEventoSanitario tipo,
    required DateTime fecha,
    required String descripcion,
    String? medicamento,
    String? dosis,
    String? veterinario,
    int? avesAfectadas,
    DateTime? fechaProximaAplicacion,
    String? observaciones,
  });

  Future<List<RegistroSanitarioModel>> obtenerPendientes();
  Future<Map<String, dynamic>> obtenerResumen(String galponId);
}

/// Implementación del data source remoto
class SanidadRemoteDataSourceImpl implements SanidadRemoteDataSource {
  // TODO: Inject HttpClient when API is ready

  SanidadRemoteDataSourceImpl();

  @override
  Future<List<RegistroSanitarioModel>> obtenerHistorial(
    String galponId, {
    TipoEventoSanitario? tipo,
    DateTime? desde,
    DateTime? hasta,
  }) async {
    // TODO: Implement API call
    await Future.delayed(const Duration(milliseconds: 500));

    final now = DateTime.now();
    return [
      RegistroSanitarioModel(
        id: '1',
        galponId: galponId,
        tipo: TipoEventoSanitario.vacunacion,
        fecha: now.subtract(const Duration(days: 7)),
        descripcion: 'Vacuna Newcastle',
        medicamento: 'Newcastle B1',
        dosis: '1 gota ocular',
        veterinario: 'Dr. García',
        fechaProximaAplicacion: now.add(const Duration(days: 23)),
        observaciones: 'Aplicación programada',
        createdAt: now.subtract(const Duration(days: 7)),
      ),
      RegistroSanitarioModel(
        id: '2',
        galponId: galponId,
        tipo: TipoEventoSanitario.desparasitacion,
        fecha: now.subtract(const Duration(days: 14)),
        descripcion: 'Desparasitación general',
        medicamento: 'Albendazol',
        dosis: '10mg/kg',
        veterinario: 'Dr. García',
        observaciones: 'Sin novedades',
        createdAt: now.subtract(const Duration(days: 14)),
      ),
      RegistroSanitarioModel(
        id: '3',
        galponId: galponId,
        tipo: TipoEventoSanitario.inspeccion,
        fecha: now.subtract(const Duration(days: 3)),
        descripcion: 'Inspección rutinaria',
        veterinario: 'Dr. López',
        observaciones: 'Aves en buen estado',
        createdAt: now.subtract(const Duration(days: 3)),
      ),
    ];
  }

  @override
  Future<RegistroSanitarioModel> registrarEvento({
    required String galponId,
    required TipoEventoSanitario tipo,
    required DateTime fecha,
    required String descripcion,
    String? medicamento,
    String? dosis,
    String? veterinario,
    int? avesAfectadas,
    DateTime? fechaProximaAplicacion,
    String? observaciones,
  }) async {
    // TODO: Implement API call
    await Future.delayed(const Duration(milliseconds: 500));

    return RegistroSanitarioModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      galponId: galponId,
      tipo: tipo,
      fecha: fecha,
      descripcion: descripcion,
      medicamento: medicamento,
      dosis: dosis,
      veterinario: veterinario,
      avesAfectadas: avesAfectadas,
      fechaProximaAplicacion: fechaProximaAplicacion,
      observaciones: observaciones,
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<List<RegistroSanitarioModel>> obtenerPendientes() async {
    // TODO: Implement API call
    await Future.delayed(const Duration(milliseconds: 300));

    final now = DateTime.now();
    return [
      RegistroSanitarioModel(
        id: '1',
        galponId: 'galpon_1',
        tipo: TipoEventoSanitario.vacunacion,
        fecha: now.subtract(const Duration(days: 7)),
        descripcion: 'Vacuna Newcastle - refuerzo',
        medicamento: 'Newcastle B1',
        dosis: '1 gota ocular',
        fechaProximaAplicacion: now.add(const Duration(days: 3)),
        createdAt: now.subtract(const Duration(days: 7)),
      ),
    ];
  }

  @override
  Future<Map<String, dynamic>> obtenerResumen(String galponId) async {
    // TODO: Implement API call
    await Future.delayed(const Duration(milliseconds: 300));

    return {
      'total_eventos': 15,
      'vacunaciones': 5,
      'tratamientos': 3,
      'inspecciones': 7,
      'ultima_vacunacion': DateTime.now().subtract(const Duration(days: 7)).toIso8601String(),
      'proxima_vacunacion': DateTime.now().add(const Duration(days: 23)).toIso8601String(),
    };
  }
}
