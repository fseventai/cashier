import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';

class SalesHistoryFooter extends StatelessWidget {
  final int documentCount;
  final double totalAmount;
  final VoidCallback onClose;

  const SalesHistoryFooter({
    super.key,
    required this.documentCount,
    required this.totalAmount,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.slate800 : AppColors.surface,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.slate700 : AppColors.surfaceBorder,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Left side - Document counts
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                text: TextSpan(
                  style: AppTextStyles.bodySmall.copyWith(
                    color: isDark ? AppColors.slate400 : AppColors.textMuted,
                  ),
                  children: [
                    const TextSpan(text: 'Jumlah dokumen: '),
                    TextSpan(
                      text: documentCount.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : AppColors.textMain,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  style: AppTextStyles.bodySmall.copyWith(
                    color: isDark ? AppColors.slate400 : AppColors.textMuted,
                  ),
                  children: [
                    const TextSpan(text: 'Jumlah total: '),
                    TextSpan(
                      text: _formatNumber(totalAmount),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.emerald500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          // Right side - Close button
          _CloseButton(onTap: onClose, isDark: isDark),
        ],
      ),
    );
  }

  String _formatNumber(double value) {
    return value
        .toStringAsFixed(2)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}

class _CloseButton extends StatefulWidget {
  final VoidCallback onTap;
  final bool isDark;

  const _CloseButton({required this.onTap, required this.isDark});

  @override
  State<_CloseButton> createState() => _CloseButtonState();
}

class _CloseButtonState extends State<_CloseButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.emerald600 : AppColors.emerald500,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: AppColors.emerald500.withValues(alpha: 0.3),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            'Tutup',
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
