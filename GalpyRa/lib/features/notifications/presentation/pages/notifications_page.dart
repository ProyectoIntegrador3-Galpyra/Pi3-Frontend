import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/loading.dart';
import '../controllers/notifications_controller.dart';
import '../../../notifications/domain/entities/notification.dart' as notif;

class NotificationsPage extends ConsumerStatefulWidget {
  const NotificationsPage({super.key});

  @override
  ConsumerState<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends ConsumerState<NotificationsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(notificationsControllerProvider.notifier).cargarNotificaciones();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(notificationsControllerProvider);

    return AppScaffold(
      title: 'Notificaciones',
      body: RefreshIndicator(
        onRefresh: () =>
            ref.read(notificationsControllerProvider.notifier).refrescar(),
        child: state.isLoading && state.notifications.isEmpty
            ? const Loading(message: 'Cargando notificaciones...')
            : state.notifications.isEmpty
                ? _buildEmptyState(context)
                : _buildNotificationsList(context, state),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.notifications_none,
                size: 64,
                color: AppColors.textSecondary,
              ),
              const SizedBox(height: 16),
              Text(
                'Sin notificaciones',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'No hay notificaciones en este momento',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationsList(
    BuildContext context,
    NotificationsState state,
  ) {
    return Column(
      children: [
        if (state.unreadCount > 0)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${state.unreadCount} sin leer',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.warning,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                AppButton(
                  text: 'Marcar todas como leídas',
                  onPressed: () {
                    ref
                        .read(notificationsControllerProvider.notifier)
                        .marcarTodasComoLeidas();
                  },
                  type: AppButtonType.secondary,
                  height: 36,
                ),
              ],
            ),
          ),
        Expanded(
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: state.notifications.length,
            itemBuilder: (context, index) {
              final notification = state.notifications[index];
              return _buildNotificationCard(context, notification);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationCard(
    BuildContext context,
    notif.Notification notification,
  ) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: notification.isRead
              ? AppColors.border
              : AppColors.primary.withOpacity(0.3),
          width: notification.isRead ? 1 : 2,
        ),
        borderRadius: BorderRadius.circular(12),
        color: notification.isRead ? Colors.white : AppColors.surfaceVariant,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (!notification.isRead) {
              ref
                  .read(notificationsControllerProvider.notifier)
                  .marcarComoLeida(notification.id);
            }
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTypeIcon(notification.type),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              notification.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontWeight: notification.isRead
                                        ? FontWeight.w500
                                        : FontWeight.bold,
                                  ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (!notification.isRead)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notification.message,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatDate(notification.createdAt),
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                          ),
                          PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'delete') {
                                ref
                                    .read(notificationsControllerProvider
                                        .notifier)
                                    .eliminarNotificacion(notification.id);
                              }
                            },
                            itemBuilder: (BuildContext context) => [
                              const PopupMenuItem<String>(
                                value: 'delete',
                                child: Row(
                                  children: [
                                    Icon(Icons.delete_outline,
                                        size: 18, color: AppColors.error),
                                    SizedBox(width: 8),
                                    Text('Eliminar'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTypeIcon(notif.NotificationType type) {
    final iconData = {
          notif.NotificationType.info: Icons.info_outlined,
          notif.NotificationType.warning: Icons.warning_amber_outlined,
          notif.NotificationType.error: Icons.error_outline,
          notif.NotificationType.success: Icons.check_circle_outline,
          notif.NotificationType.alert: Icons.notifications_active_outlined,
        }[type] ??
        Icons.notifications_outlined;

    final color = {
          notif.NotificationType.info: const Color(0xFF2C3E7A),
          notif.NotificationType.warning: AppColors.warning,
          notif.NotificationType.error: AppColors.error,
          notif.NotificationType.success: AppColors.success,
          notif.NotificationType.alert: AppColors.primary,
        }[type] ??
        AppColors.primary;

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(iconData, color: color, size: 20),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) {
      return 'Hace unos segundos';
    } else if (difference.inMinutes < 60) {
      return 'Hace ${difference.inMinutes} min';
    } else if (difference.inHours < 24) {
      return 'Hace ${difference.inHours}h';
    } else if (difference.inDays < 7) {
      return 'Hace ${difference.inDays}d';
    } else {
      return DateFormat('dd MMM', 'es_ES').format(date);
    }
  }
}
