import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';
import 'package:cashier/shared/widgets/management/products/product_drawer/components/form/product_text_field.dart';
import 'package:cashier/shared/widgets/management/products/product_drawer/components/form/product_dropdown.dart';
import 'package:cashier/shared/widgets/management/products/product_drawer/components/form/product_switch.dart';
import 'package:flutter/material.dart';

class StockControlTab extends StatelessWidget {
  const StockControlTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        ProductSwitch(
          label: 'Enable inventory tracking',
          value: true,
          onChanged: (v) {},
        ),
        const SizedBox(height: 12),
        const Row(
          children: [
            Expanded(
              child: ProductTextField(
                label: 'Stock quantity',
                initialValue: '0',
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: ProductDropdown(
                label: 'Storage location',
                value: 'Select location',
                items: [
                  'Select location',
                  'Main Warehouse',
                  'Secondary Storage',
                  'Display Shelf A',
                  'Back Office',
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ProductTextField(
                    label: 'Minimum stock level',
                    initialValue: '0',
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Alert when stock falls below this level.',
                    style: AppTextStyles.bodyXSmall.copyWith(
                      color: AppColors.slate400,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ProductTextField(
                    label: 'Reorder point',
                    initialValue: '0',
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Suggested quantity for reordering.',
                    style: AppTextStyles.bodyXSmall.copyWith(
                      color: AppColors.slate400,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
