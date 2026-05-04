import 'package:equatable/equatable.dart';

enum NotificationType {
  info('info'),
  warning('warning'),
  error('error'),
  success('success'),
  alert('alert');

  final String value;
  const NotificationType(this.value);

  factory NotificationType.fromString(String value) {
    return NotificationType.values.firstWhere(
      (t) => t.value == value.toLowerCase(),
      orElse: () => NotificationType.info,
    );
  }

  String get displayName {
    switch (this) {
      case NotificationType.info:
        return 'Información';
      case NotificationType.warning:
        return 'Advertencia';
      case NotificationType.error:
        return 'Error';
      case NotificationType.success:
        return 'Éxito';
      case NotificationType.alert:
        return 'Alerta';
    }
  }
}

class Notification extends Equatable {
  final String id;
  final String title;
  final String message;
  final NotificationType type;
  final DateTime createdAt;
  final bool isRead;
  final String? galponId;
  final String? actionUrl;

  const Notification({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.createdAt,
    this.isRead = false,
    this.galponId,
    this.actionUrl,
  });

  Notification copyWith({
    String? id,
    String? title,
    String? message,
    NotificationType? type,
    DateTime? createdAt,
    bool? isRead,
    String? galponId,
    String? actionUrl,
  }) {
    return Notification(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
      galponId: galponId ?? this.galponId,
      actionUrl: actionUrl ?? this.actionUrl,
    );
  }

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'] ?? '',
      title: json['title'] ?? json['titulo'] ?? '',
      message: json['message'] ?? json['mensaje'] ?? '',
      type: NotificationType.fromString(json['type'] ?? json['tipo'] ?? 'info'),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      isRead: json['is_read'] ?? json['leida'] ?? false,
      galponId: json['galpon_id'],
      actionUrl: json['action_url'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'message': message,
        'type': type.value,
        'created_at': createdAt.toIso8601String(),
        'is_read': isRead,
        'galpon_id': galponId,
        'action_url': actionUrl,
      };

  @override
  List<Object?> get props => [
        id,
        title,
        message,
        type,
        createdAt,
        isRead,
        galponId,
        actionUrl,
      ];
}
