import 'package:cashier/core/constants/app_colors.dart';
import 'package:cashier/shared/components/apps/command_toolbar_button.dart';
import 'package:cashier/shared/components/apps/custom_vertical_divider.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class TaxRatesToolbar extends StatelessWidget {
  final VoidCallback? onRefresh;
  final VoidCallback? onAdd;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onSwitch;
  final VoidCallback? onHelp;

  const TaxRatesToolbar({
    super.key,
    this.onRefresh,
    this.onAdd,
    this.onEdit,
    this.onDelete,
    this.onSwitch,
    this.onHelp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.surfaceBorder)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommandToolbarButton(
            icon: HugeIcons.strokeRoundedRefresh,
            label: 'Segarkan',
            onTap: () {},
          ),
          CustomVerticalDivider(),
          CommandToolbarButton(
            icon: HugeIcons.strokeRoundedAddCircle,
            label: 'New tax rate',
            onTap: onAdd ?? () {},
          ),
          CommandToolbarButton(
            icon: HugeIcons.strokeRoundedEdit01,
            label: 'Edit',
            isEnabled: false,
            onTap: onEdit ?? () {},
          ),
          CommandToolbarButton(
            icon: HugeIcons.strokeRoundedDelete04,
            label: 'Hapus',
            isEnabled: false,
            onTap: onDelete ?? () {},
          ),
          CustomVerticalDivider(),
          CommandToolbarButton(
            icon: HugeIcons.strokeRoundedArrowLeftRight,
            label: 'Switch taxes',
            onTap: onSwitch ?? () {},
          ),
          CustomVerticalDivider(),
          CommandToolbarButton(
            icon: HugeIcons.strokeRoundedHelpCircle,
            label: 'Bantuan',
            onTap: onHelp ?? () {},
          ),
        ],
      ),
    );
  }
}
