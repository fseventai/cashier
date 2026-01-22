import 'package:cashier/shared/components/apps/command_toolbar_button.dart';
import 'package:cashier/shared/components/apps/custom_vertical_divider.dart';
import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:hugeicons/hugeicons.dart';

class UserToolbar extends StatelessWidget {
  final VoidCallback? onRefresh;
  final VoidCallback? onAdd;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onResetPassword;
  final VoidCallback? onShowInactive;
  final VoidCallback? onHelp;

  const UserToolbar({
    super.key,
    this.onRefresh,
    this.onAdd,
    this.onEdit,
    this.onDelete,
    this.onResetPassword,
    this.onShowInactive,
    this.onHelp,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.surfaceBorder)),
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          CommandToolbarButton(
            icon: HugeIcons.strokeRoundedRefresh,
            label: 'Segarkan',
            onTap: onRefresh ?? () {},
            isDark: isDark,
          ),
          CommandToolbarButton(
            icon: HugeIcons.strokeRoundedAdd01,
            label: 'Add user',
            onTap: onAdd ?? () {},
            isDark: isDark,
            isBold: true,
          ),
          CommandToolbarButton(
            icon: HugeIcons.strokeRoundedPencilEdit02,
            label: 'Edit',
            onTap: onEdit ?? () {},
            isDark: isDark,
            opacity: 0.6,
          ),
          CommandToolbarButton(
            icon: HugeIcons.strokeRoundedDelete02,
            label: 'Hapus',
            onTap: onDelete ?? () {},
            isDark: isDark,
            hoverColor: Colors.red,
            opacity: 0.6,
          ),
          VerticalDivider(),
          CommandToolbarButton(
            icon: HugeIcons.strokeRoundedSecurityPassword,
            label: 'Reset\npassword',
            onTap: onResetPassword ?? () {},
            isDark: isDark,
            opacity: 0.6,
          ),
          CommandToolbarButton(
            icon: HugeIcons
                .strokeRoundedToggleOn, //ing a toggle icon to represent "Show inactive" state
            label: 'Show inactive\nusers',
            onTap: onShowInactive ?? () {},
            isDark: isDark,
            width: 90,
          ),
          CustomVerticalDivider(),
          CommandToolbarButton(
            icon: HugeIcons.strokeRoundedHelpCircle,
            label: 'Bantuan',
            onTap: onHelp ?? () {},
            isDark: isDark,
          ),
        ],
      ),
    );
  }
}
