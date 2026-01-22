import 'package:cashier/shared/models/breadcrumb_item.dart';
import 'package:cashier/shared/models/management_page_config.dart';
import 'package:cashier/shared/widgets/management/company/company_content_area.dart';
import 'package:cashier/shared/widgets/management/stock/stock_toolbar.dart';
import 'package:cashier/shared/widgets/management/tax_rates/tax_rates_toolbar.dart';
import 'package:cashier/shared/widgets/management/users/user_toolbar.dart';
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
import 'package:cashier/shared/widgets/management/dashboard/dashboard_content.dart';
import 'package:cashier/shared/widgets/management/tax_rates/tax_rates_content.dart';
import 'package:cashier/shared/widgets/management/tax_rates/tax_rates_drawer.dart';
import 'package:cashier/shared/widgets/management/stock/stock_content.dart';
import 'package:cashier/shared/widgets/management/users/users_security_content.dart';
import 'package:cashier/shared/widgets/management/users/user_drawer.dart';
import 'package:cashier/shared/widgets/management/reporting/reporting_content.dart';

class ManagementScreen extends StatefulWidget {
  const ManagementScreen({super.key});

  @override
  State<ManagementScreen> createState() => _ManagementScreenState();
}

class _ManagementScreenState extends State<ManagementScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String _activeRoute = 'dashboard';

  final Map<String, String> routeLabels = {
    'dashboard': 'Dashboard',
    'company': 'My company',
    'customers': 'Customers & suppliers',
    'taxes': 'Tax rates',
    'stock': 'Stock',
    'users': 'Users & security',
    'products': 'Products',
    'reporting': 'Reporting',
  };

  List<BreadcrumbItem> _getBreadcrumbs(String activeRoute) {
    return [
      BreadcrumbItem(label: 'Management', onTap: () {}),
      BreadcrumbItem(label: routeLabels[activeRoute] ?? 'Products'),
    ];
  }

  void _onRouteSelected(String route) {
    setState(() {
      _activeRoute = route;
    });
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  ManagementPageConfig _getPageConfig() {
    switch (_activeRoute) {
      case 'dashboard':
        return ManagementPageConfig(content: const DashboardContent());

      case 'products':
        return ManagementPageConfig(
          toolbar: CommandToolbar(onNewProduct: _openDrawer),
          drawer: const ProductDrawer(),
          content: Row(
            children: [
              const ProductGroupList(),
              Expanded(child: ProductContentArea(onNewProduct: _openDrawer)),
            ],
          ),
        );

      case 'customers':
        return ManagementPageConfig(
          toolbar: CustomerToolbar(onAdd: _openDrawer),
          drawer: const CustomerDrawer(),
          content: const CustomerContentArea(),
        );

      case 'taxes':
        return ManagementPageConfig(
          toolbar: TaxRatesToolbar(onAdd: _openDrawer),
          drawer: const TaxRateDrawer(),
          content: TaxRatesContent(onNewTaxRate: _openDrawer),
        );

      case 'stock':
        return ManagementPageConfig(
          toolbar: StockToolbar(),
          content: const StockContent(),
        );

      case 'users':
        return ManagementPageConfig(
          toolbar: UserToolbar(onAdd: _openDrawer),
          drawer: const UserDrawer(),
          content: UsersSecurityContent(),
        );

      case 'reporting':
        return ManagementPageConfig(content: const ReportingContent());

      case 'company':
        return ManagementPageConfig(content: const CompanyContentArea());

      default:
        return ManagementPageConfig(
          content: Center(child: Text('Content for $_activeRoute coming soon')),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final config = _getPageConfig();

    return Theme(
      data: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
        brightness: Brightness.light,
      ),
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: config.drawer,
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
                        items: _getBreadcrumbs(_activeRoute),
                        onClose: () => Navigator.of(context).pop(),
                      ),

                      if (config.toolbar != null) config.toolbar!,
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(0.01, 0),
                                      end: Offset.zero,
                                    ).animate(animation),
                                    child: child,
                                  ),
                                );
                              },

                          child: Container(
                            key: ValueKey(_activeRoute),
                            child: config.content,
                          ),
                        ),
                      ),
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
