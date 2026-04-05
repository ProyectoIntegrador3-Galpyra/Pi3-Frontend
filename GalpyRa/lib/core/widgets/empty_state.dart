import 'package:flutter/material.dart';
import '../../config/theme/colors.dart';
import 'app_button.dart';

/// Widget to display empty states
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.message,
    this.title,
    this.icon,
    this.iconWidget,
    this.action,
    this.actionText,
    this.fullScreen = false,
  });

  final String message;
  final String? title;
  final IconData? icon;
  final Widget? iconWidget;
  final VoidCallback? action;
  final String? actionText;
  final bool fullScreen;

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconWidget ??
              Icon(
                icon ?? Icons.inbox_outlined,
                size: 80,
                color: AppColors.textHint,
              ),
          const SizedBox(height: 16),
          if (title != null) ...[
            Text(
              title!,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
          if (action != null && actionText != null) ...[
            const SizedBox(height: 24),
            AppButton(
              text: actionText!,
              onPressed: action,
              type: AppButtonType.primary,
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

  /// Factory for empty list
  factory EmptyState.list({
    String? title,
    String? message,
    VoidCallback? action,
    String? actionText,
    bool fullScreen = false,
  }) {
    return EmptyState(
      title: title ?? 'No hay datos',
      message: message ?? 'No hay elementos para mostrar.',
      icon: Icons.list_alt_outlined,
      action: action,
      actionText: actionText,
      fullScreen: fullScreen,
    );
  }

  /// Factory for empty search results
  factory EmptyState.search({
    String? query,
    bool fullScreen = false,
  }) {
    return EmptyState(
      title: 'Sin resultados',
      message: query != null
          ? 'No se encontraron resultados para "$query".'
          : 'No se encontraron resultados.',
      icon: Icons.search_off,
      fullScreen: fullScreen,
    );
  }

  /// Factory for no galpones
  factory EmptyState.galpones({
    VoidCallback? onCreate,
    bool fullScreen = false,
  }) {
    return EmptyState(
      title: 'Sin galpones',
      message: 'No tienes galpones registrados. Crea uno para comenzar.',
      icon: Icons.home_work_outlined,
      action: onCreate,
      actionText: 'Crear galpón',
      fullScreen: fullScreen,
    );
  }

  /// Factory for no produccion
  factory EmptyState.produccion({
    VoidCallback? onRegister,
    bool fullScreen = false,
  }) {
    return EmptyState(
      title: 'Sin registros',
      message: 'No hay registros de producción para este período.',
      icon: Icons.egg_outlined,
      action: onRegister,
      actionText: 'Registrar producción',
      fullScreen: fullScreen,
    );
  }

  /// Factory for no reportes
  factory EmptyState.reportes({
    VoidCallback? onGenerate,
    bool fullScreen = false,
  }) {
    return EmptyState(
      title: 'Sin reportes',
      message: 'No hay reportes generados. Genera uno para ver los datos.',
      icon: Icons.assessment_outlined,
      action: onGenerate,
      actionText: 'Generar reporte',
      fullScreen: fullScreen,
    );
  }
}
