/// Roles de usuario para el sistema
enum UserRole {
  admin,
  manager,
  supervisor,
  operator,
  viewer;

  static UserRole fromString(String value) {
    final normalized = value.trim().toLowerCase();
    return UserRole.values.firstWhere(
      (role) => role.name == normalized,
      orElse: () => UserRole.viewer,
    );
  }
}

extension UserRoleExtension on UserRole {
  String get displayName {
    switch (this) {
      case UserRole.admin:
        return 'Administrador';
      case UserRole.manager:
        return 'Gerente';
      case UserRole.supervisor:
        return 'Supervisor';
      case UserRole.operator:
        return 'Operador';
      case UserRole.viewer:
        return 'Observador';
    }
  }

  String get value => name;

  bool get canManageUsers => this == UserRole.admin;

  bool get canEditData => this != UserRole.viewer;

  bool get canViewReports => true;
}
