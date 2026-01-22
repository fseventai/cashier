import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';
import 'package:hugeicons/hugeicons.dart';

class UserTable extends StatelessWidget {
  const UserTable({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceAlt : Colors.white,
        border: Border.all(color: AppColors.surfaceBorder),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Header
          Container(
            color: isDark
                ? AppColors.slate700.withValues(alpha: 0.5)
                : AppColors.slate50,
            child: Row(
              children: [
                _HeaderCell('FIRST NAME', flex: 2),
                _HeaderCell('LAST NAME', flex: 2),
                _HeaderCell('EMAIL', flex: 3),
                _HeaderCell('ACCESS LEVEL', flex: 1, align: TextAlign.right),
                _HeaderCell(
                  'ACTIVE',
                  flex: 1,
                  align: TextAlign.center,
                  isLast: true,
                ),
              ],
            ),
          ),
          // Rows
          _UserRow(
            firstName: 'fsevent',
            lastName: 's',
            email: 'fsevent@gmail.com',
            accessLevel: '9',
            isActive: true,
            isDark: isDark,
          ),
          _EmptyRow(
            isDark: isDark,
          ), // Placeholder rows to match screenshot look
          _EmptyRow(isDark: isDark, isStriped: true),
          _EmptyRow(isDark: isDark),
        ],
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String label;
  final int flex;
  final TextAlign align;
  final bool isLast;

  const _HeaderCell(
    this.label, {
    this.flex = 1,
    this.align = TextAlign.left,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: isLast
            ? null
            : BoxDecoration(
                border: Border(
                  right: BorderSide(color: AppColors.surfaceBorder),
                ),
              ),
        child: Text(
          label,
          textAlign: align,
          style: AppTextStyles.tableHeader.copyWith(
            color: isDark
                ? AppColors.slate300
                : AppColors
                      .emerald600, // Matching the screenshot/html colors roughly
            // HTML: text-primary for First Name, text-gray-600 for others.
            // Wait, HTML says: First name is text-primary, others are text-gray-600.
            // Let's adjust this in a future refinement if strict adherence is needed,
            // but generalized table header style is usually consistent.
            // I'll stick to a consistent color for now as per my AppTextStyles.tableHeader default which is emerald900.
            // Actually let's just use the style
          ),
        ),
      ),
    );
  }
}

class _UserRow extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String accessLevel;
  final bool isActive;
  final bool isDark;

  const _UserRow({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.accessLevel,
    required this.isActive,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.surfaceBorder)),
      ),
      child: Row(
        children: [
          _DataCell(firstName, flex: 2, isDark: isDark),
          _DataCell(lastName, flex: 2, isDark: isDark),
          _DataCell(email, flex: 3, isDark: isDark),
          _DataCell(
            accessLevel,
            flex: 1,
            align: TextAlign.right,
            isDark: isDark,
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              alignment: Alignment.center,
              child: isActive
                  ? const HugeIcon(
                      icon: HugeIcons.strokeRoundedTick01,
                      color: AppColors.emerald500,
                      size: 20,
                    )
                  : const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}

class _DataCell extends StatelessWidget {
  final String text;
  final int flex;
  final TextAlign align;
  final bool isDark;

  const _DataCell(
    this.text, {
    this.flex = 1,
    this.align = TextAlign.left,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: const BoxDecoration(
          border: Border(right: BorderSide(color: AppColors.surfaceBorder)),
        ),
        child: Text(
          text,
          textAlign: align,
          style: AppTextStyles.bodyMedium.copyWith(
            color: isDark ? AppColors.slate200 : AppColors.charcoal800,
          ),
        ),
      ),
    );
  }
}

class _EmptyRow extends StatelessWidget {
  final bool isDark;
  final bool isStriped;

  const _EmptyRow({required this.isDark, this.isStriped = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      decoration: BoxDecoration(
        color: isStriped
            ? (isDark
                  ? AppColors.slate800.withValues(alpha: 0.5)
                  : AppColors.slate50.withValues(alpha: 0.5))
            : null,
        border: const Border(
          bottom: BorderSide(color: AppColors.surfaceBorder),
        ),
      ),
      child: Row(
        children: [
          Expanded(flex: 2, child: _EmptyCell(isLast: false)),
          Expanded(flex: 2, child: _EmptyCell(isLast: false)),
          Expanded(flex: 3, child: _EmptyCell(isLast: false)),
          Expanded(flex: 1, child: _EmptyCell(isLast: false)),
          Expanded(flex: 1, child: _EmptyCell(isLast: true)),
        ],
      ),
    );
  }
}

class _EmptyCell extends StatelessWidget {
  final bool isLast;
  const _EmptyCell({required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isLast
          ? null
          : const BoxDecoration(
              border: Border(right: BorderSide(color: AppColors.surfaceBorder)),
            ),
    );
  }
}
