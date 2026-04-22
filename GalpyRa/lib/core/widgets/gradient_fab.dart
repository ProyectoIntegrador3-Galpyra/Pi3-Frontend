import 'package:flutter/material.dart';
import '../../config/theme/colors.dart';

/// Custom FloatingActionButton with solid background
class GradientFAB extends StatelessWidget {
  const GradientFAB({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon = Icons.add,
    this.heroTag,
    this.gradientColors,
  });

  final VoidCallback onPressed;
  final String label;
  final IconData icon;
  final Object? heroTag;
  final List<Color>? gradientColors;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = gradientColors?.first ?? AppColors.primary;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          splashColor: Colors.white.withOpacity(0.2),
          highlightColor: Colors.white.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 22,
                ),
                const SizedBox(width: 10),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    letterSpacing: 0.5,
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

/// Solid FAB with soft yellow variant
class GradientFABSecondary extends StatelessWidget {
  const GradientFABSecondary({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon = Icons.add,
    this.heroTag,
  });

  final VoidCallback onPressed;
  final String label;
  final IconData icon;
  final Object? heroTag;

  @override
  Widget build(BuildContext context) {
    return GradientFAB(
      onPressed: onPressed,
      label: label,
      icon: icon,
      heroTag: heroTag,
      gradientColors: [
        AppColors.secondary,
      ],
    );
  }
}

/// Warning style FAB (for actions like mortality)
class GradientFABWarning extends StatelessWidget {
  const GradientFABWarning({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon = Icons.warning_amber_outlined,
    this.heroTag,
  });

  final VoidCallback onPressed;
  final String label;
  final IconData icon;
  final Object? heroTag;

  @override
  Widget build(BuildContext context) {
    return GradientFAB(
      onPressed: onPressed,
      label: label,
      icon: icon,
      heroTag: heroTag,
      gradientColors: [
        AppColors.warning,
      ],
    );
  }
}
