import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';

class TaxRatesContent extends StatelessWidget {
  final VoidCallback onNewTaxRate;

  const TaxRatesContent({super.key, required this.onNewTaxRate});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        color: AppColors.surfaceAlt, // background-light
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border.all(color: AppColors.surfaceBorder),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.visibility_off_outlined,
                size: 96, // roughly 8xl or close to it
                color: AppColors.slate300,
              ),
              const SizedBox(height: 16),
              Text(
                'No taxes',
                style: AppTextStyles.h2.copyWith(
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 4),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: onNewTaxRate,
                  child: Text(
                    'Add new tax',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.emerald600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
