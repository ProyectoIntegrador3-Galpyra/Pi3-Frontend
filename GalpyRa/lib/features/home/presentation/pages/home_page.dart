import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/routes/route_paths.dart';
import '../../../../config/theme/colors.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../galpones/presentation/controllers/galpones_controller.dart';

/// Pagina principal - Home
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final nombreUsuario = authState.user?.name ?? 'Usuario';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildHomeAppBar(context),
      body: RefreshIndicator(
        onRefresh: () async {
          // TODO: Refresh dashboard data
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final bool isTablet = width > 720;
            final double horizontalPadding = isTablet ? 24 : 16;
            final int crossAxisCount;

            if (width < 480) {
              crossAxisCount = 2;
            } else if (width <= 720) {
              crossAxisCount = 3;
            } else {
              crossAxisCount = 4;
            }

            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                16,
                horizontalPadding,
                32,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildGreeting(context, nombreUsuario),
                      const SizedBox(height: 18),
                      _buildSectionTitle(context, 'Resumen del día'),
                      const SizedBox(height: 10),
                      _buildQuickStats(context),
                      const SizedBox(height: 24),
                      _buildSectionTitle(context, 'Módulos'),
                      const SizedBox(height: 12),
                      _buildMenuGrid(context, ref, crossAxisCount),
                      const SizedBox(height: 24),
                      _buildRecentActivity(context),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildHomeAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(84),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary,
              AppColors.accentGreen,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
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
                  // TODO: Navigate to notifications
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
        const SnackBar(
          content: Text('Primero crea o selecciona un galpón'),
        ),
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

  Widget _buildGreeting(BuildContext context, String nombre) {
    final hora = DateTime.now().hour;
    String saludo;
    if (hora < 12) {
      saludo = 'Buenos días';
    } else if (hora < 18) {
      saludo = 'Buenas tardes';
    } else {
      saludo = 'Buenas noches';
    }

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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              'Hoy ${hoy.day}/${hoy.month}/${hoy.year}',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ),
        ],
      ),
    );
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

  Widget _buildQuickStats(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Aves Activas',
            '12,500',
            Icons.spa_outlined,
            AppColors.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            'Producción Hoy',
            '285',
            Icons.egg_outlined,
            AppColors.secondary,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String titulo,
    String valor,
    IconData icon,
    Color color,
  ) {
    return Container(
      constraints: const BoxConstraints(minHeight: 100),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.05),
            color.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(height: 12),
          Text(
            valor,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            titulo,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuGrid(
      BuildContext context, WidgetRef ref, int crossAxisCount) {
    final menuItems = [
      _MenuItem(
        'Galpones',
        Icons.home_work_outlined,
        AppColors.primaryDark,
        () => context.push(RoutePaths.galpones),
      ),
      _MenuItem(
        'Aves',
        Icons.spa_outlined,
        AppColors.accentGreen,
        () => _openModuleWithGalpon(
          context,
          ref,
          'Aves',
          RoutePaths.avesPath,
        ),
      ),
      _MenuItem(
        'Producción',
        Icons.egg_outlined,
        AppColors.secondary,
        () => _openModuleWithGalpon(
          context,
          ref,
          'Producción',
          RoutePaths.produccionPath,
        ),
      ),
      _MenuItem(
        'Sanidad',
        Icons.medical_services_outlined,
        AppColors.error,
        () => _openModuleWithGalpon(
          context,
          ref,
          'Sanidad',
          RoutePaths.sanidadPath,
        ),
      ),
      _MenuItem(
        'Alimentación',
        Icons.restaurant_outlined,
        AppColors.primary,
        () => _openModuleWithGalpon(
          context,
          ref,
          'Alimentación',
          RoutePaths.alimentacionPath,
        ),
      ),
      _MenuItem(
        'Inventario Foto',
        Icons.camera_alt_outlined,
        AppColors.accentLime,
        () => context.push(RoutePaths.inventarioFoto),
      ),
      _MenuItem(
        'Reportes',
        Icons.assessment_outlined,
        AppColors.secondaryDark,
        () => context.push(RoutePaths.reportes),
      ),
      _MenuItem(
        'Dashboard',
        Icons.dashboard_outlined,
        AppColors.primaryLight,
        () => context.push(RoutePaths.dashboard),
      ),
      _MenuItem(
        'Trazabilidad',
        Icons.qr_code_scanner_outlined,
        AppColors.primaryDark,
        () => context.push(RoutePaths.trazabilidad),
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.95,
      ),
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        final item = menuItems[index];
        return _buildMenuItem(item);
      },
    );
  }

  Widget _buildMenuItem(_MenuItem item) {
    return InkWell(
      onTap: item.onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              item.color.withOpacity(0.08),
              item.color.withOpacity(0.15),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: item.color.withOpacity(0.25),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: item.color.withOpacity(0.15),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              item.icon,
              color: item.color,
              size: 36,
            ),
            const SizedBox(height: 10),
            Text(
              item.label,
              style: const TextStyle(
                fontSize: 13,
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
    );
  }

  Widget _buildRecentActivity(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Actividad Reciente',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700),
            ),
            TextButton(
              onPressed: () {
                // TODO: Ver más
              },
              child: const Text('Ver más'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Card(
          child: Column(
            children: [
              _buildActivityItem(
                'Producción registrada',
                'Galpón A - 285 huevos',
                Icons.egg,
                Colors.orange,
                'Hace 2 horas',
              ),
              const Divider(height: 1),
              _buildActivityItem(
                'Alimentación registrada',
                'Galpón B - 150 kg',
                Icons.restaurant,
                Colors.green,
                'Hace 4 horas',
              ),
              const Divider(height: 1),
              _buildActivityItem(
                'Vacunación completada',
                'Galpón C - Newcastle',
                Icons.vaccines,
                Colors.blue,
                'Ayer',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActivityItem(
    String titulo,
    String subtitulo,
    IconData icon,
    Color color,
    String tiempo,
  ) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 72),
      child: ListTile(
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: color.withValues(alpha: 0.14),
          child: Icon(icon, color: color, size: 28),
        ),
        title: Text(
          titulo,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitulo,
          style: const TextStyle(fontSize: 12),
        ),
        trailing: Text(
          tiempo,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[500],
          ),
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
