/// API Endpoints for the application
class ApiEndpoints {
  ApiEndpoints._();

  // Auth endpoints
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String profile = '/auth/profile';
  static const String refreshToken = '/auth/refresh';

  // Galpones endpoints
  static const String galpones = '/galpones';
  static String galponById(String id) => '/galpones/$id';

  // Aves endpoints
  static const String aves = '/aves';
  static const String inventarioAves = '/aves/inventario';
  static const String mortalidad = '/aves/mortalidad';
  static const String ingresoAves = '/aves/ingreso';
  static String avesByGalpon(String galponId) => '/galpones/$galponId/aves';

  // Producción endpoints
  static const String produccion = '/produccion';
  static const String produccionRango = '/produccion/rango';
  static String produccionByGalpon(String galponId) => '/galpones/$galponId/produccion';

  // Sanidad endpoints
  static const String sanidad = '/sanidad';
  static const String historialSanidad = '/sanidad/historial';
  static String sanidadByGalpon(String galponId) => '/galpones/$galponId/sanidad';

  // Alimentación endpoints
  static const String alimentacion = '/alimentacion';
  static const String alimentacionRango = '/alimentacion/rango';
  static String alimentacionByGalpon(String galponId) => '/galpones/$galponId/alimentacion';

  // Inventario por foto endpoints
  static const String visionProcesar = '/vision/procesar';
  static const String visionJob = '/vision/job';
  static String visionJobById(String jobId) => '/vision/job/$jobId';
  static const String actualizarInventario = '/inventario/actualizar';

  // Reportes endpoints
  static const String reportes = '/reportes';
  static const String generarReporte = '/reportes/generar';
  static String reporteById(String id) => '/reportes/$id';
}
