import 'package:flutter/material.dart';
import 'package:cashier/core/constants/app_colors.dart';
import 'package:cashier/core/constants/app_text_styles.dart';
import 'package:hugeicons/hugeicons.dart';

class CommandToolbarButton extends StatefulWidget {
  final List<List<dynamic>> icon;
  final String label;
  final VoidCallback onTap;
  final bool isDark;
  final Color? iconColor;
  final Color? hoverColor;
  final bool forceIconBold;
  final double width;
  final double? opacity;
  final bool isBold;
  final bool isEnabled;

  const CommandToolbarButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDark = false,
    this.iconColor,
    this.hoverColor,
    this.forceIconBold = false,
    this.width = 80,
    this.opacity,
    this.isBold = false,
    this.isEnabled = true,
  });

  @override
  State<CommandToolbarButton> createState() => CommandToolbarButtonState();
}

class CommandToolbarButtonState extends State<CommandToolbarButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final effectiveIconColor = _isHovered
        ? (widget.hoverColor ?? AppColors.emerald600)
        : (widget.iconColor ??
              (widget.isDark ? AppColors.slate400 : AppColors.slate500));

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          width: widget.width,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: _isHovered
                ? (widget.isDark
                      ? AppColors.slate700.withValues(alpha: 0.5)
                      : AppColors.slate100)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HugeIcon(icon: widget.icon, size: 20, color: effectiveIconColor),
              const SizedBox(height: 4),
              Text(
                widget.label,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyXSmall.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: widget.isDark
                      ? AppColors.slate400
                      : AppColors.slate600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
