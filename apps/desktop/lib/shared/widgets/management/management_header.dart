import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';
import 'package:cashier/shared/models/breadcrumb_item.dart';
import 'package:flutter/material.dart';

class ManagementHeader extends StatelessWidget {
  final List<BreadcrumbItem> items; // Gunakan model kita
  final VoidCallback onClose;

  const ManagementHeader({
    super.key,
    required this.items,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 48, // Sedikit lebih tinggi agar nyaman diklik
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
        children: [_buildBreadcrumbs(isDark), _buildCloseButton()],
      ),
    );
  }

  Widget _buildBreadcrumbs(bool isDark) {
    return Row(
      children: items.asMap().entries.map((entry) {
        final idx = entry.key;
        final item = entry.value;
        final isLast = idx == items.length - 1;

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              // Gunakan InkWell agar ada feedback saat diklik
              onTap: item.onTap,
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Text(
                  item.label,
                  style: AppTextStyles.bodyXSmall.copyWith(
                    fontWeight: isLast ? FontWeight.w600 : FontWeight.w500,
                    color: isLast
                        ? (isDark ? AppColors.slate200 : AppColors.slate800)
                        : AppColors.slate500,
                  ),
                ),
              ),
            ),
            if (!isLast) _buildSeparator(isDark),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildSeparator(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Icon(
        Icons
            .chevron_right_rounded, // Chevron biasanya lebih standar untuk breadcrumbs
        size: 16,
        color: isDark ? AppColors.slate600 : AppColors.slate300,
      ),
    );
  }

  Widget _buildCloseButton() {
    return IconButton(
      onPressed: onClose,
      icon: const Icon(Icons.close, size: 18),
    );
  }
}
