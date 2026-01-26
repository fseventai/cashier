import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';
import 'package:cashier/core/providers/product_provider.dart';
import 'package:cashier/shared/widgets/management/products/product_drawer/components/form/product_dropdown.dart';
import 'package:cashier/shared/widgets/management/products/product_drawer/components/form/product_switch.dart';
import 'package:cashier/shared/widgets/management/products/product_drawer/components/form/product_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailsTab extends ConsumerWidget {
  const DetailsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch fields individually or the whole object. Watching the object might cause frequent rebuilds
    // but for this form size it's acceptable.
    final product = ref.watch(productFormProvider);
    final notifier = ref.read(productFormProvider.notifier);

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        ProductTextField(
          label: 'Name',
          isRequired: true,
          initialValue: product.name,
          onChanged: (v) => notifier.updateProduct(product.copyWith(name: v)),
        ),
        const SizedBox(height: 20),
        ProductTextField(
          label: 'Code',
          width: 128,
          initialValue: product.code,
          onChanged: (v) => notifier.updateProduct(product.copyWith(code: v)),
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductTextField(
              label: 'Barcode',
              initialValue: product.barcode,
              onChanged: (v) =>
                  notifier.updateProduct(product.copyWith(barcode: v)),
            ),
            const SizedBox(height: 4),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  // Logic to generate barcode using API service if needed, or simple local generation
                  // notifier.updateProduct(product.copyWith(barcode: 'GEN-${DateTime.now().millisecondsSinceEpoch}'));
                },
                child: Text(
                  'Generate barcode',
                  style: AppTextStyles.bodyXSmall.copyWith(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ProductTextField(
          label: 'Unit of measurement',
          width: 160,
          initialValue: product.unit,
          onChanged: (v) => notifier.updateProduct(product.copyWith(unit: v)),
        ),
        const SizedBox(height: 20),
        // Dropdown needs similar update to accept onChanged and value
        ProductDropdown<String>(
          label: 'Group',
          value: 'Products', // Should bind to product.groupId and map to name
          items: [
            DropdownMenuItem(
              value: 'Products',
              child: Text(
                'Products',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.slate800,
                ),
              ),
            ),
          ],
          onChanged: (v) {},
        ),

        const SizedBox(height: 24),
        ProductSwitch(
          label: 'Active',
          value: product.isActive,
          onChanged: (v) =>
              notifier.updateProduct(product.copyWith(isActive: v)),
        ),
        ProductSwitch(
          label: 'Default quantity',
          value: product.isDefaultQuantity,
          onChanged: (v) =>
              notifier.updateProduct(product.copyWith(isDefaultQuantity: v)),
        ),
        ProductSwitch(
          label: 'Service (not using stock)',
          value: product.isService,
          onChanged: (v) =>
              notifier.updateProduct(product.copyWith(isService: v)),
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProductTextField(
              label: 'Age restriction',
              width: 96,
              initialValue: product.ageRestriction,
              onChanged: (v) =>
                  notifier.updateProduct(product.copyWith(ageRestriction: v)),
            ),
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
        ProductTextField(
          label: 'Description',
          maxLines: 4,
          initialValue: product.description,
          onChanged: (v) =>
              notifier.updateProduct(product.copyWith(description: v)),
        ),
      ],
    );
  }
}
