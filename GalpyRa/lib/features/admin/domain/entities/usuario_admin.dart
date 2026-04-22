import 'package:equatable/equatable.dart';

import '../../../../shared/enums/user_role.dart';

/// Entidad para gestion de usuarios en panel admin.
class UsuarioAdmin extends Equatable {
  final String id;
  final String email;
  final String nombre;
  final UserRole role;
  final String? phone;
  final DateTime createdAt;

  const UsuarioAdmin({
    required this.id,
    required this.email,
    required this.nombre,
    required this.role,
    this.phone,
    required this.createdAt,
  });

  UsuarioAdmin copyWith({
    String? id,
    String? email,
    String? nombre,
    UserRole? role,
    String? phone,
    DateTime? createdAt,
  }) {
    return UsuarioAdmin(
      id: id ?? this.id,
      email: email ?? this.email,
      nombre: nombre ?? this.nombre,
      role: role ?? this.role,
      phone: phone ?? this.phone,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, email, nombre, role, phone, createdAt];
}
