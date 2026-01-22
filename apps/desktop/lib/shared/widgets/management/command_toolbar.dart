import 'package:flutter/material.dart';
import 'package:cashier/core/constants/app_colors.dart';
import 'package:cashier/core/constants/app_text_styles.dart';
import 'package:hugeicons/hugeicons.dart';

class CommandToolbar extends StatelessWidget {
  const CommandToolbar({super.key});

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
              onTap: () {},
              isDark: isDark,
            ),
            _buildSeparator(isDark),
            _ToolbarBtn(
              icon: HugeIcons.strokeRoundedFolderAdd,
              label: 'New group',
              onTap: () {},
              isDark: isDark,
            ),
            _ToolbarBtn(
              icon: HugeIcons.strokeRoundedFolderLinks,
              label: 'Edit group',
              onTap: () {},
              isDark: isDark,
            ),
            _ToolbarBtn(
              icon: HugeIcons.strokeRoundedFolderRemove,
              label: 'Delete group',
              onTap: () {},
              isDark: isDark,
              hoverColor: Colors.red,
            ),
            _buildSeparator(isDark),
            _ToolbarBtn(
              icon: HugeIcons.strokeRoundedAdd02,
              label: 'New product',
              onTap: () {},
              isDark: isDark,
              iconColor: AppColors.emerald600,
              forceIconBold: true,
            ),
            _ToolbarBtn(
              icon: HugeIcons.strokeRoundedPencilEdit02,
              label: 'Edit product',
              onTap: () {},
              isDark: isDark,
            ),
            _ToolbarBtn(
              icon: HugeIcons.strokeRoundedDelete02,
              label: 'Delete product',
              onTap: () {},
              isDark: isDark,
              hoverColor: Colors.red,
            ),
            _buildSeparator(isDark),
            _ToolbarBtn(
              icon: HugeIcons.strokeRoundedPrinter,
              label: 'Cetak',
              onTap: () {},
              isDark: isDark,
            ),
            _ToolbarBtn(
              icon: HugeIcons.strokeRoundedPdf02,
              label: 'Simpan PDF',
              onTap: () {},
              isDark: isDark,
            ),
            _buildSeparator(isDark),
            _ToolbarBtn(
              icon: HugeIcons.strokeRoundedTag02,
              label: 'Price tags',
              onTap: () {},
              isDark: isDark,
            ),
            _ToolbarBtn(
              icon: HugeIcons.strokeRoundedSorting02,
              label: 'Sorting',
              onTap: () {},
              isDark: isDark,
            ),
            _ToolbarBtn(
              icon: HugeIcons.strokeRoundedAnalytics02,
              label: 'Mov. avg. price',
              onTap: () {},
              isDark: isDark,
            ),
            _buildSeparator(isDark),
            _ToolbarBtn(
              icon: HugeIcons.strokeRoundedDownload02,
              label: 'Import',
              onTap: () {},
              isDark: isDark,
            ),
            _ToolbarBtn(
              icon: HugeIcons.strokeRoundedUpload02,
              label: 'Export',
              onTap: () {},
              isDark: isDark,
            ),
            _ToolbarBtn(
              icon: HugeIcons.strokeRoundedHelpCircle,
              label: 'Bantuan',
              onTap: () {},
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
  final VoidCallback onTap;
  final bool isDark;
  final Color? iconColor;
  final Color? hoverColor;
  final bool forceIconBold;

  const _ToolbarBtn({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.isDark,
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
          width: 80,
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
