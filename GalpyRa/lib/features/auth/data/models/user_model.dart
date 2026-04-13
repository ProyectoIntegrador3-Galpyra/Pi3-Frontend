import '../../domain/entities/user.dart';
import '../../../../shared/enums/user_role.dart';

/// User model for API serialization
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    required super.name,
    super.phone,
    required super.role,
    super.avatarUrl,
    required super.createdAt,
    super.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final id = (json['id'] ?? '').toString();
    final email = (json['email'] ?? '').toString();
    final name = (json['name'] ?? json['nombre'] ?? '').toString();
    final roleValue = (json['role'] ?? json['rol'] ?? '').toString();

    if (id.isEmpty || email.isEmpty || name.isEmpty) {
      throw const FormatException('Respuesta de usuario incompleta');
    }

    final createdAtRaw = json['created_at'] ?? json['createdAt'];
    final createdAt = createdAtRaw is String && createdAtRaw.isNotEmpty
        ? DateTime.parse(createdAtRaw)
        : DateTime.now();

    final updatedAtRaw = json['updated_at'] ?? json['updatedAt'];

    return UserModel(
      id: id,
      email: email,
      name: name,
      phone: json['phone'] as String?,
      role: UserRoleExtension.fromString(roleValue),
      avatarUrl: json['avatar_url'] as String?,
      createdAt: createdAt,
      updatedAt: updatedAtRaw is String && updatedAtRaw.isNotEmpty
          ? DateTime.parse(updatedAtRaw)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'role': role.value,
      'avatar_url': avatarUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      email: user.email,
      name: user.name,
      phone: user.phone,
      role: user.role,
      avatarUrl: user.avatarUrl,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
    );
  }
}
