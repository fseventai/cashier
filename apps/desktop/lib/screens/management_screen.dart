import 'package:flutter/material.dart';
import 'package:cashier/shared/widgets/management/management_sidebar.dart';
import 'package:cashier/shared/widgets/management/management_header.dart';
import 'package:cashier/shared/widgets/management/command_toolbar.dart';
import 'package:cashier/shared/widgets/management/product_group_list.dart';
import 'package:cashier/shared/widgets/management/product_content_area.dart';
import 'package:cashier/core/constants/app_colors.dart';
import 'package:hugeicons/hugeicons.dart';

class ManagementScreen extends StatefulWidget {
  const ManagementScreen({super.key});

  @override
  State<ManagementScreen> createState() => _ManagementScreenState();
}

class _ManagementScreenState extends State<ManagementScreen> {
  String _activeRoute = 'products';
  bool _isDarkMode = false;

  void _onRouteSelected(String route) {
    setState(() {
      _activeRoute = route;
    });
  }

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDarkMode
          ? ThemeData.dark().copyWith(
              scaffoldBackgroundColor: AppColors.slate900,
              brightness: Brightness.dark,
              // Override more theme properties if needed to match design exactly
            )
          : ThemeData.light().copyWith(
              scaffoldBackgroundColor: Colors.white,
              brightness: Brightness.light,
            ),
      child: Scaffold(
        body: Row(
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
                  // Top Title/Breadcrumb Bar
                  ManagementHeader(
                    breadcrumbs: const ['Management', 'Products'],
                    onClose: () => Navigator.of(context).pop(),
                  ),

                  // Ribbon Toolbar
                  const CommandToolbar(),

                  // Split View (Product Groups & Content)
                  const Expanded(
                    child: Row(
                      children: [
                        ProductGroupList(),
                        Expanded(child: ProductContentArea()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _toggleDarkMode,
          backgroundColor: _isDarkMode ? Colors.white : AppColors.slate800,
          child: HugeIcon(
            icon: _isDarkMode
                ? HugeIcons.strokeRoundedSun01
                : HugeIcons.strokeRoundedMoon02,
            color: _isDarkMode ? AppColors.slate800 : Colors.white,
          ),
        ),
      ),
    );
  }
}
