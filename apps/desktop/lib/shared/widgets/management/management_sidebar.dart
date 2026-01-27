import 'package:cashier/shared/components/apps/app_logo.dart';
import 'package:cashier/shared/components/apps/pos_navigation_button.dart';
import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:hugeicons/hugeicons.dart';

class ManagementSidebar extends StatelessWidget {
  final String activeRoute;
  final Function(String) onRouteSelected;
  final bool isCollapsed;
  final VoidCallback onToggle;

  const ManagementSidebar({
    super.key,
    required this.activeRoute,
    required this.onRouteSelected,
    required this.isCollapsed,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? AppColors.slate800 : AppColors.slate50,
        border: Border(
          right: BorderSide(
            color: isDark ? AppColors.slate700 : AppColors.slate200,
          ),
        ),
      ),
      child: Column(
        children: [
          // Logo Section
          AnimatedPadding(
            duration: const Duration(milliseconds: 300),
            padding: EdgeInsets.symmetric(horizontal: isCollapsed ? 12 : 24),
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isDark ? AppColors.slate700 : AppColors.slate200,
                  ),
                ),
              ),
              child: AppLogo(isCollapsed: isCollapsed),
            ),
          ),

          // Navigation Links
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                PosNavigationButton(
                  label: 'Dashboard',
                  icon: HugeIcons.strokeRoundedDashboardSquare01,
                  isActive: activeRoute == 'dashboard',
                  onTap: () => onRouteSelected('dashboard'),
                  isDark: isDark,
                  isCollapsed: isCollapsed,
                ),
                PosNavigationButton(
                  label: 'Products',
                  icon: HugeIcons.strokeRoundedPackage01,
                  isActive: activeRoute == 'products',
                  onTap: () => onRouteSelected('products'),
                  isDark: isDark,
                  isCollapsed: isCollapsed,
                ),
                PosNavigationButton(
                  label: 'Stock',
                  icon: HugeIcons.strokeRoundedPackage02,
                  isActive: activeRoute == 'stock',
                  onTap: () => onRouteSelected('stock'),
                  isDark: isDark,
                  isCollapsed: isCollapsed,
                ),
                PosNavigationButton(
                  label: 'Reporting',
                  icon: HugeIcons.strokeRoundedChartBarLine,
                  isActive: activeRoute == 'reporting',
                  onTap: () => onRouteSelected('reporting'),
                  isDark: isDark,
                  isCollapsed: isCollapsed,
                ),
                PosNavigationButton(
                  label: 'Members',
                  icon: HugeIcons.strokeRoundedUserAccount,
                  isActive: activeRoute == 'members',
                  onTap: () => onRouteSelected('members'),
                  isDark: isDark,
                  isCollapsed: isCollapsed,
                ),
                PosNavigationButton(
                  label: 'Customers & suppliers',
                  icon: HugeIcons.strokeRoundedUserGroup,
                  isActive: activeRoute == 'customers',
                  onTap: () => onRouteSelected('customers'),
                  isDark: isDark,
                  isCollapsed: isCollapsed,
                ),

                PosNavigationButton(
                  label: 'Users & security',
                  icon: HugeIcons.strokeRoundedKey01,
                  isActive: activeRoute == 'users',
                  onTap: () => onRouteSelected('users'),
                  isDark: isDark,
                  isCollapsed: isCollapsed,
                ),
                PosNavigationButton(
                  label: 'Tax rates',
                  icon: HugeIcons.strokeRoundedPercentSquare,
                  isActive: activeRoute == 'taxes',
                  onTap: () => onRouteSelected('taxes'),
                  isDark: isDark,
                  isCollapsed: isCollapsed,
                ),
                PosNavigationButton(
                  label: 'My company',
                  icon: HugeIcons.strokeRoundedWorkHistory,
                  isActive: activeRoute == 'company',
                  onTap: () => onRouteSelected('company'),
                  isDark: isDark,
                  isCollapsed: isCollapsed,
                ),
              ],
            ),
          ),

          // Footer collapse button
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: isDark ? AppColors.slate700 : AppColors.slate200,
                ),
              ),
            ),
            alignment: isCollapsed ? Alignment.center : Alignment.centerRight,
            child: IconButton(
              onPressed: onToggle,
              icon: Icon(
                isCollapsed ? Icons.arrow_forward : Icons.arrow_back,
                color: AppColors.slate400,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
