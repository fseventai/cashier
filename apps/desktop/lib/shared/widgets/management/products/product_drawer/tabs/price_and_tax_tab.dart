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
            Expanded(
              child: ProductDropdown<String>(
                label: '',
                value: 'Add tax to product',
                items: const [
                  DropdownMenuItem(
                    value: 'Add tax to product',
                    child: Text('Add tax to product'),
                  ),
                  DropdownMenuItem(
                    value: 'Standard VAT (10%)',
                    child: Text('Standard VAT (10%)'),
                  ),
                  DropdownMenuItem(
                    value: 'Zero Rate (0%)',
                    child: Text('Zero Rate (0%)'),
                  ),
                  DropdownMenuItem(
                    value: 'Reduced Rate (5%)',
                    child: Text('Reduced Rate (5%)'),
                  ),
                ],
                onChanged: (v) {},
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
