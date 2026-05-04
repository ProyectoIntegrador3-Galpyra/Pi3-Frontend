import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/api_endpoints.dart';
import '../../../../config/di/injector.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_response_parser.dart';
import '../../../../core/network/http_client.dart';
import '../../../notifications/domain/entities/notification.dart';

class NotificationsState {
  final List<Notification> notifications;
  final bool isLoading;
  final String? error;
  final int unreadCount;

  const NotificationsState({
    this.notifications = const [],
    this.isLoading = false,
    this.error,
    this.unreadCount = 0,
  });

  NotificationsState copyWith({
    List<Notification>? notifications,
    bool? isLoading,
    String? error,
    bool clearError = false,
    int? unreadCount,
  }) {
    return NotificationsState(
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      unreadCount: unreadCount ??
          _calculateUnreadCount(
            notifications ?? this.notifications,
          ),
    );
  }

  static int _calculateUnreadCount(List<Notification> notifications) {
    return notifications.where((n) => !n.isRead).length;
  }
}

class NotificationsController extends StateNotifier<NotificationsState> {
  final HttpClient _httpClient;

  NotificationsController()
      : _httpClient = getIt<HttpClient>(),
        super(const NotificationsState());

  Future<void> cargarNotificaciones() async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final response = await _httpClient.get(
        '${ApiEndpoints.galpones}/notifications',
      );

      final data = ApiResponseParser.extractDataList(response.data);
      final notifications = (data as List)
          .map((json) => Notification.fromJson(json as Map<String, dynamic>))
          .toList();

      // Ordenar por más recientes primero
      notifications.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      state = state.copyWith(
        notifications: notifications,
        isLoading: false,
      );
    } on ServerException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.message,
      );
      debugPrint('Error cargando notificaciones: ${e.message}');
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error al cargar notificaciones',
      );
      debugPrint('Error inesperado: $e');
    }
  }

  /// Marcar una notificación como leída
  Future<void> marcarComoLeida(String notificationId) async {
    try {
      await _httpClient.put(
        '${ApiEndpoints.galpones}/notifications/$notificationId/read',
        data: {},
      );

      // Actualizar estado local
      final updatedNotifications = state.notifications.map((notif) {
        if (notif.id == notificationId) {
          return notif.copyWith(isRead: true);
        }
        return notif;
      }).toList();

      state = state.copyWith(notifications: updatedNotifications);
    } catch (e) {
      debugPrint('Error marcando notificación como leída: $e');
    }
  }

  /// Marcar todas las notificaciones como leídas
  Future<void> marcarTodasComoLeidas() async {
    try {
      await _httpClient.put(
        '${ApiEndpoints.galpones}/notifications/read-all',
        data: {},
      );

      // Actualizar estado local
      final updatedNotifications = state.notifications
          .map((notif) => notif.copyWith(isRead: true))
          .toList();

      state = state.copyWith(notifications: updatedNotifications);
    } catch (e) {
      debugPrint('Error marcando todas como leídas: $e');
    }
  }

  /// Eliminar una notificación
  Future<void> eliminarNotificacion(String notificationId) async {
    try {
      await _httpClient.delete(
        '${ApiEndpoints.galpones}/notifications/$notificationId',
      );

      // Actualizar estado local
      final updatedNotifications = state.notifications
          .where((notif) => notif.id != notificationId)
          .toList();

      state = state.copyWith(notifications: updatedNotifications);
    } catch (e) {
      debugPrint('Error eliminando notificación: $e');
    }
  }

  /// Limpiar todas las notificaciones
  Future<void> limpiarTodas() async {
    try {
      await _httpClient.delete(
        '${ApiEndpoints.galpones}/notifications',
      );

      state = state.copyWith(notifications: []);
    } catch (e) {
      debugPrint('Error limpiando notificaciones: $e');
    }
  }

  /// Recargar notificaciones (pull to refresh)
  Future<void> refrescar() async {
    await cargarNotificaciones();
  }
}

final notificationsControllerProvider =
    StateNotifierProvider<NotificationsController, NotificationsState>(
  (ref) => NotificationsController(),
);
