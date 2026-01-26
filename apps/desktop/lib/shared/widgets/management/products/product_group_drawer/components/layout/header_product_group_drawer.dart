import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';
import 'package:cashier/core/providers/product_group_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

class HeaderProductGroupDrawer extends ConsumerWidget {
  final bool isEdit;
  const HeaderProductGroupDrawer({super.key, this.isEdit = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppColors.slate200)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            isEdit ? 'Edit product group' : 'New product group',
            style: AppTextStyles.h2.copyWith(color: AppColors.slate800),
          ),
          IconButton(
            onPressed: () {
              ref.read(productGroupFormProvider.notifier).reset();
              Navigator.of(context).pop();
            },
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedCancel01,
              color: AppColors.slate400,
              size: 20,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            hoverColor: Colors.red.withValues(alpha: 0.1),
          ),
        ],
      ),
    );
  }
}
