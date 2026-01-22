import 'package:flutter/material.dart';
import 'package:cashier/core/constants/app_colors.dart';
import 'package:cashier/core/constants/app_text_styles.dart';
import 'package:hugeicons/hugeicons.dart';

class ManagementHeader extends StatelessWidget {
  final List<String> breadcrumbs;
  final VoidCallback onClose;

  const ManagementHeader({
    super.key,
    required this.breadcrumbs,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.slate900 : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: isDark ? AppColors.slate700 : AppColors.slate200,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Breadcrumbs
          Row(
            children: breadcrumbs.asMap().entries.map((entry) {
              final idx = entry.key;
              final text = entry.value;
              final isLast = idx == breadcrumbs.length - 1;

              return Row(
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Text(
                      text,
                      style: AppTextStyles.bodyXSmall.copyWith(
                        fontWeight: isLast ? FontWeight.w600 : FontWeight.w500,
                        color: isLast
                            ? (isDark ? AppColors.slate200 : AppColors.slate800)
                            : AppColors.slate500,
                      ),
                    ),
                  ),
                  if (!isLast)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppColors.slate600
                              : AppColors.slate300,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              );
            }).toList(),
          ),

          // Close button
          IconButton(
            onPressed: onClose,
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedCancel01,
              size: 18,
              color: AppColors.slate400,
            ),
            hoverColor: Colors.red.withValues(alpha: 0.5),
            highlightColor: Colors.red.withValues(alpha: 0.2),
            splashRadius: 16,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}
