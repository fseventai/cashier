import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';
import 'package:hugeicons/hugeicons.dart';

class ProductDrawer extends StatefulWidget {
  const ProductDrawer({super.key});

  @override
  State<ProductDrawer> createState() => _ProductDrawerState();
}

class _ProductDrawerState extends State<ProductDrawer> {
  int _activeTab = 0;
  final List<String> _tabs = [
    'Details',
    'Price & tax',
    'Stock control',
    'Comments',
    'Image & color',
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      width: 600,
      shape: const RoundedRectangleBorder(),
      backgroundColor: isDark ? AppColors.slate800 : Colors.white,
      child: Column(
        children: [
          // Header
          _buildHeader(isDark),

          // Tabs
          _buildTabs(isDark),

          // Content
          Expanded(child: _buildTabContent(isDark)),

          // Footer
          _buildFooter(isDark),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: isDark ? AppColors.slate800 : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: isDark ? AppColors.slate700 : AppColors.slate200,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'New product',
            style: AppTextStyles.h2.copyWith(
              color: isDark ? Colors.white : AppColors.slate800,
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedCancel01,
              color: AppColors.slate400,
              size: 20,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            hoverColor: Colors.red.withValues(alpha: 0.1),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.slate800.withValues(alpha: 0.5)
            : AppColors.slate50,
        border: Border(
          bottom: BorderSide(
            color: isDark ? AppColors.slate700 : AppColors.slate200,
          ),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _tabs.asMap().entries.map((entry) {
            final idx = entry.key;
            final label = entry.value;
            final isActive = _activeTab == idx;

            return InkWell(
              onTap: () => setState(() => _activeTab = idx),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                margin: const EdgeInsets.only(right: 24),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isActive
                          ? AppColors.emerald600
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  label,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                    color: isActive
                        ? AppColors.emerald600
                        : (isDark ? AppColors.slate400 : AppColors.slate500),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildTabContent(bool isDark) {
    if (_activeTab != 0) {
      return Center(
        child: Text(
          '${_tabs[_activeTab]} Content Coming Soon',
          style: TextStyle(color: AppColors.slate500),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildInputField(
          label: 'Name',
          isDark: isDark,
          isRequired: true,
          hasError: true, // Matching HTML preview which has red border
        ),
        const SizedBox(height: 20),
        _buildInputField(
          label: 'Code',
          isDark: isDark,
          width: 128,
          initialValue: '1',
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInputField(label: 'Barcode', isDark: isDark),
            const SizedBox(height: 4),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Text(
                'Generate barcode',
                style: AppTextStyles.bodyXSmall.copyWith(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildInputField(
          label: 'Unit of measurement',
          isDark: isDark,
          width: 160,
        ),
        const SizedBox(height: 20),
        _buildDropdown(
          label: 'Group',
          isDark: isDark,
          value: 'Products',
          items: ['Products'],
        ),
        const SizedBox(height: 24),
        _buildSwitch(
          label: 'Active',
          value: true,
          onChanged: (v) {},
          isDark: isDark,
        ),
        _buildSwitch(
          label: 'Default quantity',
          value: true,
          onChanged: (v) {},
          isDark: isDark,
        ),
        _buildSwitch(
          label: 'Service (not using stock)',
          value: false,
          onChanged: (v) {},
          isDark: isDark,
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildInputField(
              label: 'Age restriction',
              isDark: isDark,
              width: 96,
            ),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Text(
                'year(s)',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.slate500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildInputField(label: 'Description', isDark: isDark, maxLines: 4),
      ],
    );
  }

  Widget _buildInputField({
    required String label,
    required bool isDark,
    double? width,
    bool isRequired = false,
    bool hasError = false,
    String? initialValue,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.slate300 : AppColors.slate700,
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: width,
          child: TextFormField(
            initialValue: initialValue,
            maxLines: maxLines,
            style: AppTextStyles.bodySmall.copyWith(
              color: isDark ? Colors.white : AppColors.slate800,
            ),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              filled: true,
              fillColor: isDark ? AppColors.slate800 : Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: hasError
                      ? Colors.red
                      : (isDark ? AppColors.slate600 : AppColors.slate200),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: hasError
                      ? Colors.red
                      : (isDark ? AppColors.slate600 : AppColors.slate200),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: hasError ? Colors.red : AppColors.emerald600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required bool isDark,
    required String value,
    required List<String> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.slate300 : AppColors.slate700,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: isDark ? AppColors.slate800 : Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: isDark ? AppColors.slate600 : AppColors.slate200,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedArrowDown01,
                size: 16,
                color: AppColors.slate400,
              ),
              dropdownColor: isDark ? AppColors.slate800 : Colors.white,
              items: items
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: isDark ? Colors.white : AppColors.slate800,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (v) {},
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSwitch({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
    required bool isDark,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Transform.scale(
            scale: 0.8,
            alignment: Alignment.centerLeft,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeThumbColor: Colors.white,
              activeTrackColor: AppColors.emerald600,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: isDark
                  ? AppColors.slate700
                  : AppColors.slate200,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w500,
              color: isDark ? AppColors.slate300 : AppColors.slate700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.slate800.withValues(alpha: 0.5)
            : AppColors.slate50,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.slate700 : AppColors.slate200,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildFooterBtn(
            label: 'Batal',
            icon: HugeIcons.strokeRoundedCancel01,
            onTap: () => Navigator.of(context).pop(),
            isDark: isDark,
            isGhost: true,
          ),
          const SizedBox(width: 12),
          _buildFooterBtn(
            label: 'Simpan',
            icon: HugeIcons.strokeRoundedCheckmarkCircle02,
            onTap: () {},
            isDark: isDark,
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
    required bool isDark,
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
          border: Border.all(
            color: isPrimary ? AppColors.slate200 : AppColors.slate200,
          ),
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
                color: isDark && isGhost
                    ? AppColors.slate300
                    : AppColors.slate700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
