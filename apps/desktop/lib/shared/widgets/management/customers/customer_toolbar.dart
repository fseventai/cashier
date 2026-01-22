import 'package:flutter/material.dart';
import 'package:cashier/core/constants/app_colors.dart';
import 'package:cashier/core/constants/app_text_styles.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomerToolbar extends StatelessWidget {
  final VoidCallback? onRefresh;
  final VoidCallback? onAdd;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onImport;
  final VoidCallback? onExport;
  final VoidCallback? onHelp;

  const CustomerToolbar({
    super.key,
    this.onRefresh,
    this.onAdd,
    this.onEdit,
    this.onDelete,
    this.onImport,
    this.onExport,
    this.onHelp,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? AppColors.slate800 : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: isDark ? AppColors.slate700 : AppColors.slate200,
          ),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            _ToolbarBtn(
              icon: HugeIcons.strokeRoundedRefresh,
              label: 'Segarkan',
              onTap: onRefresh ?? () {},
              isDark: isDark,
            ),
            _buildSeparator(isDark),
            _ToolbarBtn(
              icon: HugeIcons.strokeRoundedAdd01,
              label: 'Tambah',
              onTap: onAdd ?? () {},
              isDark: isDark,
              iconColor: AppColors.emerald600,
              forceIconBold: true,
            ),
            _ToolbarBtn(
              icon: HugeIcons.strokeRoundedPencilEdit02,
              label: 'Edit',
              onTap: onEdit,
              isDark: isDark,
              isEnabled: onEdit != null,
            ),
            _ToolbarBtn(
              icon: HugeIcons.strokeRoundedDelete02,
              label: 'Hapus',
              onTap: onDelete,
              isDark: isDark,
              isEnabled: onDelete != null,
              hoverColor: Colors.red,
            ),
            _buildSeparator(isDark),
            _ToolbarBtn(
              icon: HugeIcons.strokeRoundedDownload02,
              label: 'Import',
              onTap: onImport ?? () {},
              isDark: isDark,
            ),
            _ToolbarBtn(
              icon: HugeIcons.strokeRoundedUpload02,
              label: 'Export',
              onTap: onExport ?? () {},
              isDark: isDark,
            ),
            _buildSeparator(isDark),
            _ToolbarBtn(
              icon: HugeIcons.strokeRoundedHelpCircle,
              label: 'Bantuan',
              onTap: onHelp ?? () {},
              isDark: isDark,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeparator(bool isDark) {
    return Container(
      height: 40,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      color: isDark ? AppColors.slate700 : AppColors.slate200,
    );
  }
}

class _ToolbarBtn extends StatefulWidget {
  final List<List<dynamic>> icon;
  final String label;
  final VoidCallback? onTap;
  final bool isDark;
  final bool isEnabled;
  final Color? iconColor;
  final Color? hoverColor;
  final bool forceIconBold;

  const _ToolbarBtn({
    required this.icon,
    required this.label,
    this.onTap,
    required this.isDark,
    this.isEnabled = true,
    this.iconColor,
    this.hoverColor,
    this.forceIconBold = false,
  });

  @override
  State<_ToolbarBtn> createState() => _ToolbarBtnState();
}

class _ToolbarBtnState extends State<_ToolbarBtn> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool effectivelyEnabled = widget.isEnabled && widget.onTap != null;

    final effectiveIconColor = !effectivelyEnabled
        ? (widget.isDark ? AppColors.slate600 : AppColors.slate300)
        : (_isHovered
              ? (widget.hoverColor ?? AppColors.emerald600)
              : (widget.iconColor ??
                    (widget.isDark ? AppColors.slate400 : AppColors.slate500)));

    return MouseRegion(
      onEnter: (_) {
        if (effectivelyEnabled) setState(() => _isHovered = true);
      },
      onExit: (_) {
        if (effectivelyEnabled) setState(() => _isHovered = false);
      },
      cursor: effectivelyEnabled
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: effectivelyEnabled ? widget.onTap : null,
        child: Container(
          width: 80,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: (effectivelyEnabled && _isHovered)
                ? (widget.isDark
                      ? AppColors.slate700.withValues(alpha: 0.5)
                      : AppColors.slate100)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HugeIcon(icon: widget.icon, size: 22, color: effectiveIconColor),
              const SizedBox(height: 4),
              Text(
                widget.label,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyXSmall.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: !effectivelyEnabled
                      ? (widget.isDark
                            ? AppColors.slate600
                            : AppColors.slate300)
                      : (widget.isDark
                            ? AppColors.slate400
                            : AppColors.slate600),
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
