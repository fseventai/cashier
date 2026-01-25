import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/shared/widgets/management/products/product_drawer/components/form/section_title.dart';
import 'package:cashier/shared/widgets/management/products/product_drawer/components/form/product_text_field.dart';
import 'package:cashier/shared/widgets/management/products/product_drawer/components/form/product_dropdown.dart';
import 'package:cashier/shared/widgets/management/products/product_drawer/components/form/product_switch.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class PriceAndTaxTab extends StatelessWidget {
  const PriceAndTaxTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        // Taxes Section
        const SectionTitle(title: 'Taxes'),
        const SizedBox(height: 12),
        Row(
          children: [
            const Expanded(
              child: ProductDropdown(
                label: '',
                value: 'Add tax to product',
                items: [
                  'Add tax to product',
                  'Standard VAT (10%)',
                  'Zero Rate (0%)',
                  'Reduced Rate (5%)',
                ],
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () {},
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedInformationCircle,
                size: 20,
                color: AppColors.slate400,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
        const SizedBox(height: 32),

        // Price Input Section
        const ProductTextField(label: 'Cost', initialValue: '0'),
        const SizedBox(height: 20),
        const ProductTextField(
          label: 'Markup (%)',
          initialValue: '0',
          suffix: '%',
        ),
        const SizedBox(height: 20),
        const ProductTextField(label: 'Sale price', initialValue: '0'),
        const SizedBox(height: 32),

        // Settings Section
        const Divider(color: AppColors.slate200, height: 1),
        const SizedBox(height: 24),
        ProductSwitch(
          label: 'Price includes tax',
          value: true,
          onChanged: (v) {},
        ),
        ProductSwitch(
          label: 'Price change allowed',
          value: false,
          onChanged: (v) {},
        ),
      ],
    );
  }
}
