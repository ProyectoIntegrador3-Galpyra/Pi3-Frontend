import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/routes/route_paths.dart';
import '../../../../config/theme/colors.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../core/widgets/error_view.dart';
import '../controllers/auth_controller.dart';
import '../widgets/role_badge.dart';

/// Profile page
class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(authControllerProvider.notifier).getProfile();
    });
  }

  Future<void> _handleLogout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cerrar sesión'),
        content: const Text('¿Estás seguro de que deseas cerrar sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Cerrar sesión'),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      await ref.read(authControllerProvider.notifier).logout();
      if (mounted) {
        context.go(RoutePaths.login);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    return AppScaffold(
      title: 'Mi Perfil',
      actions: [
        IconButton(
          icon: const Icon(Icons.settings_outlined),
          onPressed: () => context.push(RoutePaths.settings),
        ),
      ],
      body: _buildBody(authState),
    );
  }

  Widget _buildBody(AuthState authState) {
    if (authState.isLoading && authState.user == null) {
      return const Loading(message: 'Cargando perfil...');
    }

    if (authState.error != null && authState.user == null) {
      return ErrorView.generic(
        message: authState.error,
        onRetry: () {
          ref.read(authControllerProvider.notifier).getProfile();
        },
      );
    }

    final user = authState.user;
    if (user == null) {
      return const ErrorView(message: 'No se pudo cargar el perfil');
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Avatar
          CircleAvatar(
            radius: 50,
            backgroundColor: AppColors.primary,
            backgroundImage: user.avatarUrl != null
                ? NetworkImage(user.avatarUrl!)
                : null,
            child: user.avatarUrl == null
                ? Text(
                    user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
                    style: const TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  )
                : null,
          ),
          const SizedBox(height: 16),

          // Name
          Text(
            user.name,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),

          // Role badge
          RoleBadge(role: user.role),
          const SizedBox(height: 24),

          // Info cards
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildInfoRow(
                    icon: Icons.email_outlined,
                    label: 'Correo',
                    value: user.email,
                  ),
                  const Divider(height: 24),
                  _buildInfoRow(
                    icon: Icons.phone_outlined,
                    label: 'Teléfono',
                    value: user.phone ?? 'No registrado',
                  ),
                  const Divider(height: 24),
                  _buildInfoRow(
                    icon: Icons.calendar_today_outlined,
                    label: 'Miembro desde',
                    value: _formatDate(user.createdAt),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Edit profile button
          AppButton(
            text: 'Editar perfil',
            onPressed: () {
              // TODO: Navigate to edit profile
            },
            type: AppButtonType.outline,
            icon: Icons.edit_outlined,
            isExpanded: true,
          ),
          const SizedBox(height: 16),

          // Logout button
          AppButton(
            text: 'Cerrar sesión',
            onPressed: _handleLogout,
            type: AppButtonType.danger,
            icon: Icons.logout,
            isExpanded: true,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, color: AppColors.textSecondary, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
