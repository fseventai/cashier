import 'package:flutter/material.dart';
import 'package:cashier/core/constants/app_colors.dart';
import 'package:cashier/core/constants/app_text_styles.dart';
import 'package:hugeicons/hugeicons.dart';

class ProductContentArea extends StatelessWidget {
  const ProductContentArea({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      color: isDark ? AppColors.slate900 : Colors.white,
      child: Column(
        children: [
          // Search/Filter Bar
          _buildFilterBar(isDark),

          // Main Content Area (Empty State)
          Expanded(
            child: Container(
              color: isDark
                  ? Colors.transparent
                  : AppColors.slate50.withValues(alpha: 0.3),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Visibility Off Icon
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.slate800 : AppColors.slate100,
                      shape: BoxShape.circle,
                    ),
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedViewOff,
                      size: 48,
                      color: isDark ? AppColors.slate600 : AppColors.slate300,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Selected group contains no products',
                    style: AppTextStyles.h3.copyWith(
                      color: isDark ? AppColors.slate300 : AppColors.slate600,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLinkText('Add new product', isDark),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          'or',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: isDark
                                ? AppColors.slate500
                                : AppColors.slate400,
                          ),
                        ),
                      ),
                      _buildLinkText('new product group', isDark),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar(bool isDark) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isDark ? AppColors.slate700 : AppColors.slate200,
          ),
        ),
      ),
      child: Row(
        children: [
          // Search Indicators
          _buildSearchIndicator(
            HugeIcons.strokeRoundedSquare,
            isDark: isDark,
            title: 'Wildcard Search',
          ),
          _buildSearchIndicator(
            HugeIcons.strokeRoundedBarCode01,
            isDark: isDark,
            title: 'Barcode',
          ),
          _buildSearchIndicator(
            HugeIcons.strokeRounded1stBracket,
            isDark: isDark,
            title: 'Number',
          ),
          _buildSearchIndicator(
            HugeIcons.strokeRoundedTShirt,
            isDark: isDark,
            title: 'Name',
            isSelected: true,
          ),

          // Search Field
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Nama Produk',
                  hintStyle: AppTextStyles.bodySmall.copyWith(
                    color: isDark ? AppColors.slate500 : AppColors.slate400,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  suffixIcon: HugeIcon(
                    icon: HugeIcons.strokeRoundedSearch01,
                    size: 18,
                    color: AppColors.slate400,
                  ),
                  suffixIconConstraints: const BoxConstraints(minWidth: 32),
                ),
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isDark ? AppColors.slate200 : AppColors.slate700,
                ),
              ),
            ),
          ),

          // Count Indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: double.infinity,
            decoration: BoxDecoration(
              color: isDark ? AppColors.slate800 : AppColors.slate50,
              border: Border(
                left: BorderSide(
                  color: isDark ? AppColors.slate700 : AppColors.slate200,
                ),
              ),
            ),
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                style: AppTextStyles.bodyXSmall.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.slate500,
                ),
                children: [
                  const TextSpan(text: 'Products count: '),
                  TextSpan(
                    text: '0',
                    style: TextStyle(
                      color: isDark ? AppColors.slate200 : AppColors.slate800,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchIndicator(
    List<List<dynamic>> icon, {
    required bool isDark,
    required String title,
    bool isSelected = false,
  }) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.emerald600 : Colors.transparent,
        border: Border(
          right: BorderSide(
            color: isDark ? AppColors.slate700 : AppColors.slate200,
          ),
        ),
      ),
      child: Center(
        child: HugeIcon(
          icon: icon,
          size: 16,
          color: isSelected ? Colors.white : AppColors.slate400,
        ),
      ),
    );
  }

  Widget _buildLinkText(String text, bool isDark) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Text(
        text,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.emerald600,
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
