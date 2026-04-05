/// API Endpoints for the application
class ApiEndpoints {
  ApiEndpoints._();

  // Auth endpoints
  static const String login = '/api/auth/login';
  static const String logout = '/api/auth/logout';
  static const String profile = '/api/auth/me';
  static const String refreshToken = '/api/auth/refresh';

  // Dashboard endpoint
  static const String dashboard = '/api/dashboard';

  // Sync endpoint
  static const String sync = '/api/sync';
  static const String syncLogs = '/api/sync/logs';

  // Galpones endpoints
  static const String galpones = '/api/galpones';
  static String galponById(String id) => '/api/galpones/$id';

  // Aves endpoints
  static const String aves = '/api/aves';
  static const String inventarioAves = '/api/aves/inventario';
  static const String mortalidad = '/api/aves/mortalidad';
  static const String ingresoAves = '/api/aves/ingreso';
  static String avesByGalpon(String galponId) => '/api/galpones/$galponId/aves';

  // Producción endpoints
  static const String produccion = '/api/produccion';
  static const String produccionRango = '/api/produccion/rango';
  static String produccionByGalpon(String galponId) => '/api/produccion/galpon/$galponId';

  // Sanidad endpoints
  static const String sanidad = '/api/sanidad';
  static String historialSanidad(String loteId) => '/api/sanidad/historial/$loteId';
  static String sanidadByGalpon(String galponId) => '/api/galpones/$galponId/sanidad';

  // Alimentación endpoints
  static const String alimentacion = '/api/alimentacion';
  static String alimentacionRango(String loteId) => '/api/alimentacion/conversion/$loteId';
  static String alimentacionByGalpon(String galponId) => '/api/galpones/$galponId/alimentacion';

  // Lotes endpoints
  static const String lotes = '/api/lotes';
  static String lotesByGalpon(String galponId) => '/api/lotes/galpon/$galponId';

  // Inventario por foto endpoints
  static const String inventarioProcesar = '/api/inventario/procesar';
  static const String inventarioConfirmar = '/api/inventario/confirmar';
  static const String inventarioJobs = '/api/inventario/jobs';
  static String inventarioJobById(String jobId) => '/api/inventario/jobs/$jobId';

  // Reportes endpoints
  static const String reportes = '/api/reportes';
  static const String generarReporte = '/api/reportes/generar';
  static String reporteById(String id) => '/api/reportes/$id';

  // Trazabilidad endpoints
  static const String trazabilidadToken = '/api/trazabilidad/token';
  static String trazabilidadPublica(String token) => '/api/trazabilidad/$token';
}
