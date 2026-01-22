import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:cashier/shared/widgets/management/users/user_table.dart';

class UsersSecurityContent extends StatefulWidget {
  const UsersSecurityContent({super.key});

  @override
  State<UsersSecurityContent> createState() => _UsersSecurityContentState();
}

class _UsersSecurityContentState extends State<UsersSecurityContent> {
  String _activeTab = 'Users';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        // Tabs
        Container(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            border: Border(bottom: BorderSide(color: AppColors.surfaceBorder)),
          ),
          child: Row(
            children: [
              _TabButton(
                label: 'Users',
                isActive: _activeTab == 'Users',
                onTap: () => setState(() => _activeTab = 'Users'),
              ),
              const SizedBox(width: 32),
              _TabButton(
                label: 'Security',
                isActive: _activeTab == 'Security',
                onTap: () => setState(() => _activeTab = 'Security'),
              ),
            ],
          ),
        ),

        // Content
        Expanded(
          child: Container(
            color: isDark
                ? AppColors.surfaceAlt
                : AppColors.surface, // Background slightly off-white usually
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const UserTable(),
                const SizedBox(height: 16),

                // Empty state area (No additional users found)
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.surfaceBorder,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    // Dashed border effect is tricky in pure Flutter without external package or custom painter.
                    // For now using solid border with opacity or just standard border.
                    // The screenshot shows dashed border.
                    // I will implement a CustomPaint for dashed border if strictly needed,
                    // but standard border with opacity is a good MVP.
                    child: Opacity(
                      opacity: 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          HugeIcon(
                            icon: HugeIcons
                                .strokeRoundedGridOff, // Or GridOff material icon
                            size: 48,
                            color: isDark
                                ? AppColors.slate500
                                : AppColors.slate400,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'No additional users found',
                            style: AppTextStyles.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? AppColors.emerald500 : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            color: isActive ? AppColors.emerald500 : AppColors.textMuted,
          ),
        ),
      ),
    );
  }
}
