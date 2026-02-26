import 'package:flutter/material.dart';
import '../../config/theme/colors.dart';
import 'app_button.dart';

/// Widget to display error states
class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    required this.message,
    this.title,
    this.icon,
    this.onRetry,
    this.retryText = 'Reintentar',
    this.fullScreen = false,
  });

  final String message;
  final String? title;
  final IconData? icon;
  final VoidCallback? onRetry;
  final String retryText;
  final bool fullScreen;

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon ?? Icons.error_outline,
            size: 64,
            color: AppColors.error,
          ),
          const SizedBox(height: 16),
          if (title != null) ...[
            Text(
              title!,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
          ],
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 24),
            AppButton(
              text: retryText,
              onPressed: onRetry,
              icon: Icons.refresh,
            ),
          ],
        ],
      ),
    );

    if (fullScreen) {
      return Center(child: content);
    }

    return content;
  }

  /// Factory for network error
  factory ErrorView.network({
    VoidCallback? onRetry,
    bool fullScreen = false,
  }) {
    return ErrorView(
      title: 'Sin conexión',
      message: 'No hay conexión a internet. Verifica tu conexión e intenta de nuevo.',
      icon: Icons.wifi_off,
      onRetry: onRetry,
      fullScreen: fullScreen,
    );
  }

  /// Factory for server error
  factory ErrorView.server({
    VoidCallback? onRetry,
    bool fullScreen = false,
  }) {
    return ErrorView(
      title: 'Error del servidor',
      message: 'Hubo un problema con el servidor. Por favor intenta más tarde.',
      icon: Icons.cloud_off,
      onRetry: onRetry,
      fullScreen: fullScreen,
    );
  }

  /// Factory for generic error
  factory ErrorView.generic({
    String? message,
    VoidCallback? onRetry,
    bool fullScreen = false,
  }) {
    return ErrorView(
      title: 'Algo salió mal',
      message: message ?? 'Ha ocurrido un error inesperado. Por favor intenta de nuevo.',
      icon: Icons.error_outline,
      onRetry: onRetry,
      fullScreen: fullScreen,
    );
  }
}
