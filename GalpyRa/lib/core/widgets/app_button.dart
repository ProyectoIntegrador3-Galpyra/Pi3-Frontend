import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../config/theme/colors.dart';
import '../../config/theme/text_styles.dart';

/// Types of buttons available
enum AppButtonType {
  primary,
  secondary,
  outline,
  text,
  danger,
}

/// Reusable button widget with consistent styling
class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = AppButtonType.primary,
    this.icon,
    this.isLoading = false,
    this.isDisabled = false,
    this.isExpanded = false,
    this.height = 52,
    this.borderRadius = 12,
    this.padding,
  });

  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final IconData? icon;
  final bool isLoading;
  final bool isDisabled;
  final bool isExpanded;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final buttonWidget = _buildButton(context);

    final sizedButton = widget.isExpanded
        ? SizedBox(
            width: double.infinity,
            height: widget.height,
            child: buttonWidget,
          )
        : SizedBox(
            height: widget.height,
            child: buttonWidget,
          );

    return Listener(
      onPointerDown:
          widget.onPressed == null || widget.isDisabled || widget.isLoading
              ? null
              : (_) => setState(() => _pressed = true),
      onPointerUp:
          widget.onPressed == null || widget.isDisabled || widget.isLoading
              ? null
              : (_) => setState(() => _pressed = false),
      onPointerCancel:
          widget.onPressed == null || widget.isDisabled || widget.isLoading
              ? null
              : (_) => setState(() => _pressed = false),
      child: sizedButton.animate(target: _pressed ? 1 : 0).scale(
            begin: const Offset(1, 1),
            end: const Offset(0.97, 0.97),
            duration: 80.ms,
          ),
    );
  }

  Widget _buildButton(BuildContext context) {
    final effectiveOnPressed =
        widget.isDisabled || widget.isLoading ? null : widget.onPressed;
    final buttonChild = _buildChild();

    switch (widget.type) {
      case AppButtonType.primary:
        return ElevatedButton(
          onPressed: effectiveOnPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD4920A),
            foregroundColor: AppColors.textOnPrimary,
            padding: widget.padding ??
                const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            elevation: 2,
            shadowColor: const Color(0xFFD4920A).withOpacity(0.3),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
          ).copyWith(
            overlayColor:
                WidgetStateProperty.all(Colors.white.withOpacity(0.1)),
          ),
          child: buttonChild,
        );

      case AppButtonType.secondary:
        return ElevatedButton(
          onPressed: effectiveOnPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.surfaceVariant,
            foregroundColor: AppColors.primaryDark,
            padding: widget.padding ??
                const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            elevation: 0,
            shadowColor: Colors.transparent,
            textStyle:
                AppTextStyles.button.copyWith(color: AppColors.primaryDark),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
          ).copyWith(
            overlayColor:
                WidgetStateProperty.all(AppColors.primary.withOpacity(0.08)),
          ),
          child: buttonChild,
        );

      case AppButtonType.outline:
        return OutlinedButton(
          onPressed: effectiveOnPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            side: BorderSide(
                color: AppColors.primary.withOpacity(0.55), width: 1.4),
            padding: widget.padding ??
                const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            textStyle: AppTextStyles.button.copyWith(color: AppColors.primary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
          ),
          child: buttonChild,
        );

      case AppButtonType.text:
        return TextButton(
          onPressed: effectiveOnPressed,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            padding: widget.padding ??
                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            textStyle:
                AppTextStyles.labelLarge.copyWith(color: AppColors.primary),
          ),
          child: buttonChild,
        );

      case AppButtonType.danger:
        return ElevatedButton(
          onPressed: effectiveOnPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFDC2626),
            foregroundColor: AppColors.textOnPrimary,
            padding: widget.padding ??
                const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            elevation: 0,
            shadowColor: Colors.transparent,
            textStyle: AppTextStyles.button,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
          ).copyWith(
            overlayColor:
                WidgetStateProperty.all(Colors.white.withOpacity(0.1)),
          ),
          child: buttonChild,
        );
    }
  }

  Widget _buildChild() {
    if (widget.isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(_loadingColor()),
        ),
      );
    }

    if (widget.icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(widget.icon, size: 20),
          const SizedBox(width: 8),
          Text(widget.text),
        ],
      );
    }

    return Text(widget.text);
  }

  Color _loadingColor() {
    switch (widget.type) {
      case AppButtonType.primary:
      case AppButtonType.danger:
        return AppColors.textOnPrimary;
      case AppButtonType.secondary:
      case AppButtonType.outline:
      case AppButtonType.text:
        return AppColors.primary;
    }
  }
}
