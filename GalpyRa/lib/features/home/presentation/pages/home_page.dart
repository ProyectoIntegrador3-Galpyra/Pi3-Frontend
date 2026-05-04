import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/constants/app_constants.dart';
import '../../../../config/di/injector.dart';
import '../../../../config/routes/route_paths.dart';
import '../../../../config/theme/colors.dart';
import '../../../../core/storage/secure_storage.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../galpones/presentation/controllers/galpones_controller.dart';
import '../../../reportes/presentation/controllers/reportes_controller.dart';

/// Pagina principal - Home
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String _rol = 'PRODUCTOR';
  bool _rolLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadRol();
  }

  Future<void> _loadRol() async {
    final rol = await getIt<SecureStorage>().read(AppConstants.userRoleKey) ??
        'PRODUCTOR';
    if (!mounted) return;
    setState(() {
      _rol = rol.trim().toUpperCase();
      _rolLoaded = true;
    });

    if (_isAdmin) {
      await _loadAdminDashboard();
    }
  }

  Future<void> _loadAdminDashboard() async {
    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.none) {
      return;
    }

    await ref.read(reportesControllerProvider.notifier).cargarDatosDashboard();
  }

  bool get _isAdmin => _rol == 'ADMIN';

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final nombreUsuario = authState.user?.name ?? 'Usuario';
    final dashboardState = ref.watch(reportesControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildHomeAppBar(context),
      bottomNavigationBar: _isAdmin ? null : _buildBottomBar(context, ref),
      body: RefreshIndicator(
        onRefresh: _loadRol,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final bool isTablet = width > 720;
            final double horizontalPadding = isTablet ? 24 : 16;

            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                16,
                horizontalPadding,
                16,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 220),
                    child: !_rolLoaded
                        ? const Padding(
                            key: ValueKey('home-loading'),
                            padding: EdgeInsets.symmetric(vertical: 120),
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : Column(
                            key: const ValueKey('home-content'),
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _isAdmin
                                  ? _buildAdminHeader(context, dashboardState)
                                  : _buildOperarioHeader(
                                      context, nombreUsuario),
                              const SizedBox(height: 18),
                              _buildSectionTitle(
                                context,
                                _isAdmin
                                    ? 'Panel administrativo'
                                    : 'Panel operativo',
                              ),
                              const SizedBox(height: 12),
                              _buildSectionTitle(context, 'Módulos'),
                              const SizedBox(height: 12),
                              _buildMenuGrid(context, ref, 3),
                            ],
                          ),
                  ),
                ),
              ),
            ).animate().fadeIn(duration: 200.ms).slideY(
                begin: 0.04, end: 0, duration: 200.ms, curve: Curves.easeOut);
          },
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: const Border(top: BorderSide(color: AppColors.border, width: 1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _openModuleWithGalpon(
                    context,
                    ref,
                    'Inventario Foto',
                    RoutePaths.capturaPath,
                  ),
                  icon: const Icon(Icons.camera_alt, size: 20),
                  label: const Text(
                    'Conteo Foto',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondaryDark,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => context.push(RoutePaths.qrScanner),
                  icon: const Icon(Icons.qr_code_scanner, size: 20),
                  label: const Text(
                    'Escanear QR',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryDark,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildHomeAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(84),
      child: Container(
        decoration: const BoxDecoration(color: AppColors.primary),
        child: SafeArea(
          bottom: false,
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'GALPyra',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Gestión Avícola y Trazabilidad Productiva',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withValues(alpha: 0.85),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {
                  context.push(RoutePaths.notifications);
                },
              ),
              IconButton(
                icon: const Icon(Icons.settings_outlined),
                onPressed: () => context.push(RoutePaths.settings),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openModuleWithGalpon(
    BuildContext context,
    WidgetRef ref,
    String moduleName,
    String Function(String galponId) routeBuilder,
  ) async {
    final controller = ref.read(galponesControllerProvider.notifier);
    var galpones = ref.read(galponesControllerProvider).galpones;

    if (galpones.isEmpty) {
      await controller.cargarGalpones();
      galpones = ref.read(galponesControllerProvider).galpones;
    }

    if (!context.mounted) return;

    if (galpones.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Primero crea o selecciona un galpón')),
      );
      context.push(RoutePaths.galpones);
      return;
    }

    if (galpones.length == 1) {
      context.push(routeBuilder(galpones.first.id));
      return;
    }

    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selecciona un galpón para $moduleName',
                  style: Theme.of(sheetContext).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryDark,
                      ),
                ),
                const SizedBox(height: 12),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: galpones.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (_, index) {
                      final galpon = galpones[index];
                      return ListTile(
                        leading: const Icon(Icons.home_work_outlined),
                        title: Text(galpon.nombre),
                        subtitle: Text(galpon.ubicacion ?? 'Sin ubicación'),
                        onTap: () {
                          Navigator.of(sheetContext).pop();
                          context.push(routeBuilder(galpon.id));
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOperarioHeader(BuildContext context, String nombre) {
    final hora = DateTime.now().hour;
    final saludo = hora < 12
        ? 'Buenos días'
        : hora < 18
            ? 'Buenas tardes'
            : 'Buenas noches';
    final hoy = DateTime.now();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$saludo,',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            nombre,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryDark,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            'Hoy ${hoy.day}/${hoy.month}/${hoy.year}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 12),
          _buildConectividadChip(),
        ],
      ),
    );
  }

  Widget _buildAdminHeader(BuildContext context, ReportesState dashboardState) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Panel administrativo',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryDark,
                              ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Supervisión, control y gestión',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              _buildConectividadChip(),
            ],
          ),
          const SizedBox(height: 16),
          StreamBuilder<ConnectivityResult>(
            stream: Connectivity().onConnectivityChanged,
            builder: (context, snapshot) {
              final isOnline =
                  snapshot.hasData && snapshot.data != ConnectivityResult.none;

              if (!isOnline) {
                return _buildOfflineMetricsMessage(context);
              }

              final datos = dashboardState.datosDashboard;
              if (dashboardState.isLoading && datos == null) {
                return _buildMetricsLoading(context);
              }

              if (datos == null) {
                return _buildMetricsUnavailable(
                    context, dashboardState.errorMessage);
              }

              return _buildAdminMetricsGrid(context, datos);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAdminMetricsGrid(
      BuildContext context, Map<String, dynamic> datos) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      mainAxisExtent: 130,
      children: [
        _buildMetricCard(
          context,
          icon: Icons.egg_alt_outlined,
          color: const Color(0xFFD4920A),
          label: 'Total aves',
          value:
              _metricValue(datos, const ['aves_activas', 'total_aves_activas']),
          emoji: '🐔',
        ),
        _buildMetricCard(
          context,
          icon: Icons.egg_outlined,
          color: const Color(0xFFE67E22),
          label: 'Prod. hoy',
          value: _metricValue(
              datos, const ['produccion_hoy', 'produccion_ultimos_7_dias']),
        ),
        _buildMetricCard(
          context,
          icon: Icons.warning_amber_outlined,
          color: const Color(0xFFC0392B),
          label: 'Mort. mes',
          value: _metricValue(datos, const [
            'mortalidad_mes',
            'tasa_mortalidad_mes',
            'tasa_mortalidad_porcentaje'
          ]),
        ),
        _buildMetricCard(
          context,
          icon: Icons.home_work_outlined,
          color: const Color(0xFF2C3E7A),
          label: 'Galpones',
          value:
              _metricValue(datos, const ['galpones_activos', 'total_galpones']),
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String label,
    required String value,
    String? emoji,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(10),
            ),
            child: emoji != null
                ? Text(emoji, style: const TextStyle(fontSize: 20))
                : Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: color,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricsLoading(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          const SizedBox(width: 12),
          Text(
            'Cargando métricas...',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfflineMetricsMessage(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        'Sin conexión — métricas no disponibles',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }

  Widget _buildMetricsUnavailable(BuildContext context, String? errorMessage) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Métricas no disponibles',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
          ),
          if (errorMessage != null) ...[
            const SizedBox(height: 4),
            Text(
              errorMessage,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
          const SizedBox(height: 10),
          TextButton(
            onPressed: _loadAdminDashboard,
            child: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }

  Widget _buildConectividadChip() {
    return StreamBuilder<ConnectivityResult>(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        final isOnline =
            snapshot.hasData && snapshot.data != ConnectivityResult.none;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: isOnline
                ? const Color(0xFF27AE60).withValues(alpha: 0.12)
                : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isOnline ? const Color(0xFF27AE60) : Colors.grey,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                isOnline ? 'En línea' : 'Sin conexión',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color:
                      isOnline ? const Color(0xFF27AE60) : Colors.grey.shade600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _metricValue(Map<String, dynamic> datos, List<String> keys) {
    for (final key in keys) {
      final value = datos[key];
      if (value == null) continue;

      if (value is num) {
        if (value == value.roundToDouble()) {
          return value.toInt().toString();
        }
        return value.toStringAsFixed(1);
      }

      final text = value.toString().trim();
      if (text.isNotEmpty) {
        return text;
      }
    }

    return '—';
  }

  Widget _buildSectionTitle(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.primaryDark,
          ),
    );
  }

  List<_MenuItem> _buildMenuItems(BuildContext context, WidgetRef ref) {
    if (_isAdmin) {
      return [
        _MenuItem(
          'Reportes',
          Icons.assessment_outlined,
          const Color(0xFF2C3E7A),
          () => context.push(RoutePaths.reportes),
        ),
        _MenuItem(
          'Admin',
          Icons.admin_panel_settings_outlined,
          const Color(0xFF5D6D8A),
          () => context.push(RoutePaths.adminDashboard),
        ),
        _MenuItem(
          'Galpones',
          Icons.home_work_outlined,
          const Color(0xFFD4920A),
          () => context.push(RoutePaths.galpones),
        ),
      ];
    }

    return [
      _MenuItem(
        'Galpones',
        Icons.home_work_outlined,
        const Color(0xFFD4920A),
        () => context.push(RoutePaths.galpones),
      ),
      _MenuItem(
        'Producción',
        Icons.egg_outlined,
        const Color(0xFFE67E22),
        () => _openModuleWithGalpon(
            context, ref, 'Producción', RoutePaths.produccionPath),
      ),
      _MenuItem(
        'Alimentación',
        Icons.restaurant_outlined,
        const Color(0xFF8B9B2A),
        () => _openModuleWithGalpon(
            context, ref, 'Alimentación', RoutePaths.alimentacionPath),
      ),
      _MenuItem(
        'Sanidad',
        Icons.medical_services_outlined,
        const Color(0xFFC0392B),
        () => _openModuleWithGalpon(
            context, ref, 'Sanidad', RoutePaths.sanidadPath),
      ),
      _MenuItem(
        'Aves',
        Icons.spa_outlined,
        const Color(0xFF27AE60),
        () => _openModuleWithGalpon(context, ref, 'Aves', RoutePaths.avesPath),
      ),
      _MenuItem(
        'Inventario Foto',
        Icons.camera_alt_outlined,
        const Color(0xFFD4920A),
        () => context.push(RoutePaths.inventarioFoto),
      ),
    ];
  }

  Widget _buildMenuGrid(
    BuildContext context,
    WidgetRef ref,
    int crossAxisCount,
  ) {
    final menuItems = _buildMenuItems(context, ref);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        mainAxisExtent: 110,
      ),
      itemCount: menuItems.length,
      itemBuilder: (context, index) => _buildMenuItem(menuItems[index]),
    );
  }

  Widget _buildMenuItem(_MenuItem item) {
    return InkWell(
      onTap: item.onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFFDF3DC),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFE8D5A3),
            width: 1.5,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 2,
              right: 2,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: item.color,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(item.icon, color: item.color, size: 34),
                  const SizedBox(height: 8),
                  Text(
                    item.label,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuItem {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  _MenuItem(this.label, this.icon, this.color, this.onTap);
}
