import 'package:flutter/material.dart';
import 'package:cashier/shared/widgets/management/management_sidebar.dart';
import 'package:cashier/shared/widgets/management/management_header.dart';
import 'package:cashier/shared/widgets/management/products/command_toolbar.dart';
import 'package:cashier/shared/widgets/management/products/product_group_list.dart';
import 'package:cashier/shared/widgets/management/products/product_content_area.dart';
import 'package:cashier/shared/widgets/management/products/product_drawer.dart';
import 'package:cashier/shared/widgets/management/customers/customer_toolbar.dart';
import 'package:cashier/shared/widgets/management/customers/customer_content_area.dart';
import 'package:cashier/shared/widgets/management/customers/customer_drawer.dart';

class ManagementScreen extends StatefulWidget {
  const ManagementScreen({super.key});

  @override
  State<ManagementScreen> createState() => _ManagementScreenState();
}

class _ManagementScreenState extends State<ManagementScreen> {
  String _activeRoute = 'products';

  void _onRouteSelected(String route) {
    setState(() {
      _activeRoute = route;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
        brightness: Brightness.light,
      ),
      child: Scaffold(
        endDrawer: _activeRoute == 'customers'
            ? const CustomerDrawer()
            : const ProductDrawer(),
        body: Builder(
          builder: (context) {
            return Row(
              children: [
                // Left Sidebar
                ManagementSidebar(
                  activeRoute: _activeRoute,
                  onRouteSelected: _onRouteSelected,
                ),

                // Main Content
                Expanded(
                  child: Column(
                    children: [
                      // Breadcrumbs based on route
                      ManagementHeader(
                        breadcrumbs: [
                          'Management',
                          _activeRoute == 'company'
                              ? 'My company'
                              : _activeRoute == 'customers'
                              ? 'Customers & suppliers'
                              : 'Products',
                        ],
                        onClose: () => Navigator.of(context).pop(),
                      ),

                      // Content based on route
                      if (_activeRoute == 'products') ...[
                        // Ribbon Toolbar
                        CommandToolbar(
                          onNewProduct: () =>
                              Scaffold.of(context).openEndDrawer(),
                        ),

                        // Split View (Product Groups & Content)
                        Expanded(
                          child: Row(
                            children: [
                              const ProductGroupList(),
                              Expanded(
                                child: ProductContentArea(
                                  onNewProduct: () =>
                                      Scaffold.of(context).openEndDrawer(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ] else if (_activeRoute == 'customers') ...[
                        CustomerToolbar(
                          onAdd: () => Scaffold.of(context).openEndDrawer(),
                        ),
                        const Expanded(child: CustomerContentArea()),
                      ] else ...[
                        Expanded(
                          child: Center(
                            child: Text(
                              'Content for $_activeRoute coming soon',
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
