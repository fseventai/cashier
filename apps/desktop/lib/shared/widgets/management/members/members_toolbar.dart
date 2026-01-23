import 'package:cashier/shared/components/apps/command_toolbar_button.dart';
import 'package:cashier/shared/components/apps/custom_vertical_divider.dart';
import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:hugeicons/hugeicons.dart';

class MembersToolbar extends StatelessWidget {
  final VoidCallback? onRefresh;
  final VoidCallback? onAdd;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onImport;
  final VoidCallback? onExport;
  final VoidCallback? onHelp;

  const MembersToolbar({
    super.key,
    this.onRefresh,
    this.onAdd,
    this.onEdit,
    this.onDelete,
    this.onImport,
    this.onExport,
    this.onHelp,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? AppColors.slate800 : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: isDark ? AppColors.slate700 : AppColors.slate200,
          ),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            CommandToolbarButton(
              icon: HugeIcons.strokeRoundedRefresh,
              label: 'Segarkan',
              onTap: onRefresh ?? () {},
              isDark: isDark,
            ),
            CustomVerticalDivider(isDark: isDark),
            CommandToolbarButton(
              icon: HugeIcons.strokeRoundedAdd01,
              label: 'Tambah',
              onTap: onAdd ?? () {},
              isDark: isDark,
              iconColor: AppColors.emerald600,
              forceIconBold: true,
            ),
            CommandToolbarButton(
              icon: HugeIcons.strokeRoundedPencilEdit02,
              label: 'Edit',
              onTap: onEdit ?? () {},
              isDark: isDark,
              isEnabled: onEdit != null,
            ),
            CommandToolbarButton(
              icon: HugeIcons.strokeRoundedDelete02,
              label: 'Hapus',
              onTap: onDelete ?? () {},
              isDark: isDark,
              isEnabled: onDelete != null,
              hoverColor: Colors.red,
            ),
            CustomVerticalDivider(isDark: isDark),
            CommandToolbarButton(
              icon: HugeIcons.strokeRoundedDownload02,
              label: 'Import',
              onTap: onImport ?? () {},
              isDark: isDark,
            ),
            CommandToolbarButton(
              icon: HugeIcons.strokeRoundedUpload02,
              label: 'Export',
              onTap: onExport ?? () {},
              isDark: isDark,
            ),
          ],
        ),
      ),
    );
  }
}
