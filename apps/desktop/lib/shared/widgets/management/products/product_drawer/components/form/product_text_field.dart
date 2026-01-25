import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';
import 'package:flutter/material.dart';

class ProductTextField extends StatelessWidget {
  final String label;
  final double? width;
  final bool isRequired;
  final bool hasError;
  final String? initialValue;
  final int maxLines;
  final String? placeholder;
  final String? suffix;
  final TextInputType? keyboardType;

  const ProductTextField({
    super.key,
    required this.label,
    this.width,
    this.isRequired = false,
    this.hasError = false,
    this.initialValue,
    this.maxLines = 1,
    this.placeholder,
    this.suffix,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.slate700,
            ),
          ),
          const SizedBox(height: 4),
        ],
        SizedBox(
          width: width,
          child: TextFormField(
            initialValue: initialValue,
            maxLines: maxLines,
            keyboardType: keyboardType,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.slate800),
            decoration: InputDecoration(
              isDense: true,
              hintText: placeholder,
              hintStyle: AppTextStyles.bodySmall.copyWith(
                color: AppColors.slate400,
              ),
              suffixText: suffix,
              suffixStyle: AppTextStyles.bodyXSmall.copyWith(
                color: AppColors.slate400,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: hasError ? Colors.red : AppColors.slate200,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: hasError ? Colors.red : AppColors.slate200,
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
}
