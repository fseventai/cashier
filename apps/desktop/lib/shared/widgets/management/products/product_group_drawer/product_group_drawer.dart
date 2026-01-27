import 'package:cashier/core/providers/product_group_provider.dart';
import 'package:cashier/shared/widgets/management/products/product_group_drawer/components/layout/footer_product_group_drawer.dart';
import 'package:cashier/shared/widgets/management/products/product_group_drawer/components/layout/header_product_group_drawer.dart';
import 'package:cashier/shared/widgets/management/products/product_group_drawer/components/layout/tabs_product_group_drawer.dart';
import 'package:cashier/shared/widgets/management/products/product_group_drawer/tabs/details_tab.dart';
import 'package:cashier/shared/widgets/management/products/product_group_drawer/tabs/images_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toastification/toastification.dart';

class ProductGroupDrawer extends ConsumerStatefulWidget {
  const ProductGroupDrawer({super.key});

  @override
  ConsumerState<ProductGroupDrawer> createState() => _ProductGroupDrawerState();
}

class _ProductGroupDrawerState extends ConsumerState<ProductGroupDrawer> {
  int _activeTab = 0;
  final List<String> _tabs = ['Details', 'Images'];

  @override
  Widget build(BuildContext context) {
    final group = ref.watch(productGroupFormProvider);
    final isEdit = group.id.isNotEmpty;

    return Drawer(
      width: 420, // Matching max-w-[420px] from HTML
      shape: const RoundedRectangleBorder(),
      backgroundColor: Colors.white,
      child: Column(
        children: [
          // Header
          HeaderProductGroupDrawer(isEdit: isEdit),

          // Tabs
          TabsProductGroupDrawer(
            tabs: _tabs,
            activeTab: _activeTab,
            onTabChange: (idx) => setState(() => _activeTab = idx),
          ),

          // Content
          Expanded(child: _buildTabContent()),

          // Footer
          FooterProductGroupDrawer(
            onCancel: () {
              ref.read(productGroupFormProvider.notifier).reset();
              Navigator.of(context).pop();
            },
            onSave: () async {
              final form = ref.read(productGroupFormProvider);
              await ref.read(productGroupListProvider.notifier).saveGroup(form);
              if (context.mounted) {
                toastification.show(
                  context: context,
                  type: ToastificationType.success,
                  style: ToastificationStyle.flatColored,
                  title: const Text('Berhasil'),
                  description: Text('Grup "${form.name}" berhasil disimpan'),
                  autoCloseDuration: const Duration(seconds: 3),
                );
                ref.read(productGroupFormProvider.notifier).reset();
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_activeTab) {
      case 0:
        return const DetailsTab();
      case 1:
        return const ImagesTab();
      default:
        return const SizedBox.shrink();
    }
  }
}
