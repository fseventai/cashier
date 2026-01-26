import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';
import 'package:flutter/material.dart';

class TabsProductGroupDrawer extends StatelessWidget {
  final List<String> tabs;
  final int activeTab;
  final Function(int) onTabChange;

  const TabsProductGroupDrawer({
    super.key,
    required this.tabs,
    required this.onTabChange,
    required this.activeTab,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppColors.slate200)),
      ),
      child: Row(
        children: tabs.asMap().entries.map((entry) {
          final idx = entry.key;
          final label = entry.value;
          final isActive = activeTab == idx;

          return InkWell(
            onTap: () => onTabChange(idx),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              margin: const EdgeInsets.only(right: 24),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isActive ? AppColors.emerald600 : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                label,
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  color: isActive ? AppColors.emerald600 : AppColors.slate500,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
