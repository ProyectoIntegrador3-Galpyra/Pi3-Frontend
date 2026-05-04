import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/route_paths.dart';
import '../../../../config/theme/colors.dart';
import '../../../../config/constants/validators.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/loading.dart';
import '../controllers/auth_controller.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _sent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendRecovery() async {
    if (ref.read(authControllerProvider).isLoading) return;

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final email = _emailController.text.trim();
    final success = await ref
        .read(authControllerProvider.notifier)
        .requestPasswordReset(email);

    if (!mounted) return;

    if (success) {
      setState(() => _sent = true);
    } else {
      final message = ref.read(authControllerProvider).error;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message == null || message.isEmpty
                ? 'Sin conexión. Intenta de nuevo.'
                : message,
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    return AppScaffold(
      title: 'Recuperar contraseña',
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 220),
        child: _sent ? _buildSuccessView() : _buildForm(authState),
      ),
    );
  }

  Widget _buildForm(AuthState authState) {
    return SingleChildScrollView(
      key: const ValueKey('forgot-form'),
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            const Icon(
              Icons.mark_email_unread_outlined,
              size: 80,
              color: AppColors.primaryDark,
            ),
            const SizedBox(height: 20),
            Text(
              'Te enviaremos un enlace para restablecer tu acceso.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: 24),
            AppTextField(
              controller: _emailController,
              label: 'Correo electrónico registrado',
              hint: 'usuario@correo.com',
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: Validators.validateEmail,
            ),
            const SizedBox(height: 20),
            if (authState.isLoading)
              const Center(child: Loading())
            else
              AppButton(
                text: 'Enviar enlace de recuperación',
                onPressed: _sendRecovery,
                isExpanded: true,
              ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => context.go(RoutePaths.login),
              child: const Text('Volver al inicio de sesión'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessView() {
    return SingleChildScrollView(
      key: const ValueKey('forgot-success'),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 28),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFFFDF3DC),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE8D5A3)),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  size: 72,
                  color: Color(0xFF27AE60),
                ),
                const SizedBox(height: 16),
                Text(
                  'Revisa tu correo',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryDark,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Si el correo está registrado, recibirás un enlace para restablecer tu contraseña.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          AppButton(
            text: 'Volver al inicio de sesión',
            onPressed: () => context.go(RoutePaths.login),
            isExpanded: true,
          ),
        ],
      ),
    );
  }
}
