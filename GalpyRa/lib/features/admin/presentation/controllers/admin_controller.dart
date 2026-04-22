import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/di/injector.dart';
import '../../../../core/errors/failure_message_mapper.dart';
import '../../domain/entities/usuario_admin.dart';
import '../../domain/usecases/actualizar_usuario.dart';
import '../../domain/usecases/crear_usuario.dart';
import '../../domain/usecases/eliminar_usuario.dart';
import '../../domain/usecases/listar_usuarios.dart';

class AdminState {
  final List<UsuarioAdmin> usuarios;
  final bool isLoading;
  final String? error;
  final bool isSubmitting;

  const AdminState({
    this.usuarios = const [],
    this.isLoading = false,
    this.error,
    this.isSubmitting = false,
  });

  AdminState copyWith({
    List<UsuarioAdmin>? usuarios,
    bool? isLoading,
    String? error,
    bool? isSubmitting,
    bool clearError = false,
  }) {
    return AdminState(
      usuarios: usuarios ?? this.usuarios,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : error,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}

class AdminController extends StateNotifier<AdminState> {
  final ListarUsuariosUseCase _listarUsuarios;
  final CrearUsuarioUseCase _crearUsuario;
  final ActualizarUsuarioUseCase _actualizarUsuario;
  final EliminarUsuarioUseCase _eliminarUsuario;

  AdminController()
      : _listarUsuarios = getIt<ListarUsuariosUseCase>(),
        _crearUsuario = getIt<CrearUsuarioUseCase>(),
        _actualizarUsuario = getIt<ActualizarUsuarioUseCase>(),
        _eliminarUsuario = getIt<EliminarUsuarioUseCase>(),
        super(const AdminState());

  Future<void> cargarUsuarios() async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _listarUsuarios();
    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: mapFailureMessage(failure),
        );
      },
      (usuarios) {
        state = state.copyWith(
          isLoading: false,
          usuarios: usuarios,
        );
      },
    );
  }

  Future<bool> crearUsuario({
    required String nombre,
    required String email,
    required String password,
    required String role,
  }) async {
    state = state.copyWith(isSubmitting: true, clearError: true);

    final result = await _crearUsuario(
      nombre: nombre,
      email: email,
      password: password,
      role: role,
    );

    return result.fold(
      (failure) {
        state = state.copyWith(
          isSubmitting: false,
          error: mapFailureMessage(failure),
        );
        return false;
      },
      (usuario) {
        state = state.copyWith(
          isSubmitting: false,
          usuarios: [...state.usuarios, usuario],
        );
        return true;
      },
    );
  }

  Future<bool> actualizarUsuario(
    String id, {
    String? nombre,
    String? email,
    String? password,
    String? role,
  }) async {
    state = state.copyWith(isSubmitting: true, clearError: true);

    final result = await _actualizarUsuario(
      id,
      nombre: nombre,
      email: email,
      password: password,
      role: role,
    );

    return result.fold(
      (failure) {
        state = state.copyWith(
          isSubmitting: false,
          error: mapFailureMessage(failure),
        );
        return false;
      },
      (usuario) {
        final usuarios = state.usuarios
            .map((item) => item.id == usuario.id ? usuario : item)
            .toList();

        state = state.copyWith(
          isSubmitting: false,
          usuarios: usuarios,
        );
        return true;
      },
    );
  }

  Future<bool> eliminarUsuario(String id) async {
    state = state.copyWith(isSubmitting: true, clearError: true);

    final result = await _eliminarUsuario(id);

    return result.fold(
      (failure) {
        state = state.copyWith(
          isSubmitting: false,
          error: mapFailureMessage(failure),
        );
        return false;
      },
      (_) {
        final usuarios = state.usuarios.where((item) => item.id != id).toList();
        state = state.copyWith(
          isSubmitting: false,
          usuarios: usuarios,
        );
        return true;
      },
    );
  }
}

final adminControllerProvider =
    StateNotifierProvider<AdminController, AdminState>(
  (ref) => AdminController(),
);
