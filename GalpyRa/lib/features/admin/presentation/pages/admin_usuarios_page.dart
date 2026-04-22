import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/route_paths.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading.dart';
import '../../../auth/presentation/widgets/role_badge.dart';
import '../controllers/admin_controller.dart';

class AdminUsuariosPage extends ConsumerStatefulWidget {
  const AdminUsuariosPage({super.key});

  @override
  ConsumerState<AdminUsuariosPage> createState() => _AdminUsuariosPageState();
}

class _AdminUsuariosPageState extends ConsumerState<AdminUsuariosPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(adminControllerProvider.notifier).cargarUsuarios();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(adminControllerProvider);

    return AppScaffold(
      title: 'Usuarios del sistema',
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(RoutePaths.adminUsuarioForm),
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            ref.read(adminControllerProvider.notifier).cargarUsuarios(),
        child: _buildBody(state),
      ),
    );
  }

  Widget _buildBody(AdminState state) {
    if (state.isLoading && state.usuarios.isEmpty) {
      return const Loading(message: 'Cargando usuarios...');
    }

    if (state.error != null && state.usuarios.isEmpty) {
      return ErrorView(
        message: state.error!,
        onRetry: () =>
            ref.read(adminControllerProvider.notifier).cargarUsuarios(),
      );
    }

    if (state.usuarios.isEmpty) {
      return const EmptyState(
        title: 'Sin usuarios',
        message: 'No hay usuarios disponibles para mostrar.',
        icon: Icons.group_outlined,
        fullScreen: true,
      );
    }

    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: state.usuarios.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final user = state.usuarios[index];

        return Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Text(
                user.nombre.isNotEmpty ? user.nombre[0].toUpperCase() : '?',
              ),
            ),
            title: Text(user.nombre),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.email),
                const SizedBox(height: 6),
                RoleBadge(role: user.role, size: RoleBadgeSize.small),
              ],
            ),
            isThreeLine: true,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  onPressed: () => context.push(
                    RoutePaths.adminUsuarioEditPath(user.id),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => _confirmarEliminar(context, user.id),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _confirmarEliminar(BuildContext context, String id) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Eliminar usuario'),
          content:
              const Text('Esta accion no se puede deshacer. Deseas continuar?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true && context.mounted) {
      final ok =
          await ref.read(adminControllerProvider.notifier).eliminarUsuario(id);
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text(ok ? 'Usuario eliminado' : 'No se pudo eliminar el usuario'),
        ),
      );
    }
  }
}
