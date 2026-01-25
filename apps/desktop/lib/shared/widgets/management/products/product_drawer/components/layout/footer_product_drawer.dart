import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class FooterProductDrawer extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onSave;

  const FooterProductDrawer({
    super.key,
    required this.onCancel,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.slate50,
        border: Border(top: BorderSide(color: AppColors.slate200)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildFooterBtn(
            label: 'Batal',
            icon: HugeIcons.strokeRoundedCancel01,
            onTap: onCancel,
            isGhost: true,
          ),
          const SizedBox(width: 12),
          _buildFooterBtn(
            label: 'Simpan',
            icon: HugeIcons.strokeRoundedCheckmarkCircle02,
            onTap: onSave,
            isPrimary: true,
          ),
        ],
      ),
    );
  }

  Widget _buildFooterBtn({
    required String label,
    required List<List<dynamic>> icon,
    required VoidCallback onTap,
    bool isGhost = false,
    bool isPrimary = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isPrimary
              ? Colors.white
              : (isGhost ? Colors.transparent : Colors.white),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: AppColors.slate200),
          boxShadow: isPrimary
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            HugeIcon(
              icon: icon,
              size: 18,
              color: isPrimary ? AppColors.emerald600 : AppColors.slate600,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.slate700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
