import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';

class DashboardStatCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  final double? height;
  final CrossAxisAlignment crossAxisAlignment;

  const DashboardStatCard({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.height,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: height,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? AppColors.slate800 : AppColors.surface,
        borderRadius: BorderRadius.circular(12), // xl
        border: Border.all(
          color: isDark ? AppColors.slate700 : AppColors.slate100,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Text(
            title,
            style: AppTextStyles.h3.copyWith(
              color: isDark ? AppColors.slate300 : AppColors.slate600,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              style: AppTextStyles.bodySmall.copyWith(
                color: isDark ? AppColors.slate500 : AppColors.slate400,
                fontSize: 12,
              ),
            ),
          ],
          const SizedBox(height: 16),
          Expanded(child: child),
        ],
      ),
    );
  }
}
