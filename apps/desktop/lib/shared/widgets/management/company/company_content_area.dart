import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';

class CompanyContentArea extends StatefulWidget {
  const CompanyContentArea({super.key});

  @override
  State<CompanyContentArea> createState() => _CompanyContentAreaState();
}

class _CompanyContentAreaState extends State<CompanyContentArea> {
  int _activeTab = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        // Tabs
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 0),
          decoration: BoxDecoration(
            color: isDark ? AppColors.slate800 : Colors.white,
            border: Border(
              bottom: BorderSide(
                color: isDark ? AppColors.slate700 : AppColors.slate200,
              ),
            ),
          ),
          child: Row(
            children: [
              _buildTab('COMPANY DATA', 0, isDark),
              _buildTab('VOID REASONS', 1, isDark),
              _buildTab('RESET DATABASE', 2, isDark),
            ],
          ),
        ),

        // Content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_activeTab == 0) ...[
                      _buildCompanyDataForm(isDark),
                    ] else ...[
                      Text(
                        'Coming Soon',
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: isDark ? Colors.white70 : Colors.black54,
                        ),
                      ),
                    ],
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTab(String label, int index, bool isDark) {
    final isActive = _activeTab == index;
    return InkWell(
      onTap: () => setState(() => _activeTab = index),
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? AppColors.emerald600 : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.w600,
            color: isActive
                ? AppColors.emerald600
                : (isDark ? AppColors.slate400 : AppColors.slate500),
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildCompanyDataForm(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInputField(
          label: 'Name',
          isFullWidth: true,
          isDark: isDark,
          borderColor:
              Colors.red.shade400, // Matching the HTML example's red border
        ),
        const SizedBox(height: 24),
        _buildInputField(label: 'Tax number', isDark: isDark, widthFactor: 0.5),
        const SizedBox(height: 24),
        _buildInputField(
          label: 'Street name',
          isFullWidth: true,
          isDark: isDark,
          maxLines: 3,
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: _buildInputField(label: 'Building number', isDark: isDark),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInputField(
                label: 'Additional street name',
                isDark: isDark,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: _buildInputField(
                label: 'Plot identification',
                isDark: isDark,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInputField(label: 'District', isDark: isDark),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: _buildInputField(label: 'Postal code', isDark: isDark),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInputField(label: 'City', isDark: isDark),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: _buildInputField(label: 'Province', isDark: isDark),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildDropdownField(label: 'Country', isDark: isDark),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: _buildInputField(label: 'Phone', isDark: isDark),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInputField(label: 'Email', isDark: isDark),
            ),
          ],
        ),
        const SizedBox(height: 48),

        // Bank Account Section
        _buildSectionHeader('BANK ACCOUNT', isDark),
        const SizedBox(height: 24),
        _buildInputField(
          label: 'Bank acc. number',
          isDark: isDark,
          widthFactor: 0.5,
        ),
        const SizedBox(height: 24),
        _buildInputField(
          label: 'Bank details',
          isFullWidth: true,
          isDark: isDark,
          maxLines: 3,
        ),
        const SizedBox(height: 48),

        // Logo Section
        _buildSectionHeader('LOGO', isDark),
        const SizedBox(height: 24),
        Row(
          children: [
            _buildButton('Browse', isDark),
            const SizedBox(width: 12),
            _buildButton('Clear', isDark),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, bool isDark) {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyles.bodyXSmall.copyWith(
            fontWeight: FontWeight.w700,
            color: isDark ? AppColors.slate400 : AppColors.slate400,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            height: 1,
            color: isDark ? AppColors.slate700 : AppColors.slate100,
          ),
        ),
      ],
    );
  }

  Widget _buildInputField({
    required String label,
    bool isFullWidth = false,
    double? widthFactor,
    int maxLines = 1,
    required bool isDark,
    Color? borderColor,
  }) {
    Widget field = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.slate300 : AppColors.slate700,
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: widthFactor != null
              ? null
              : (isFullWidth ? double.infinity : null),
          child: TextField(
            maxLines: maxLines,
            style: AppTextStyles.bodyMedium.copyWith(
              color: isDark ? Colors.white : AppColors.slate900,
            ),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(
                  color:
                      borderColor ??
                      (isDark ? AppColors.slate600 : AppColors.slate300),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(
                  color: borderColor ?? AppColors.emerald600,
                  width: 1.5,
                ),
              ),
              filled: true,
              fillColor: isDark ? AppColors.slate800 : Colors.white,
            ),
          ),
        ),
      ],
    );

    if (widthFactor != null) {
      return FractionallySizedBox(widthFactor: widthFactor, child: field);
    }
    return field;
  }

  Widget _buildDropdownField({required String label, required bool isDark}) {
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
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.slate800 : Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: isDark ? AppColors.slate600 : AppColors.slate300,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              const Expanded(child: SizedBox()),
              Icon(
                Icons.keyboard_arrow_down,
                size: 20,
                color: isDark ? AppColors.slate400 : AppColors.slate400,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButton(String label, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? AppColors.slate800 : Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isDark ? AppColors.slate600 : AppColors.slate300,
        ),
      ),
      child: Text(
        label,
        style: AppTextStyles.bodySmall.copyWith(
          fontWeight: FontWeight.w600,
          color: isDark ? Colors.white : AppColors.slate700,
        ),
      ),
    );
  }
}
