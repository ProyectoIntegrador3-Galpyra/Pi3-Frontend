/// API Endpoints for the application
class ApiEndpoints {
  ApiEndpoints._();

  // Auth endpoints
  static const String login = '/api/auth/login';
  static const String logout = '/api/auth/logout';
  static const String profile = '/api/auth/me';
  static const String refreshToken = '/api/auth/refresh';
  static const String resetPassword = '/api/auth/reset-password';

  // Dashboard endpoint
  static const String dashboard = '/api/dashboard';

  // Sync endpoint
  static const String sync = '/api/sync';
  static const String syncLogs = '/api/sync/logs';

  // Galpones endpoints
  static const String galpones = '/api/galpones';
  static String galponById(String id) => '/api/galpones/$id';

  // Aves / Lotes endpoints
  static const String aves = '/api/lotes';
  static const String ingresoAves = '/api/lotes';
  static const String mortalidad = '/api/mortalidad';
  static const String ingresos = '/api/ingresos';
  static String avesByGalpon(String galponId) => '/api/lotes/galpon/$galponId';

  // Producción endpoints
  static const String produccion = '/api/produccion';
  static const String produccionRango = '/api/produccion/rango';
  static String produccionByGalpon(String galponId) =>
      '/api/produccion/galpon/$galponId';

  // Sanidad endpoints
  static const String sanidad = '/api/sanidad';
  static String historialSanidad(String loteId) =>
      '/api/sanidad/historial/$loteId';
  // GET /api/sanidad returns all events; filter client-side by galpon_id
  static String sanidadByGalpon(String galponId) => '/api/sanidad';

  // Alimentación endpoints
  static const String alimentacion = '/api/alimentacion';
  static String alimentacionRango(String loteId) =>
      '/api/alimentacion/conversion/$loteId';
  // GET /api/alimentacion returns all records; filter client-side by galpon_id
  static String alimentacionByGalpon(String galponId) => '/api/alimentacion';

  // Lotes endpoints
  static const String lotes = '/api/lotes';
  static String lotesByGalpon(String galponId) => '/api/lotes/galpon/$galponId';

  // Inventario por foto endpoints
  static const String inventarioProcesar = '/api/inventario/procesar';
  static const String inventarioConfirmar = '/api/inventario/confirmar';
  static const String inventarioJobs = '/api/inventario/jobs';
  static String inventarioJobById(String jobId) =>
      '/api/inventario/jobs/$jobId';

  // Reportes endpoints
  static const String reportes = '/api/reportes';
  static const String generarReporte = '/api/reportes/generar';
  static String reporteById(String id) => '/api/reportes/$id';

  // Admin endpoints
  static const String adminUsers = '/api/admin/users';
  static String adminUserById(String id) => '/api/admin/users/$id';
  static const String reportesProduccion = '/api/reportes/produccion';
  static const String reportesAlimentacion = '/api/reportes/alimentacion';
  static const String reportesMortalidad = '/api/reportes/mortalidad';
  static const String reportesInventario = '/api/reportes/inventario';
  static const String adminDashboard = '/api/admin/dashboard';

  // Trazabilidad endpoints
  static const String trazabilidadToken = '/api/trazabilidad/token';
  static String trazabilidadPublica(String token) => '/api/trazabilidad/$token';
}
