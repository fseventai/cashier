import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';

class StockCategoryTree extends StatelessWidget {
  const StockCategoryTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 256, // w-64
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(right: BorderSide(color: AppColors.surfaceBorder)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.emerald500,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  const Icon(Icons.folder_open, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
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
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: const [
                _CategoryItem(label: 'Electronics'),
                _CategoryItem(label: 'Groceries'),
                _CategoryItem(label: 'Clothing'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final String label;

  const _CategoryItem({required this.label});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(4),
      hoverColor: AppColors.slate100,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        child: Row(
          children: [
            const Icon(
              Icons.folder_outlined,
              size: 18,
              color: AppColors.slate400,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.slate600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
