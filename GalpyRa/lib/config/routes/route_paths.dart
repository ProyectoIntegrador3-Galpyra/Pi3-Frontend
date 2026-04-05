/// Route paths for navigation
class RoutePaths {
  RoutePaths._();

  // Auth routes
  static const String login = '/login';
  static const String profile = '/profile';

  // Main routes
  static const String home = '/';
  static const String dashboard = '/dashboard';

  // Galpones routes
  static const String galpones = '/galpones';
  static const String galponDetail = '/galpones/:id';
  static const String galponForm = '/galpones/form';
  static const String galponEdit = '/galpones/:id/edit';

  // Aves routes
  static const String aves = '/aves/:galponId';
  static const String mortalidadForm = '/aves/:galponId/mortalidad';
  static const String ingresoForm = '/aves/:galponId/ingreso';

  // Producción routes
  static const String produccion = '/produccion/:galponId';
  static const String produccionForm = '/produccion/:galponId/form';

  // Sanidad routes
  static const String sanidad = '/sanidad/:galponId';
  static const String sanidadForm = '/sanidad/:galponId/form';

  // Alimentación routes
  static const String alimentacion = '/alimentacion/:galponId';
  static const String alimentacionForm = '/alimentacion/:galponId/form';

  // Inventario por foto routes
  static const String inventarioFoto = '/inventario-foto';
  static const String captura = '/inventario-foto/captura/:galponId';
  static const String revisionConteo = '/inventario-foto/revision/:galponId';
  static const String resultadoActualizacion =
      '/inventario-foto/resultado/:galponId';

  // Reportes routes
  static const String reportes = '/reportes';
  static const String reporteDetail = '/reportes/:id';
  static const String generarReporte = '/reportes/generar';

  // Trazabilidad routes
  static const String trazabilidad = '/trazabilidad';

  // Settings routes
  static const String settings = '/settings';

  // Helper methods for dynamic routes
  static String galponDetailPath(String id) => '/galpones/$id';
  static String galponEditPath(String id) => '/galpones/$id/edit';
  static String reporteDetailPath(String id) => '/reportes/$id';

  // Aves helpers
  static String avesPath(String galponId) => '/aves/$galponId';
  static String mortalidadFormPath(String galponId) =>
      '/aves/$galponId/mortalidad';
  static String ingresoAvesForm(String galponId) => '/aves/$galponId/ingreso';

  // Producción helpers
  static String produccionPath(String galponId) => '/produccion/$galponId';
  static String produccionFormPath(String galponId) =>
      '/produccion/$galponId/form';

  // Sanidad helpers
  static String sanidadPath(String galponId) => '/sanidad/$galponId';
  static String sanidadFormPath(String galponId) => '/sanidad/$galponId/form';

  // Alimentación helpers
  static String alimentacionPath(String galponId) => '/alimentacion/$galponId';
  static String alimentacionFormPath(String galponId) =>
      '/alimentacion/$galponId/form';

  // Inventario foto helpers
  static String capturaPath(String galponId) =>
      '/inventario-foto/captura/$galponId';
  static String revisionConteoPath(String galponId) =>
      '/inventario-foto/revision/$galponId';
  static String resultadoActualizacionPath(String galponId) =>
      '/inventario-foto/resultado/$galponId';
}
