import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';
import 'package:cashier/shared/widgets/management/products/product_drawer/components/form/section_title.dart';
import 'package:cashier/shared/widgets/management/products/product_drawer/components/form/product_text_field.dart';
import 'package:flutter/material.dart';

class CommentsTab extends StatelessWidget {
  const CommentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        // Internal comments
        const SectionTitle(title: 'Internal comments'),
        const SizedBox(height: 8),
        Text(
          'These notes are only visible to staff members.',
          style: AppTextStyles.bodyXSmall.copyWith(color: AppColors.slate500),
        ),
        const SizedBox(height: 12),
        const ProductTextField(
          label: '',
          maxLines: 6,
          placeholder: 'Type internal product notes here...',
        ),
        const SizedBox(height: 32),

        // Notes for receipt
        const SectionTitle(title: 'Notes for receipt'),
        const SizedBox(height: 8),
        Text(
          'This text will appear on the printed customer receipt.',
          style: AppTextStyles.bodyXSmall.copyWith(color: AppColors.slate500),
        ),
        const SizedBox(height: 12),
        const ProductTextField(
          label: '',
          maxLines: 4,
          placeholder: 'e.g. Warranty details or usage instructions...',
        ),
        const SizedBox(height: 32),

        // Supplier notes
        const SectionTitle(title: 'Supplier notes'),
        const SizedBox(height: 16),
        const ProductTextField(
          label: 'Notes for purchase orders',
          maxLines: 3,
          placeholder:
              'Instructions for the supplier when ordering this item...',
        ),
      ],
    );
  }
}
