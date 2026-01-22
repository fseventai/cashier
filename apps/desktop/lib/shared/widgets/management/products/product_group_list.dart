import 'package:flutter/material.dart';
import 'package:cashier/core/constants/app_colors.dart';
import 'package:cashier/core/constants/app_text_styles.dart';
import 'package:hugeicons/hugeicons.dart';

class ProductGroupList extends StatelessWidget {
  const ProductGroupList({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: isDark ? AppColors.slate900 : Colors.white,
        border: Border(
          right: BorderSide(
            color: isDark ? AppColors.slate700 : AppColors.slate200,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.emerald600,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  const HugeIcon(
                    icon: HugeIcons.strokeRoundedFolderOpen,
                    size: 18,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Products',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 24),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: isDark ? AppColors.slate700 : AppColors.slate200,
                  ),
                ),
              ),
              child: const SizedBox.expand(), // Empty for now, as in design
            ),
          ),
        ],
      ),
    );
  }
}
