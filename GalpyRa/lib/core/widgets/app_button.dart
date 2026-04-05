import 'package:flutter/material.dart';
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
class AppButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final buttonWidget = _buildButton(context);
    
    if (isExpanded) {
      return SizedBox(
        width: double.infinity,
        height: height,
        child: buttonWidget,
      );
    }
    
    return SizedBox(
      height: height,
      child: buttonWidget,
    );
  }

  Widget _buildButton(BuildContext context) {
    final effectiveOnPressed = isDisabled || isLoading ? null : onPressed;
    final buttonChild = _buildChild();

    switch (type) {
      case AppButtonType.primary:
        return ElevatedButton(
          onPressed: effectiveOnPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.textOnPrimary,
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            elevation: 0,
            shadowColor: Colors.transparent,
            textStyle: AppTextStyles.button,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ).copyWith(
            overlayColor: WidgetStateProperty.all(Colors.white.withOpacity(0.1)),
          ),
          child: buttonChild,
        );
      
      case AppButtonType.secondary:
        return ElevatedButton(
          onPressed: effectiveOnPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.surfaceVariant,
            foregroundColor: AppColors.primaryDark,
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            elevation: 0,
            shadowColor: Colors.transparent,
            textStyle: AppTextStyles.button.copyWith(color: AppColors.primaryDark),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ).copyWith(
            overlayColor: WidgetStateProperty.all(AppColors.primary.withOpacity(0.08)),
          ),
          child: buttonChild,
        );
      
      case AppButtonType.outline:
        return OutlinedButton(
          onPressed: effectiveOnPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            side: BorderSide(color: AppColors.primary.withOpacity(0.55), width: 1.4),
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            textStyle: AppTextStyles.button.copyWith(color: AppColors.primary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          child: buttonChild,
        );
      
      case AppButtonType.text:
        return TextButton(
          onPressed: effectiveOnPressed,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            textStyle: AppTextStyles.labelLarge.copyWith(color: AppColors.primary),
          ),
          child: buttonChild,
        );
      
      case AppButtonType.danger:
        return ElevatedButton(
          onPressed: effectiveOnPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFDC2626),
            foregroundColor: AppColors.textOnPrimary,
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            elevation: 0,
            shadowColor: Colors.transparent,
            textStyle: AppTextStyles.button,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ).copyWith(
            overlayColor: WidgetStateProperty.all(Colors.white.withOpacity(0.1)),
          ),
          child: buttonChild,
        );
    }
  }

  Widget _buildChild() {
    if (isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(_loadingColor()),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(text),
        ],
      );
    }

    return Text(text);
  }

  Color _loadingColor() {
    switch (type) {
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
