import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';
import 'package:cashier/shared/widgets/management/products/product_drawer/components/form/product_text_field.dart';
import 'package:cashier/shared/widgets/management/products/product_drawer/components/form/product_dropdown.dart';
import 'package:cashier/shared/widgets/management/products/product_drawer/components/form/product_switch.dart';
import 'package:flutter/material.dart';

class DetailsTab extends StatelessWidget {
  const DetailsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const ProductTextField(
          label: 'Name',
          isRequired: true,
          hasError: true, // Matching HTML preview which has red border
        ),
        const SizedBox(height: 20),
        const ProductTextField(label: 'Code', width: 128, initialValue: '1'),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProductTextField(label: 'Barcode'),
            const SizedBox(height: 4),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Text(
                'Generate barcode',
                style: AppTextStyles.bodyXSmall.copyWith(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const ProductTextField(label: 'Unit of measurement', width: 160),
        const SizedBox(height: 20),
        const ProductDropdown(
          label: 'Group',
          value: 'Products',
          items: ['Products'],
        ),
        const SizedBox(height: 24),
        ProductSwitch(label: 'Active', value: true, onChanged: (v) {}),
        ProductSwitch(
          label: 'Default quantity',
          value: true,
          onChanged: (v) {},
        ),
        ProductSwitch(
          label: 'Service (not using stock)',
          value: false,
          onChanged: (v) {},
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ProductTextField(label: 'Age restriction', width: 96),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Text(
                'year(s)',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.slate500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const ProductTextField(label: 'Description', maxLines: 4),
      ],
    );
  }
}
