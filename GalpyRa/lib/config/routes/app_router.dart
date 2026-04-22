import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'route_paths.dart';
import '../../features/auth/presentation/controllers/auth_controller.dart';

// Auth
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/profile_page.dart';

// Home
import '../../features/home/presentation/pages/home_page.dart';

// Galpones
import '../../features/galpones/presentation/pages/galpones_list_page.dart';
import '../../features/galpones/presentation/pages/galpon_detail_page.dart';
import '../../features/galpones/presentation/pages/galpon_form_page.dart';

// Aves
import '../../features/aves/presentation/pages/aves_page.dart';
import '../../features/aves/presentation/pages/mortalidad_form_page.dart';
import '../../features/aves/presentation/pages/ingreso_form_page.dart';

// Producción
import '../../features/produccion_huevos/presentation/pages/produccion_page.dart';
import '../../features/produccion_huevos/presentation/pages/produccion_form_page.dart';

// Sanidad
import '../../features/sanidad/presentation/pages/sanidad_page.dart';
import '../../features/sanidad/presentation/pages/sanidad_form_page.dart';

// Alimentación
import '../../features/alimentacion/presentation/pages/alimentacion_page.dart';
import '../../features/alimentacion/presentation/pages/alimentacion_form_page.dart';

// Inventario por foto
import '../../features/inventario_foto/presentation/pages/captura_page.dart';
import '../../features/inventario_foto/presentation/pages/revision_conteo_page.dart';
import '../../features/inventario_foto/presentation/pages/resultado_actualizacion_page.dart';

// Reportes
import '../../features/reportes/presentation/pages/reportes_page.dart';
import '../../features/reportes/presentation/pages/generar_reporte_page.dart';
import '../../features/reportes/presentation/pages/dashboard_page.dart';

// Trazabilidad
import '../../features/trazabilidad/presentation/pages/trazabilidad_page.dart';

// Settings
import '../../features/settings/presentation/pages/settings_page.dart';

// Admin
import '../../features/admin/presentation/pages/admin_usuarios_page.dart';
import '../../features/admin/presentation/pages/admin_usuario_form_page.dart';
import '../../features/admin/presentation/pages/admin_reportes_page.dart';
import '../../features/admin/presentation/pages/admin_dashboard_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authControllerProvider);

  return GoRouter(
    initialLocation: RoutePaths.home,
    debugLogDiagnostics: true,
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Página no encontrada: ${state.uri.path}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(RoutePaths.home),
              child: const Text('Volver al inicio'),
            ),
          ],
        ),
      ),
    ),
    routes: [
      // Auth routes
      GoRoute(
        path: RoutePaths.login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RoutePaths.profile,
        name: 'profile',
        builder: (context, state) => const ProfilePage(),
      ),

      // Home / Dashboard
      GoRoute(
        path: RoutePaths.home,
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),

      // Galpones routes
      GoRoute(
        path: RoutePaths.galpones,
        name: 'galpones',
        builder: (context, state) => const GalponesListPage(),
      ),
      GoRoute(
        path: RoutePaths.galponForm,
        name: 'galponForm',
        builder: (context, state) => const GalponFormPage(),
      ),
      GoRoute(
        path: RoutePaths.galponDetail,
        name: 'galponDetail',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return GalponDetailPage(galponId: id);
        },
      ),
      GoRoute(
        path: RoutePaths.galponEdit,
        name: 'galponEdit',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return GalponFormPage(galponId: id);
        },
      ),

      // Aves routes
      GoRoute(
        path: RoutePaths.aves,
        name: 'aves',
        builder: (context, state) {
          final galponId = state.pathParameters['galponId']!;
          return AvesPage(galponId: galponId);
        },
      ),
      GoRoute(
        path: RoutePaths.mortalidadForm,
        name: 'mortalidadForm',
        builder: (context, state) {
          final galponId = state.pathParameters['galponId']!;
          return MortalidadFormPage(galponId: galponId);
        },
      ),
      GoRoute(
        path: RoutePaths.ingresoForm,
        name: 'ingresoForm',
        builder: (context, state) {
          final galponId = state.pathParameters['galponId']!;
          return IngresoFormPage(galponId: galponId);
        },
      ),

      // Producción routes
      GoRoute(
        path: RoutePaths.produccion,
        name: 'produccion',
        builder: (context, state) {
          final galponId = state.pathParameters['galponId']!;
          return ProduccionPage(galponId: galponId);
        },
      ),
      GoRoute(
        path: RoutePaths.produccionForm,
        name: 'produccionForm',
        builder: (context, state) {
          final galponId = state.pathParameters['galponId']!;
          return ProduccionFormPage(galponId: galponId);
        },
      ),

      // Sanidad routes
      GoRoute(
        path: RoutePaths.sanidad,
        name: 'sanidad',
        builder: (context, state) {
          final galponId = state.pathParameters['galponId']!;
          return SanidadPage(galponId: galponId);
        },
      ),
      GoRoute(
        path: RoutePaths.sanidadForm,
        name: 'sanidadForm',
        builder: (context, state) {
          final galponId = state.pathParameters['galponId']!;
          return SanidadFormPage(galponId: galponId);
        },
      ),

      // Alimentación routes
      GoRoute(
        path: RoutePaths.alimentacion,
        name: 'alimentacion',
        builder: (context, state) {
          final galponId = state.pathParameters['galponId']!;
          return AlimentacionPage(galponId: galponId);
        },
      ),
      GoRoute(
        path: RoutePaths.alimentacionForm,
        name: 'alimentacionForm',
        builder: (context, state) {
          final galponId = state.pathParameters['galponId']!;
          return AlimentacionFormPage(galponId: galponId);
        },
      ),

      // Inventario por foto routes
      GoRoute(
        path: RoutePaths.inventarioFoto,
        name: 'inventarioFoto',
        builder: (context, state) =>
            const GalponesListPage(), // Seleccionar galpón
      ),
      GoRoute(
        path: RoutePaths.captura,
        name: 'captura',
        builder: (context, state) {
          final galponId = state.pathParameters['galponId']!;
          return CapturaPage(galponId: galponId);
        },
      ),
      GoRoute(
        path: RoutePaths.revisionConteo,
        name: 'revisionConteo',
        builder: (context, state) {
          final galponId = state.pathParameters['galponId']!;
          return RevisionConteoPage(galponId: galponId);
        },
      ),
      GoRoute(
        path: RoutePaths.resultadoActualizacion,
        name: 'resultadoActualizacion',
        builder: (context, state) {
          final galponId = state.pathParameters['galponId']!;
          return ResultadoActualizacionPage(galponId: galponId);
        },
      ),

      // Reportes routes
      GoRoute(
        path: RoutePaths.reportes,
        name: 'reportes',
        builder: (context, state) => const ReportesPage(),
      ),
      GoRoute(
        path: RoutePaths.generarReporte,
        name: 'generarReporte',
        builder: (context, state) => const GenerarReportePage(),
      ),
      GoRoute(
        path: RoutePaths.dashboard,
        name: 'dashboard',
        builder: (context, state) => const DashboardPage(),
      ),

      // Admin routes
      GoRoute(
        path: RoutePaths.adminUsuarios,
        name: 'adminUsuarios',
        builder: (context, state) => const AdminUsuariosPage(),
      ),
      GoRoute(
        path: RoutePaths.adminUsuarioForm,
        name: 'adminUsuarioForm',
        builder: (context, state) => const AdminUsuarioFormPage(),
      ),
      GoRoute(
        path: '/admin/usuarios/:id/edit',
        name: 'adminUsuarioEdit',
        builder: (context, state) {
          return AdminUsuarioFormPage(userId: state.pathParameters['id']);
        },
      ),
      GoRoute(
        path: RoutePaths.adminReportes,
        name: 'adminReportes',
        builder: (context, state) => const AdminReportesPage(),
      ),
      GoRoute(
        path: RoutePaths.adminDashboard,
        name: 'adminDashboard',
        builder: (context, state) => const AdminDashboardPage(),
      ),

      // Trazabilidad routes
      GoRoute(
        path: RoutePaths.trazabilidad,
        name: 'trazabilidad',
        builder: (context, state) => const TrazabilidadPage(),
      ),

      // Settings routes
      GoRoute(
        path: RoutePaths.settings,
        name: 'settings',
        builder: (context, state) => const SettingsPage(),
      ),
    ],
    redirect: (context, state) {
      final isLoggedIn = authState.isAuthenticated;
      final isLoginRoute = state.matchedLocation == RoutePaths.login;

      // Rutas públicas que no requieren autenticación
      const publicRoutes = [RoutePaths.login, RoutePaths.trazabilidad];
      final isPublicRoute = publicRoutes.contains(state.matchedLocation);

      // Si no está autenticado y no está en una ruta pública, redirigir a login
      if (!isLoggedIn && !isPublicRoute) {
        return RoutePaths.login;
      }

      // Si está autenticado y está en login, redirigir a home
      if (isLoggedIn && isLoginRoute) {
        return RoutePaths.home;
      }

      // No redirigir
      return null;
    },
  );
});
