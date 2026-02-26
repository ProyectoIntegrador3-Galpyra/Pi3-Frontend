/// Roles de usuario para el sistema
enum UserRole {
  admin,
  manager,
  supervisor,
  operator,
  viewer,
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

  String get value {
    return name;
  }

  static UserRole fromString(String value) {
    return UserRole.values.firstWhere(
      (role) => role.name == value,
      orElse: () => UserRole.viewer,
    );
  }

  bool get canManageUsers {
    return this == UserRole.admin;
  }

  bool get canEditData {
    return this != UserRole.viewer;
  }

  bool get canViewReports {
    return true;
  }
}
