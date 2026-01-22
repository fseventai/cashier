import 'package:cashier/shared/components/apps/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';
import 'package:window_manager/window_manager.dart';

class PosHeader extends StatelessWidget {
  const PosHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return DragToMoveArea(
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(bottom: BorderSide(color: AppColors.surfaceBorder)),
        ),
        child: Row(
          children: [
            // Logo Section
            AppLogo(),

            const SizedBox(width: 24),
            Container(height: 32, width: 1, color: AppColors.surfaceBorder),
            const SizedBox(width: 24),

            // Search Bar
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surfaceAlt,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.transparent),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                      color: AppColors.emerald600,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          hintText:
                              'Search products by name, code or barcode...',
                          hintStyle: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textMuted,
                          ),
                        ),
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.charcoal900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 24),

            // Status Badges
            Row(
              children: [
                _buildBadge(
                  icon: Icons.person_outline,
                  label: 'Kasir: Admin',
                  bgColor: AppColors.surfaceAlt,
                  borderColor: AppColors.surfaceBorder,
                  textColor: AppColors.charcoal800,
                  iconColor: AppColors.emerald600,
                ),
                const SizedBox(width: 12),
                _buildBadge(
                  icon: Icons.wifi,
                  label: 'Online',
                  bgColor: AppColors.emerald50,
                  borderColor: AppColors.emerald100,
                  textColor: AppColors.emerald700,
                  iconColor: AppColors
                      .emerald700, // Text color for icon normally, but lets stick to logic
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge({
    required IconData icon,
    required String label,
    required Color bgColor,
    required Color borderColor,
    required Color textColor,
    Color? iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: iconColor ?? textColor),
          const SizedBox(width: 8),
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
