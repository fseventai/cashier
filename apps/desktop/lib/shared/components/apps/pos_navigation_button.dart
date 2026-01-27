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
  final bool isCollapsed;

  const PosNavigationButton({
    super.key,
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onTap,
    required this.isDark,
    this.isCollapsed = false,
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

    return Tooltip(
      message: widget.isCollapsed ? widget.label : '',
      waitDuration: const Duration(milliseconds: 500),
      child: MouseRegion(
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
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              child: Row(
                mainAxisAlignment: widget.isCollapsed
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  HugeIcon(icon: widget.icon, size: 20, color: contentColor),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: SizedBox(
                      width: widget.isCollapsed
                          ? 0
                          : 180, // Target width for the text area
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: widget.isCollapsed ? 0 : 1,
                          child: Row(
                            children: [
                              const SizedBox(width: 12),
                              Text(
                                widget.label,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  fontWeight: widget.isActive
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  color: contentColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
