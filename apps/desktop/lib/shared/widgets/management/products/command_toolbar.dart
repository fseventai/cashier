import 'package:cashier/core/providers/product_group_provider.dart';
import 'package:cashier/core/providers/product_provider.dart';
import 'package:cashier/shared/components/apps/command_toolbar_button.dart';
import 'package:cashier/shared/components/apps/custom_vertical_divider.dart';
import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

class CommandToolbar extends ConsumerWidget {
  final VoidCallback? onRefresh;
  final VoidCallback? onNewProduct;
  final VoidCallback? onEditProduct;
  final VoidCallback? onDeleteProduct;
  final VoidCallback? onNewGroup;
  final VoidCallback? onEditGroup;
  final VoidCallback? onDeleteGroup;

  const CommandToolbar({
    super.key,
    this.onRefresh,
    this.onNewProduct,
    this.onEditProduct,
    this.onDeleteProduct,
    this.onNewGroup,
    this.onEditGroup,
    this.onDeleteGroup,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final selectedProductId = ref.watch(selectedProductIdProvider);
    final hasProductSelected = selectedProductId != null;

    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? AppColors.slate800 : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: isDark ? AppColors.slate700 : AppColors.slate200,
          ),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            CommandToolbarButton(
              icon: HugeIcons.strokeRoundedRefresh,
              label: 'Segarkan',
              onTap: onRefresh ?? () {},
              isDark: isDark,
            ),
            CustomVerticalDivider(isDark: isDark),
            CommandToolbarButton(
              icon: HugeIcons.strokeRoundedFolderAdd,
              label: 'New group',
              onTap: onNewGroup ?? () {},
              isDark: isDark,
            ),
            CommandToolbarButton(
              icon: HugeIcons.strokeRoundedFolderLinks,
              label: 'Edit group',
              onTap: onEditGroup ?? () {},
              isDark: isDark,
              isEnabled: ref.watch(selectedProductGroupIdProvider) != null,
            ),
            CommandToolbarButton(
              icon: HugeIcons.strokeRoundedFolderRemove,
              label: 'Delete group',
              onTap: onDeleteGroup ?? () {},
              isDark: isDark,
              hoverColor: Colors.red,
              isEnabled: ref.watch(selectedProductGroupIdProvider) != null,
            ),
            CustomVerticalDivider(isDark: isDark),
            CommandToolbarButton(
              icon: HugeIcons.strokeRoundedAdd02,
              label: 'New product',
              onTap: onNewProduct ?? () {},
              isDark: isDark,
              iconColor: AppColors.emerald600,
              forceIconBold: true,
            ),
            CommandToolbarButton(
              icon: HugeIcons.strokeRoundedPencilEdit02,
              label: 'Edit product',
              onTap: onEditProduct ?? () {},
              isDark: isDark,
              isEnabled: hasProductSelected,
            ),
            CommandToolbarButton(
              icon: HugeIcons.strokeRoundedDelete02,
              label: 'Delete product',
              onTap: onDeleteProduct ?? () {},
              isDark: isDark,
              hoverColor: Colors.red,
              isEnabled: hasProductSelected,
            ),
            CustomVerticalDivider(isDark: isDark),
            CommandToolbarButton(
              icon: HugeIcons.strokeRoundedPrinter,
              label: 'Cetak',
              onTap: () {},
              isDark: isDark,
            ),
            CommandToolbarButton(
              icon: HugeIcons.strokeRoundedPdf02,
              label: 'Simpan PDF',
              onTap: () {},
              isDark: isDark,
            ),
            CustomVerticalDivider(isDark: isDark),
            CommandToolbarButton(
              icon: HugeIcons.strokeRoundedTag02,
              label: 'Price tags',
              onTap: () {},
              isDark: isDark,
            ),
            CommandToolbarButton(
              icon: HugeIcons.strokeRoundedSorting02,
              label: 'Sorting',
              onTap: () {},
              isDark: isDark,
            ),
            CommandToolbarButton(
              icon: HugeIcons.strokeRoundedAnalytics02,
              label: 'Mov. avg. price',
              onTap: () {},
              isDark: isDark,
            ),
            CustomVerticalDivider(isDark: isDark),
            CommandToolbarButton(
              icon: HugeIcons.strokeRoundedDownload02,
              label: 'Import',
              onTap: () {},
              isDark: isDark,
            ),
            CommandToolbarButton(
              icon: HugeIcons.strokeRoundedUpload02,
              label: 'Export',
              onTap: () {},
              isDark: isDark,
            ),
            CommandToolbarButton(
              icon: HugeIcons.strokeRoundedHelpCircle,
              label: 'Bantuan',
              onTap: () {},
              isDark: isDark,
            ),
          ],
        ),
      ),
    );
  }
}
