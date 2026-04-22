import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/constants/validators.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../domain/entities/usuario_admin.dart';
import '../controllers/admin_controller.dart';

/// Roles disponibles en el backend: (valor_backend, etiqueta_display)
const _kRoles = [
  ('ADMIN', 'Administrador'),
  ('PRODUCTOR', 'Productor'),
  ('TECNICO', 'Técnico'),
];

/// Convierte el UserRole del dominio al valor string del backend.
String _roleDomainToBackend(dynamic role) {
  final name = role?.toString().split('.').last.toLowerCase() ?? '';
  if (name == 'admin') return 'ADMIN';
  if (name == 'tecnico') return 'TECNICO';
  return 'PRODUCTOR';
}

class AdminUsuarioFormPage extends ConsumerStatefulWidget {
  final String? userId;

  const AdminUsuarioFormPage({
    super.key,
    this.userId,
  });

  @override
  ConsumerState<AdminUsuarioFormPage> createState() =>
      _AdminUsuarioFormPageState();
}

class _AdminUsuarioFormPageState extends ConsumerState<AdminUsuarioFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  String _rolBackend = 'PRODUCTOR';

  bool get isEditing => widget.userId != null;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final notifier = ref.read(adminControllerProvider.notifier);
      if (ref.read(adminControllerProvider).usuarios.isEmpty) {
        await notifier.cargarUsuarios();
      }

      if (!mounted || !isEditing) return;

      final user = ref
          .read(adminControllerProvider)
          .usuarios
          .where((u) => u.id == widget.userId)
          .cast<UsuarioAdmin?>()
          .firstWhere((u) => u != null, orElse: () => null);

      if (user != null) {
        _nombreCtrl.text = user.nombre;
        _emailCtrl.text = user.email;
        _rolBackend = _roleDomainToBackend(user.role);
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final notifier = ref.read(adminControllerProvider.notifier);

    final ok = isEditing
        ? await notifier.actualizarUsuario(
            widget.userId!,
            nombre: _nombreCtrl.text.trim(),
            email: _emailCtrl.text.trim(),
            password: _passwordCtrl.text.trim().isEmpty
                ? null
                : _passwordCtrl.text.trim(),
            role: _rolBackend,
          )
        : await notifier.crearUsuario(
            nombre: _nombreCtrl.text.trim(),
            email: _emailCtrl.text.trim(),
            password: _passwordCtrl.text.trim(),
            role: _rolBackend,
          );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok
              ? (isEditing ? 'Usuario actualizado' : 'Usuario creado')
              : 'No se pudo guardar el usuario',
        ),
      ),
    );

    if (ok) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(adminControllerProvider);

    return AppScaffold(
      title: isEditing ? 'Editar usuario' : 'Nuevo usuario',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppTextField(
                controller: _nombreCtrl,
                label: 'Nombre *',
                hint: 'Nombre del usuario',
                prefixIcon: Icons.person_outline,
                validator: (v) => Validators.validateRequired(v, 'El nombre'),
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: _emailCtrl,
                label: 'Email *',
                hint: 'usuario@correo.com',
                prefixIcon: Icons.email_outlined,
                validator: Validators.validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              if (!isEditing)
                AppTextField(
                  controller: _passwordCtrl,
                  label: 'Contraseña *',
                  hint: 'Mínimo 8 caracteres',
                  obscureText: true,
                  prefixIcon: Icons.lock_outline,
                  validator: Validators.validatePassword,
                ),
              if (isEditing)
                AppTextField(
                  controller: _passwordCtrl,
                  label: 'Contraseña (opcional)',
                  hint: 'Dejar vacío para no cambiarla',
                  obscureText: true,
                  prefixIcon: Icons.lock_outline,
                ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _rolBackend,
                decoration: const InputDecoration(
                  labelText: 'Rol *',
                  prefixIcon: Icon(Icons.badge_outlined),
                ),
                items: _kRoles
                    .map(
                      (r) => DropdownMenuItem<String>(
                        value: r.$1,
                        child: Text(r.$2),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() => _rolBackend = value);
                },
              ),
              const SizedBox(height: 24),
              if (state.error != null) ...[
                Text(
                  state.error!,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 12),
              ],
              AppButton(
                text: isEditing ? 'Guardar cambios' : 'Crear usuario',
                isExpanded: true,
                isLoading: state.isSubmitting,
                onPressed: _guardar,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
