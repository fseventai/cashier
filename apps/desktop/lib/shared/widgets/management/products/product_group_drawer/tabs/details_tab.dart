import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';
import 'package:cashier/core/models/product.dart';
import 'package:cashier/core/providers/product_group_provider.dart';
import 'package:cashier/shared/components/custom_searchable_dropdown.dart';
import 'package:cashier/shared/widgets/management/products/product_drawer/components/form/product_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailsTab extends ConsumerWidget {
  const DetailsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(productGroupFormProvider);
    final groupsAsync = ref.watch(productGroupListProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Group Name
          ProductTextField(
            label: 'Group Name',
            isRequired: true,
            initialValue: form.name,
            placeholder: 'Enter group name',
            onChanged: (val) =>
                ref.read(productGroupFormProvider.notifier).updateName(val),
          ),
          const SizedBox(height: 16),

          // Parent Group
          groupsAsync.when(
            data: (groups) {
              final initialValue = groups.cast<ProductGroup?>().firstWhere(
                (g) => g?.id == form.parentId,
                orElse: () {
                  if (groups.isNotEmpty && form.id.isEmpty) {
                    return groups.cast<ProductGroup?>().firstWhere(
                      (g) => g?.parentId == null,
                      orElse: () => null,
                    );
                  }
                  return null;
                },
              );

              // Sync state if we auto-selected a default group for a new entry
              if (initialValue != null &&
                  form.parentId == null &&
                  form.id.isEmpty) {
                Future.microtask(
                  () => ref
                      .read(productGroupFormProvider.notifier)
                      .updateParentId(initialValue.id),
                );
              }

              return CustomSearchableDropdown<ProductGroup?>(
                label: 'Parent Group',
                searchPlaceholder: 'Search Product groups...',
                value: initialValue,
                items: groups,
                itemAsString: (g) => g?.name ?? '',
                onChanged: (val) {
                  ref
                      .read(productGroupFormProvider.notifier)
                      .updateParentId(val?.id);
                },
              );
            },
            loading: () => const LinearProgressIndicator(),
            error: (err, _) => Text('Error loading groups: $err'),
          ),
          const SizedBox(height: 16),

          // Description
          ProductTextField(
            label: 'Description',
            initialValue: form.description,
            placeholder: 'Add a description for this group...',
            maxLines: 4,
            onChanged: (val) => ref
                .read(productGroupFormProvider.notifier)
                .updateDescription(val),
          ),
          const SizedBox(height: 24),

          // Active Status
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColors.slate200,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Active Status',
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.slate700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Enable or disable this group',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.slate500,
                      ),
                    ),
                  ],
                ),
                Switch(
                  value: form.isActive,
                  onChanged: (val) => ref
                      .read(productGroupFormProvider.notifier)
                      .updateIsActive(val),
                  activeThumbColor: Colors.white,
                  activeTrackColor: AppColors.emerald600,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: AppColors.slate200,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
