import 'package:cashier/shared/widgets/management/products/product_drawer/components/layout/header_product_drawer.dart';
import 'package:cashier/shared/widgets/management/products/product_drawer/components/layout/tabs_product_drawer.dart';
import 'package:cashier/shared/widgets/management/products/product_drawer/components/layout/footer_product_drawer.dart';
import 'package:cashier/shared/widgets/management/products/product_drawer/tabs/details_tab.dart';
import 'package:cashier/shared/widgets/management/products/product_drawer/tabs/price_and_tax_tab.dart';
import 'package:cashier/shared/widgets/management/products/product_drawer/tabs/stock_control_tab.dart';
import 'package:cashier/shared/widgets/management/products/product_drawer/tabs/comments_tab.dart';
import 'package:cashier/shared/widgets/management/products/product_drawer/tabs/image_and_color_tab.dart';
import 'package:flutter/material.dart';

class ProductDrawer extends StatefulWidget {
  const ProductDrawer({super.key});

  @override
  State<ProductDrawer> createState() => _ProductDrawerState();
}

class _ProductDrawerState extends State<ProductDrawer> {
  int _activeTab = 0;
  final List<String> _tabs = [
    'Details',
    'Price & tax',
    'Stock control',
    'Comments',
    'Image & color',
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 600,
      shape: const RoundedRectangleBorder(),
      backgroundColor: Colors.white,
      child: Column(
        children: [
          // Header
          const HeaderProductDrawer(),

          // Tabs
          TabsProductDrawer(
            tabs: _tabs,
            activeTab: _activeTab,
            onTabChange: (idx) => setState(() => _activeTab = idx),
          ),

          // Content
          Expanded(child: _buildTabContent()),

          // Footer
          FooterProductDrawer(
            onCancel: () => Navigator.of(context).pop(),
            onSave: () {},
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
        return const PriceAndTaxTab();
      case 2:
        return const StockControlTab();
      case 3:
        return const CommentsTab();
      case 4:
        return const ImageAndColorTab();
      default:
        return const SizedBox.shrink();
    }
  }
}
