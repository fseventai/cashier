import 'package:cashier/shared/components/apps/command_toolbar_button.dart';
import 'package:cashier/shared/components/apps/custom_vertical_divider.dart';
import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:hugeicons/hugeicons.dart';

class StockToolbar extends StatelessWidget {
  const StockToolbar({super.key});

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
            onTap: () {},
            isDark: isDark,
          ),
          CustomVerticalDivider(),
          CommandToolbarButton(
            icon: HugeIcons.strokeRoundedTime01,
            label: 'Stock history',
            onTap: () {},
            isDark: isDark,
          ),
          CustomVerticalDivider(),
          CommandToolbarButton(
            icon: HugeIcons.strokeRoundedPrinter,
            label: 'Cetak',
            onTap: () {},
            isDark: isDark,
          ),
          CommandToolbarButton(
            icon: HugeIcons.strokeRoundedFile02,
            label: 'Simpan PDF',
            onTap: () {},
            isDark: isDark,
          ),
          CommandToolbarButton(
            icon: HugeIcons.strokeRoundedGrid,
            label: 'Excel',
            onTap: () {},
            isDark: isDark,
          ),
          CustomVerticalDivider(),
          CommandToolbarButton(
            icon: HugeIcons.strokeRoundedTask01,
            label: 'Inventory count',
            onTap: () {},
            isDark: isDark,
            width: 90,
          ),
          CommandToolbarButton(
            icon: HugeIcons.strokeRoundedEnergy,
            label: 'Quick inventory',
            onTap: () {},
            isDark: isDark,
            width: 90,
          ),
        ],
      ),
    );
  }
}
