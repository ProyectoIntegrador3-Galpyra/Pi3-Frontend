import '../../../../core/network/api_response_parser.dart';
import '../../../../shared/enums/user_role.dart';
import '../../domain/entities/usuario_admin.dart';

class UsuarioAdminModel extends UsuarioAdmin {
  const UsuarioAdminModel({
    required super.id,
    required super.email,
    required super.nombre,
    required super.role,
    super.phone,
    required super.createdAt,
  });

  factory UsuarioAdminModel.fromJson(Map<String, dynamic> json) {
    final id = (json['id'] ?? '').toString();
    final email = (json['email'] ?? '').toString();
    final nombre = (json['nombre'] ?? json['name'] ?? '').toString();
    final roleText = (json['role'] ?? json['rol'] ?? 'viewer').toString();

    final createdAtRaw = json['created_at'] ?? json['createdAt'];
    final createdAt = createdAtRaw is String && createdAtRaw.isNotEmpty
        ? DateTime.tryParse(createdAtRaw) ?? DateTime.now()
        : DateTime.now();

    return UsuarioAdminModel(
      id: id,
      email: email,
      nombre: nombre,
      role: UserRole.fromString(roleText),
      phone: json['phone']?.toString(),
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'nombre': nombre,
      'role': role.value,
      'phone': phone,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory UsuarioAdminModel.fromEntity(UsuarioAdmin entity) {
    return UsuarioAdminModel(
      id: entity.id,
      email: entity.email,
      nombre: entity.nombre,
      role: entity.role,
      phone: entity.phone,
      createdAt: entity.createdAt,
    );
  }

  static List<UsuarioAdminModel> fromList(dynamic body) {
    final list = ApiResponseParser.extractDataList(body);
    return list
        .map((item) => UsuarioAdminModel.fromJson(ApiResponseParser.asMap(item)))
        .toList();
  }
}
