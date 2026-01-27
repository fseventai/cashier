import 'package:cashier/shared/models/breadcrumb_item.dart';
import 'package:cashier/shared/models/management_page_config.dart';
import 'package:cashier/shared/widgets/management/company/company_content_area.dart';
import 'package:cashier/shared/widgets/management/members/members_content_area.dart';
import 'package:cashier/shared/widgets/management/members/members_drawer.dart';
import 'package:cashier/shared/widgets/management/members/members_toolbar.dart';
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
import 'package:cashier/shared/widgets/management/products/product_group_drawer/product_group_drawer.dart';
import 'package:cashier/shared/components/dialogs/delete_confirmation_dialog.dart';
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

import 'package:cashier/core/providers/product_group_provider.dart'
    hide ProductGroupList;
import 'package:cashier/core/providers/product_provider.dart';
import 'package:cashier/core/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toastification/toastification.dart';
import 'package:dio/dio.dart';

class ManagementScreen extends ConsumerStatefulWidget {
  const ManagementScreen({super.key});

  @override
  ConsumerState<ManagementScreen> createState() => _ManagementScreenState();
}

class _ManagementScreenState extends ConsumerState<ManagementScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String _activeRoute = 'dashboard';
  String? _activeDrawerPath; // 'product', 'group'
  bool _isSidebarCollapsed = false;

  void _onToggleSidebar() {
    setState(() {
      _isSidebarCollapsed = !_isSidebarCollapsed;
    });
  }

  void _openProductDrawer() {
    ref
        .read(productFormProvider.notifier)
        .updateProduct(const Product(id: '', name: ''));
    setState(() => _activeDrawerPath = 'product');
    _scaffoldKey.currentState?.openEndDrawer();
  }

  void _onEditProduct() {
    final selectedId = ref.read(selectedProductIdProvider);
    if (selectedId == null) return;

    final products = ref.read(productListProvider).value ?? [];
    final product = products.firstWhere(
      (p) => p.id == selectedId,
      orElse: () => const Product(id: '', name: ''),
    );

    if (product.id.isEmpty) return;

    ref.read(productFormProvider.notifier).updateProduct(product);
    setState(() => _activeDrawerPath = 'product');
    _scaffoldKey.currentState?.openEndDrawer();
  }

  Future<void> _onDeleteProduct() async {
    final selectedId = ref.read(selectedProductIdProvider);
    if (selectedId == null) return;

    final products = ref.read(productListProvider).value ?? [];
    final product = products.firstWhere(
      (p) => p.id == selectedId,
      orElse: () => const Product(id: '', name: ''),
    );

    if (product.id.isEmpty) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => DeleteConfirmationDialog(
        title: 'Hapus Produk?',
        message:
            'Apakah Anda yakin ingin menghapus produk "${product.name}"? Tindakan ini tidak dapat dibatalkan.',
        onConfirm: () => Navigator.pop(context, true),
        onCancel: () => Navigator.pop(context, false),
      ),
    );

    if (confirmed == true) {
      try {
        await ref.read(productListProvider.notifier).deleteProduct(selectedId);
        ref.read(selectedProductIdProvider.notifier).state = null;
        if (mounted) {
          toastification.show(
            context: context,
            type: ToastificationType.success,
            style: ToastificationStyle.flatColored,
            title: const Text('Berhasil'),
            description: Text('Produk "${product.name}" berhasil dihapus'),
            autoCloseDuration: const Duration(seconds: 3),
          );
        }
      } catch (e) {
        String message = 'Gagal menghapus produk';
        if (e is DioException && e.response?.data is Map) {
          message = e.response?.data['message'] ?? message;
        }
        if (mounted) {
          toastification.show(
            context: context,
            type: ToastificationType.error,
            style: ToastificationStyle.flatColored,
            title: const Text('Gagal'),
            description: Text(message),
            autoCloseDuration: const Duration(seconds: 5),
          );
        }
      }
    }
  }

  void _openGroupDrawer() {
    ref.read(productGroupFormProvider.notifier).reset();
    setState(() => _activeDrawerPath = 'group');
    _scaffoldKey.currentState?.openEndDrawer();
  }

  Future<void> _onDeleteGroup() async {
    final selectedId = ref.read(selectedProductGroupIdProvider);
    if (selectedId == null) {
      toastification.show(
        context: context,
        type: ToastificationType.warning,
        style: ToastificationStyle.flatColored,
        title: const Text('Pilih grup'),
        description: const Text(
          'Pilih grup yang ingin dihapus terlebih dahulu',
        ),
        autoCloseDuration: const Duration(seconds: 3),
      );
      return;
    }

    // Find the group name for the dialog
    final groups = ref.read(productGroupListProvider).value ?? [];
    ProductGroup? selectedGroup;
    try {
      selectedGroup = groups.firstWhere((g) => g.id == selectedId);
    } catch (_) {
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => DeleteConfirmationDialog(
        title: 'Hapus Grup?',
        message:
            'Apakah Anda yakin ingin menghapus grup "${selectedGroup!.name}"? Tindakan ini tidak dapat dibatalkan.',
        onConfirm: () => Navigator.pop(context, true),
        onCancel: () => Navigator.pop(context, false),
      ),
    );

    if (confirmed == true) {
      try {
        await ref
            .read(productGroupListProvider.notifier)
            .deleteGroup(selectedId);
        ref.read(selectedProductGroupIdProvider.notifier).state = null;
        if (mounted) {
          toastification.show(
            context: context,
            type: ToastificationType.success,
            style: ToastificationStyle.flatColored,
            title: const Text('Berhasil'),
            description: Text('Grup "${selectedGroup.name}" berhasil dihapus'),
            autoCloseDuration: const Duration(seconds: 3),
          );
        }
      } catch (e) {
        String message = 'Gagal menghapus grup';
        if (e is DioException && e.response?.data is Map) {
          message = e.response?.data['message'] ?? message;
        }
        if (mounted) {
          toastification.show(
            context: context,
            type: ToastificationType.error,
            style: ToastificationStyle.flatColored,
            title: const Text('Gagal'),
            description: Text(message),
            autoCloseDuration: const Duration(seconds: 5),
          );
        }
      }
    }
  }

  final Map<String, String> routeLabels = {
    'dashboard': 'Dashboard',
    'company': 'My company',
    'customers': 'Customers & suppliers',
    'categories': 'Categories',
    'taxes': 'Tax rates',
    'stock': 'Stock',
    'members': 'Members',
    'users': 'Users & security',
    'products': 'Products',
    'reporting': 'Reporting',
  };

  List<BreadcrumbItem> _getBreadcrumbs(String activeRoute) {
    return [
      BreadcrumbItem(label: 'Management', onTap: () {}),
      BreadcrumbItem(label: routeLabels[activeRoute] ?? 'dashboard'),
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
          toolbar: CommandToolbar(
            onDeleteGroup: _onDeleteGroup,
            onRefresh: () {
              ref.invalidate(productListProvider);
              ref.invalidate(productGroupListProvider);
            },
            onNewProduct: _openProductDrawer,
            onEditProduct: _onEditProduct,
            onDeleteProduct: _onDeleteProduct,
            onNewGroup: _openGroupDrawer,
          ),
          drawer: _activeDrawerPath == 'group'
              ? const ProductGroupDrawer()
              : const ProductDrawer(),
          content: Row(
            children: [
              Expanded(flex: 2, child: const ProductGroupList()),
              Expanded(
                flex: 6,
                child: ProductContentArea(
                  onNewProduct: _openProductDrawer,
                  onNewGroup: _openGroupDrawer,
                ),
              ),
            ],
          ),
        );

      case 'customers':
        return ManagementPageConfig(
          toolbar: CustomerToolbar(onAdd: _openDrawer),
          drawer: const CustomerDrawer(),
          content: const CustomerContentArea(),
        );

      case 'members':
        return ManagementPageConfig(
          toolbar: MembersToolbar(onAdd: _openDrawer),
          drawer: const MembersDrawer(),
          content: const MembersContentArea(),
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
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: _isSidebarCollapsed ? 80 : 260,
                  child: ManagementSidebar(
                    activeRoute: _activeRoute,
                    onRouteSelected: _onRouteSelected,
                    isCollapsed: _isSidebarCollapsed,
                    onToggle: _onToggleSidebar,
                  ),
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
