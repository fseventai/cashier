import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class PosNavigationButton extends StatefulWidget {
  final String label;
  final List<List<dynamic>> icon;
  final bool isActive;
  final VoidCallback onTap;
  final bool isDark;

  const PosNavigationButton({
    super.key,
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onTap,
    required this.isDark,
  });

  @override
  State<PosNavigationButton> createState() => _PosNavigationButtonState();
}

class _PosNavigationButtonState extends State<PosNavigationButton> {
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
