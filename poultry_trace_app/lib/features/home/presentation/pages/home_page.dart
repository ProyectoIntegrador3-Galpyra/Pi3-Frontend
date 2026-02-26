import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/routes/route_paths.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';

/// Página principal - Home
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
              // Greeting
              _buildGreeting(context, nombreUsuario),
              const SizedBox(height: 24),

              // Quick stats
              _buildQuickStats(context),
              const SizedBox(height: 24),

              // Main menu grid
              _buildMenuGrid(context),
              const SizedBox(height: 24),

              // Recent activity
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
      saludo = 'Buenos días';
    } else if (hora < 18) {
      saludo = 'Buenas tardes';
    } else {
      saludo = 'Buenas noches';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$saludo,',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        Text(
          nombre,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickStats(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Aves Activas',
            '12,500',
            Icons.opacity,
            Colors.blue,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            'Producción Hoy',
            '285',
            Icons.egg,
            Colors.orange,
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 12),
            Text(
              valor,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              titulo,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuGrid(BuildContext context) {
    final menuItems = [
      _MenuItem(
        'Galpones',
        Icons.home_work,
        Colors.blueGrey,
        () => context.push(RoutePaths.galpones),
      ),
      _MenuItem(
        'Aves',
        Icons.opacity,
        Colors.blue,
        () => context.push(RoutePaths.aves),
      ),
      _MenuItem(
        'Producción',
        Icons.egg,
        Colors.orange,
        () => context.push(RoutePaths.produccion),
      ),
      _MenuItem(
        'Sanidad',
        Icons.local_hospital,
        Colors.red,
        () => context.push(RoutePaths.sanidad),
      ),
      _MenuItem(
        'Alimentación',
        Icons.restaurant,
        Colors.green,
        () => context.push(RoutePaths.alimentacion),
      ),
      _MenuItem(
        'Inventario Foto',
        Icons.camera_alt,
        Colors.purple,
        () => context.push(RoutePaths.inventarioFoto),
      ),
      _MenuItem(
        'Reportes',
        Icons.assessment,
        Colors.teal,
        () => context.push(RoutePaths.reportes),
      ),
      _MenuItem(
        'Dashboard',
        Icons.dashboard,
        Colors.indigo,
        () => context.push(RoutePaths.dashboard),
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 16,
        crossAxisSpacing: 12,
        childAspectRatio: 0.8,
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
      borderRadius: BorderRadius.circular(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: item.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              item.icon,
              color: item.color,
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            item.label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
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
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
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
        style: const TextStyle(fontWeight: FontWeight.w500),
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
