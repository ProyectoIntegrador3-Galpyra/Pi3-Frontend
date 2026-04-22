import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/routes/route_paths.dart';
import '../../../../config/constants/validators.dart';
import '../../../../config/theme/colors.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../controllers/auth_controller.dart';

/// Login page
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (ref.read(authControllerProvider).isLoading) return;

    ref.read(authControllerProvider.notifier).clearError();

    if (_formKey.currentState?.validate() ?? false) {
      final normalizedEmail = _emailController.text.trim().replaceFirst(
            RegExp(r'\.+$'),
            '',
          );
      final normalizedPassword = _passwordController.text.trim();

      if (normalizedEmail != _emailController.text) {
        _emailController.text = normalizedEmail;
      }

      final success = await ref.read(authControllerProvider.notifier).login(
            normalizedEmail,
            normalizedPassword,
          );

      if (success && mounted) {
        context.go(RoutePaths.home);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final theme = Theme.of(context);

    return AppScaffold(
      showBackButton: false,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.egg_outlined,
                        size: 52,
                        color: AppColors.textOnPrimary,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'GALPyra',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textOnPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Gestión Avícola y Trazabilidad Productiva',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.textOnPrimary.withOpacity(0.9),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Iniciar sesión',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryDark,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Ingresa tus credenciales para continuar',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 18),

                      // Error message
                      if (authState.error != null) ...[
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.error.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.error_outline,
                                color: AppColors.error,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  authState.error!,
                                  style:
                                      const TextStyle(color: AppColors.error),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],

                      AppTextField(
                        controller: _emailController,
                        label: 'Correo electrónico',
                        hint: 'usuario@correo.com',
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: Validators.validateEmail,
                      ),
                      const SizedBox(height: 16),

                      AppTextField(
                        controller: _passwordController,
                        label: 'Contraseña',
                        hint: '••••••••',
                        prefixIcon: Icons.lock_outlined,
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        validator: Validators.validatePassword,
                        onSubmitted: (_) => _handleLogin(),
                      ),
                      const SizedBox(height: 8),

                      const SizedBox(height: 16),

                      AppButton(
                        text: 'Iniciar sesión',
                        onPressed: _handleLogin,
                        isLoading: authState.isLoading,
                        isExpanded: true,
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
}
