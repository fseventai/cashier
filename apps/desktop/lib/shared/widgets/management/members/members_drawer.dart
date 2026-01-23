import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:dropdown_search/dropdown_search.dart';

class MembersDrawer extends StatefulWidget {
  const MembersDrawer({super.key});

  @override
  State<MembersDrawer> createState() => _MembersDrawerState();
}

class _MembersDrawerState extends State<MembersDrawer> {
  final _formKey = GlobalKey<FormState>();
  String _loyaltyLevel = 'Bronze';
  final List<String> _loyaltyLevels = ['Bronze', 'Silver', 'Gold', 'Platinum'];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      width: 450,
      shape: const RoundedRectangleBorder(),
      backgroundColor: isDark ? AppColors.slate900 : Colors.white,
      child: Column(
        children: [
          // Header
          _buildHeader(isDark),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInputField(
                      label: 'Full Name',
                      placeholder: 'Enter full name',
                      isDark: isDark,
                    ),
                    const SizedBox(height: 20),
                    _buildInputField(
                      label: 'Identity Number (NIK)',
                      placeholder: '16-digit NIK',
                      isDark: isDark,
                    ),
                    const SizedBox(height: 20),
                    _buildInputField(
                      label: 'Phone Number',
                      placeholder: 'e.g. 0812...',
                      isDark: isDark,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 20),
                    _buildInputField(
                      label: 'Email',
                      placeholder: 'name@example.com',
                      isDark: isDark,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildInputField(
                            label: 'Initial Deposit',
                            isDark: isDark,
                            prefix: 'Rp',
                            initialValue: '0',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildDropdownField(
                            label: 'Loyalty Level',
                            value: _loyaltyLevel,
                            items: _loyaltyLevels,
                            onChanged: (val) =>
                                setState(() => _loyaltyLevel = val!),
                            isDark: isDark,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
            'Add member',
            style: AppTextStyles.h2.copyWith(
              fontSize: 20,
              color: isDark ? Colors.white : AppColors.slate800,
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedCancel01,
              color: AppColors.slate400,
              size: 24,
            ),
            hoverColor: Colors.red.withValues(alpha: 0.1),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required bool isDark,
    String? placeholder,
    String? initialValue,
    String? prefix,
    TextInputType? keyboardType,
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
        const SizedBox(height: 6),
        TextFormField(
          initialValue: initialValue,
          keyboardType: keyboardType,
          style: AppTextStyles.bodyMedium.copyWith(
            color: isDark ? Colors.white : AppColors.slate800,
          ),
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.slate400,
            ),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            prefixIcon: prefix != null
                ? Container(
                    padding: const EdgeInsets.only(left: 12, right: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          prefix,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.slate400,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                : null,
            prefixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
            filled: true,
            fillColor: isDark ? AppColors.slate800 : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(
                color: isDark ? AppColors.slate600 : AppColors.slate200,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(
                color: isDark ? AppColors.slate600 : AppColors.slate200,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                color: AppColors.emerald600,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required bool isDark,
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
        const SizedBox(height: 6),
        DropdownSearch<String>(
          items: (filter, loadProps) => items,
          selectedItem: value,
          onChanged: onChanged,
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 4,
              ),
              filled: true,
              fillColor: isDark ? AppColors.slate800 : Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: isDark ? AppColors.slate600 : AppColors.slate200,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: isDark ? AppColors.slate600 : AppColors.slate200,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  color: AppColors.emerald600,
                  width: 1.5,
                ),
              ),
            ),
            baseStyle: AppTextStyles.bodyMedium.copyWith(
              color: isDark ? Colors.white : AppColors.slate800,
            ),
          ),
          popupProps: PopupProps.menu(
            showSearchBox: false,
            fit: FlexFit.loose,
            menuProps: MenuProps(
              backgroundColor: isDark ? AppColors.slate800 : Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            itemBuilder: (context, item, isSelected, isHover) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                color: isSelected
                    ? AppColors.emerald600.withValues(alpha: 0.1)
                    : Colors.transparent,
                child: Text(
                  item,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: isSelected
                        ? AppColors.emerald600
                        : (isDark ? AppColors.slate200 : AppColors.slate800),
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              );
            },
          ),
        ),
      ],
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
          _buildButton(
            label: 'Batal',
            onTap: () => Navigator.of(context).pop(),
            isDark: isDark,
            isSecondary: true,
          ),
          const SizedBox(width: 12),
          _buildButton(
            label: 'Simpan',
            onTap: () {
              if (_formKey.currentState!.validate()) {
                // Handle save
              }
            },
            isDark: isDark,
            isPrimary: true,
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required String label,
    required VoidCallback onTap,
    required bool isDark,
    bool isPrimary = false,
    bool isSecondary = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isPrimary
              ? AppColors.emerald600
              : (isDark ? AppColors.slate800 : Colors.white),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: isPrimary
                ? AppColors.emerald600
                : (isDark ? AppColors.slate600 : AppColors.slate200),
          ),
          boxShadow: isPrimary
              ? [
                  BoxShadow(
                    color: AppColors.emerald600.withValues(alpha: 0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: isPrimary
                ? Colors.white
                : (isDark ? AppColors.slate200 : AppColors.slate700),
          ),
        ),
      ),
    );
  }
}
