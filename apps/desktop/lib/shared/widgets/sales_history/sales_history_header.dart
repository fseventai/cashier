import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';
import 'package:hugeicons/hugeicons.dart';

class SalesHistoryHeader extends StatelessWidget {
  final VoidCallback onClose;

  const SalesHistoryHeader({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: isDark ? AppColors.slate800 : AppColors.surface,
        border: Border(
          bottom: BorderSide(
            color: isDark ? AppColors.slate700 : AppColors.surfaceBorder,
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            'Riwayat penjualan',
            style: AppTextStyles.h2.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : AppColors.textMain,
            ),
          ),
          const Spacer(),
          _CloseButton(onTap: onClose, isDark: isDark),
        ],
      ),
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
        child: HugeIcon(
          icon: HugeIcons.strokeRoundedCancel01,
          size: 24,
          color: _isHovered
              ? Colors.red
              : (widget.isDark ? AppColors.slate400 : AppColors.slate500),
        ),
      ),
    );
  }
}
