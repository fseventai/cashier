import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';

class QuantityInputModal extends StatefulWidget {
  final int initialQuantity;

  const QuantityInputModal({super.key, this.initialQuantity = 1});

  @override
  State<QuantityInputModal> createState() => _QuantityInputModalState();
}

class _QuantityInputModalState extends State<QuantityInputModal> {
  late String _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialQuantity.toString();
  }

  void _onNumberPressed(String value) {
    setState(() {
      if (_currentValue == '0') {
        _currentValue = value;
      } else {
        _currentValue += value;
      }
    });
  }

  void _onClear() {
    setState(() {
      _currentValue = '0';
    });
  }

  void _onBackspace() {
    setState(() {
      if (_currentValue.length > 1) {
        _currentValue = _currentValue.substring(0, _currentValue.length - 1);
      } else {
        _currentValue = '0';
      }
    });
  }

  void _onConfirm() {
    final value = int.tryParse(_currentValue) ?? 0;
    Navigator.of(context).pop(value);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          color: isDark ? AppColors.charcoal800 : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isDark ? AppColors.slate700 : AppColors.slate200,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 40,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Input Quantity',
                    style: AppTextStyles.h3.copyWith(
                      fontSize: 16,
                      color: isDark ? Colors.white : AppColors.charcoal900,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: HugeIcon(
                      icon: HugeIcons.strokeRoundedCancel01,
                      color: isDark ? AppColors.slate400 : AppColors.slate500,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1, color: AppColors.slate200),

            // Display Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              color: isDark
                  ? AppColors.charcoal900.withValues(alpha: 0.5)
                  : AppColors.slate50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  FittedBox(
                    child: Text(
                      _currentValue,
                      style: AppTextStyles.priceLarge.copyWith(
                        color: isDark ? Colors.white : AppColors.charcoal900,
                        fontSize: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1, color: AppColors.slate200),

            // Numpad Grid
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  _buildNumRow(['7', '8', '9'], isDark),
                  const SizedBox(height: 16),
                  _buildNumRow(['4', '5', '6'], isDark),
                  const SizedBox(height: 16),
                  _buildNumRow(['1', '2', '3'], isDark),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildNumpadButton(
                        label: 'C',
                        onPressed: _onClear,
                        isDark: isDark,
                        textColor: Colors.redAccent,
                      ),
                      const SizedBox(width: 16),
                      _buildNumpadButton(
                        label: '0',
                        onPressed: () => _onNumberPressed('0'),
                        isDark: isDark,
                      ),
                      const SizedBox(width: 16),
                      _buildNumpadButton(
                        icon: HugeIcons.strokeRoundedDeletePutBack,
                        onPressed: _onBackspace,
                        isDark: isDark,
                        iconColor: isDark
                            ? AppColors.slate400
                            : AppColors.slate500,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Confirm Button
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: _onConfirm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.emerald600,
                        foregroundColor: Colors.white,
                        elevation: 4,
                        shadowColor: AppColors.emerald600.withValues(
                          alpha: 0.4,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Konfirmasi Quantity',
                            style: AppTextStyles.bodyLarge.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Icon(Icons.arrow_forward, size: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumRow(List<String> values, bool isDark) {
    return Row(
      children: values
          .map(
            (v) => Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: v == values.last ? 0 : 16),
                child: _buildNumpadButton(
                  label: v,
                  onPressed: () => _onNumberPressed(v),
                  isDark: isDark,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildNumpadButton({
    String? label,
    dynamic icon,
    required VoidCallback onPressed,
    required bool isDark,
    Color? textColor,
    Color? iconColor,
  }) {
    return Expanded(
      child: Material(
        color: isDark ? AppColors.slate800 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        elevation: 0,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark ? AppColors.slate700 : AppColors.slate200,
              ),
            ),
            child: label != null
                ? Text(
                    label,
                    style: AppTextStyles.h2.copyWith(
                      color:
                          textColor ??
                          (isDark ? Colors.white : AppColors.charcoal900),
                      fontSize: 20,
                    ),
                  )
                : HugeIcon(
                    icon: icon,
                    color:
                        iconColor ??
                        (isDark ? Colors.white : AppColors.charcoal900),
                    size: 22,
                  ),
          ),
        ),
      ),
    );
  }
}
