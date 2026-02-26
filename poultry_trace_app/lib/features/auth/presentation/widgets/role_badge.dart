import 'package:flutter/material.dart';
import '../../../../config/theme/colors.dart';
import '../../../../shared/enums/user_role.dart';

/// Badge widget to display user role
class RoleBadge extends StatelessWidget {
  const RoleBadge({
    super.key,
    required this.role,
    this.size = RoleBadgeSize.medium,
  });

  final UserRole role;
  final RoleBadgeSize size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size == RoleBadgeSize.small ? 8 : 12,
        vertical: size == RoleBadgeSize.small ? 4 : 6,
      ),
      decoration: BoxDecoration(
        color: _getColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _getColor().withOpacity(0.5),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getIcon(),
            size: size == RoleBadgeSize.small ? 12 : 16,
            color: _getColor(),
          ),
          const SizedBox(width: 4),
          Text(
            role.displayName,
            style: TextStyle(
              color: _getColor(),
              fontSize: size == RoleBadgeSize.small ? 10 : 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Color _getColor() {
    switch (role) {
      case UserRole.admin:
        return AppColors.error;
      case UserRole.manager:
        return AppColors.warning;
      case UserRole.supervisor:
        return AppColors.info;
      case UserRole.operator:
        return AppColors.success;
      case UserRole.viewer:
        return AppColors.textSecondary;
    }
  }

  IconData _getIcon() {
    switch (role) {
      case UserRole.admin:
        return Icons.admin_panel_settings;
      case UserRole.manager:
        return Icons.manage_accounts;
      case UserRole.supervisor:
        return Icons.supervisor_account;
      case UserRole.operator:
        return Icons.person;
      case UserRole.viewer:
        return Icons.visibility;
    }
  }
}

enum RoleBadgeSize { small, medium }
