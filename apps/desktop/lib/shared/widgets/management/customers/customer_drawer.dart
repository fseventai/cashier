import 'package:flutter/material.dart';
import 'package:cashier/core/constants/app_colors.dart';
import 'package:cashier/core/constants/app_text_styles.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomerDrawer extends StatefulWidget {
  const CustomerDrawer({super.key});

  @override
  State<CustomerDrawer> createState() => _CustomerDrawerState();
}

class _CustomerDrawerState extends State<CustomerDrawer> {
  int _activeTab = 0;
  final List<String> _tabs = [
    'General',
    'Discounts',
    'Loyalty cards',
    'Payment terms',
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      width: 672, // max-w-2xl is 672px
      shape: const RoundedRectangleBorder(),
      backgroundColor: isDark ? AppColors.slate900 : Colors.white,
      child: Column(
        children: [
          // Header
          _buildHeader(isDark),

          // Content Wrapper
          Expanded(
            child: Column(
              children: [
                // Tabs
                _buildTabs(isDark),

                // Content
                Expanded(child: _buildTabContent(isDark)),
              ],
            ),
          ),

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
        color: isDark ? AppColors.slate900 : Colors.white,
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
            'New customer / supplier',
            style: AppTextStyles.h2.copyWith(
              fontSize: 20,
              color: isDark ? AppColors.slate200 : AppColors.slate700,
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedArrowRight01,
              color: AppColors.slate400,
              size: 24,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs(bool isDark) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isDark ? AppColors.slate700 : AppColors.slate200,
          ),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: _tabs.asMap().entries.map((entry) {
            final idx = entry.key;
            final label = entry.value;
            final isActive = _activeTab == idx;

            return InkWell(
              onTap: () => setState(() => _activeTab = idx),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 16,
                ),
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
                    fontWeight: FontWeight.w500,
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
        Text(
          'General info',
          style: AppTextStyles.h3.copyWith(
            fontSize: 18,
            color: isDark ? AppColors.slate300 : AppColors.slate600,
          ),
        ),
        const SizedBox(height: 20),

        _buildInputField(
          label: 'Name',
          isDark: isDark,
          isRequired: true,
          hasError: true,
        ),
        const SizedBox(height: 16),
        _buildInputField(label: 'Code', isDark: isDark, width: 128),
        const SizedBox(height: 16),
        _buildInputField(label: 'Tax number', isDark: isDark, width: 192),
        const SizedBox(height: 16),
        _buildInputField(label: 'Street name', isDark: isDark),
        const SizedBox(height: 16),
        _buildInputField(label: 'Building number', isDark: isDark, width: 128),
        const SizedBox(height: 16),
        _buildInputField(label: 'Additional street name', isDark: isDark),
        const SizedBox(height: 16),
        _buildInputField(
          label: 'Plot identification',
          isDark: isDark,
          width: 256,
        ),
        const SizedBox(height: 16),
        _buildInputField(
          label: 'District',
          isDark: isDark,
          width: 448, // approx 2/3 of 672
        ),
        const SizedBox(height: 16),
        _buildInputField(label: 'Kode Pos', isDark: isDark, width: 128),
        const SizedBox(height: 16),
        _buildInputField(label: 'Kota', isDark: isDark, width: 448),
        const SizedBox(height: 16),
        _buildInputField(label: 'State / Province', isDark: isDark, width: 448),

        const SizedBox(height: 80), // spacer for bottom padding
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
            fontWeight: FontWeight.w500,
            color: isDark ? AppColors.slate400 : AppColors.slate700,
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: width ?? double.infinity,
          child: TextFormField(
            initialValue: initialValue,
            maxLines: maxLines,
            style: AppTextStyles.bodySmall.copyWith(
              color: isDark ? AppColors.slate200 : AppColors.slate800,
            ),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              filled: true,
              fillColor: isDark ? AppColors.slate800 : Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(
                  color: hasError
                      ? Colors.red
                      : (isDark ? AppColors.slate600 : AppColors.slate300),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(
                  color: hasError
                      ? Colors.red
                      : (isDark ? AppColors.slate600 : AppColors.slate300),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(
                  color: hasError ? Colors.red : AppColors.emerald600,
                  width: 2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
          ),
          const SizedBox(width: 12),
          _buildFooterBtn(
            label: 'Simpan',
            icon: HugeIcons.strokeRoundedTick01,
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
    bool isPrimary = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isDark
              ? (isPrimary ? AppColors.slate700 : AppColors.slate700)
              : Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isDark ? AppColors.slate600 : AppColors.slate300,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            HugeIcon(
              icon: icon,
              size: 16,
              color: isPrimary
                  ? AppColors.slate400
                  : (isDark ? AppColors.slate200 : AppColors.slate500),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.slate200 : AppColors.slate700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
