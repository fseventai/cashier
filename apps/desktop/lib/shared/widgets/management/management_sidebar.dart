import 'package:cashier/shared/components/apps/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:cashier/core/constants/app_colors.dart';
import 'package:cashier/core/constants/app_text_styles.dart';
import 'package:hugeicons/hugeicons.dart';

class ManagementSidebar extends StatelessWidget {
  final String activeRoute;
  final Function(String) onRouteSelected;

  const ManagementSidebar({
    super.key,
    required this.activeRoute,
    required this.onRouteSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 260,
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
          Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isDark ? AppColors.slate700 : AppColors.slate200,
                ),
              ),
            ),
            child: AppLogo(),
          ),

          // Navigation Links
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                _NavBtn(
                  label: 'Dashboard',
                  icon: HugeIcons.strokeRoundedDashboardSquare01,
                  isActive: activeRoute == 'dashboard',
                  onTap: () => onRouteSelected('dashboard'),
                  isDark: isDark,
                ),
                _NavBtn(
                  label: 'Products',
                  icon: HugeIcons.strokeRoundedPackage01,
                  isActive: activeRoute == 'products',
                  onTap: () => onRouteSelected('products'),
                  isDark: isDark,
                ),
                _NavBtn(
                  label: 'Stock',
                  icon: HugeIcons.strokeRoundedPackage02,
                  isActive: activeRoute == 'stock',
                  onTap: () => onRouteSelected('stock'),
                  isDark: isDark,
                ),
                _NavBtn(
                  label: 'Reporting',
                  icon: HugeIcons.strokeRoundedChartBarLine,
                  isActive: activeRoute == 'reporting',
                  onTap: () => onRouteSelected('reporting'),
                  isDark: isDark,
                ),
                _NavBtn(
                  label: 'Customers & suppliers',
                  icon: HugeIcons.strokeRoundedUserGroup,
                  isActive: activeRoute == 'customers',
                  onTap: () => onRouteSelected('customers'),
                  isDark: isDark,
                ),

                _NavBtn(
                  label: 'Users & security',
                  icon: HugeIcons.strokeRoundedKey01,
                  isActive: activeRoute == 'users',
                  onTap: () => onRouteSelected('users'),
                  isDark: isDark,
                ),
                _NavBtn(
                  label: 'Tax rates',
                  icon: HugeIcons.strokeRoundedPercentSquare,
                  isActive: activeRoute == 'taxes',
                  onTap: () => onRouteSelected('taxes'),
                  isDark: isDark,
                ),
                _NavBtn(
                  label: 'My company',
                  icon: HugeIcons.strokeRoundedWorkHistory,
                  isActive: activeRoute == 'company',
                  onTap: () => onRouteSelected('company'),
                  isDark: isDark,
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
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {},
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedCircleArrowMoveDownLeft,
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

class _NavBtn extends StatefulWidget {
  final String label;
  final List<List<dynamic>> icon;
  final bool isActive;
  final VoidCallback onTap;
  final bool isDark;

  const _NavBtn({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onTap,
    required this.isDark,
  });

  @override
  State<_NavBtn> createState() => _NavBtnState();
}

class _NavBtnState extends State<_NavBtn> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final contentColor = widget.isActive
        ? AppColors.emerald700
        : (_isHovered
              ? AppColors.emerald600
              : (widget.isDark ? AppColors.slate400 : AppColors.slate600));

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 12),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: widget.isActive
                ? (widget.isDark
                      ? AppColors.emerald900.withValues(alpha: 0.2)
                      : AppColors.emerald100)
                : (_isHovered
                      ? (widget.isDark
                            ? AppColors.slate700.withValues(alpha: 0.5)
                            : AppColors.slate100)
                      : Colors.transparent),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              HugeIcon(icon: widget.icon, size: 20, color: contentColor),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.label,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: widget.isActive
                        ? FontWeight.w600
                        : FontWeight.w500,
                    color: contentColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
