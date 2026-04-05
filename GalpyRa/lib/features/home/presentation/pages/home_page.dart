import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/routes/route_paths.dart';
import '../../../../config/theme/colors.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';

/// Pagina principal - Home
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final nombreUsuario = authState.user?.name ?? 'Usuario';

    return AppScaffold(
      title: 'PoultryTrace',
      showBackButton: false,
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
      body: RefreshIndicator(
        onRefresh: () async {
          // TODO: Refresh dashboard data
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGreeting(context, nombreUsuario),
              const SizedBox(height: 18),
              _buildSectionTitle(context, 'Resumen del dia'),
              const SizedBox(height: 10),
              _buildQuickStats(context),
              const SizedBox(height: 24),
              _buildSectionTitle(context, 'Modulos'),
              const SizedBox(height: 12),
              _buildMenuGrid(context),
              const SizedBox(height: 24),
              _buildRecentActivity(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGreeting(BuildContext context, String nombre) {
    final hora = DateTime.now().hour;
    String saludo;
    if (hora < 12) {
      saludo = 'Buenos dias';
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
            'Produccion Hoy',
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
      padding: const EdgeInsets.all(16),
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
              fontSize: 26,
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

  Widget _buildMenuGrid(BuildContext context) {
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
        () => context.push(RoutePaths.aves),
      ),
      _MenuItem(
        'Produccion',
        Icons.egg_outlined,
        AppColors.secondary,
        () => context.push(RoutePaths.produccion),
      ),
      _MenuItem(
        'Sanidad',
        Icons.medical_services_outlined,
        AppColors.error,
        () => context.push(RoutePaths.sanidad),
      ),
      _MenuItem(
        'Alimentacion',
        Icons.restaurant_outlined,
        AppColors.primary,
        () => context.push(RoutePaths.alimentacion),
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
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 16,
        crossAxisSpacing: 12,
        childAspectRatio: 0.88,
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
      borderRadius: BorderRadius.circular(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
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
              borderRadius: BorderRadius.circular(16),
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
            child: Icon(
              item.icon,
              color: item.color,
              size: 26,
            ),
          ),
          const SizedBox(height: 8),
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
                // TODO: Ver mas
              },
              child: const Text('Ver mas'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Card(
          child: Column(
            children: [
              _buildActivityItem(
                'Produccion registrada',
                'Galpon A - 285 huevos',
                Icons.egg,
                Colors.orange,
                'Hace 2 horas',
              ),
              const Divider(height: 1),
              _buildActivityItem(
                'Alimentacion registrada',
                'Galpon B - 150 kg',
                Icons.restaurant,
                Colors.green,
                'Hace 4 horas',
              ),
              const Divider(height: 1),
              _buildActivityItem(
                'Vacunacion completada',
                'Galpon C - Newcastle',
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
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(
        titulo,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(subtitulo),
      trailing: Text(
        tiempo,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[500],
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
