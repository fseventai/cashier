import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';

class CartSummary extends StatelessWidget {
  const CartSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128, // h-32
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        border: const Border(top: BorderSide(color: AppColors.surfaceBorder)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            offset: const Offset(0, -5),
            blurRadius: 15,
          ),
        ],
      ),
      child: Row(
        children: [
          // Breakdown Section (Left)
          Expanded(
            flex: 6,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(color: AppColors.surfaceBorder),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSummaryRow(
                    'Subtotal',
                    'Rp 66.500',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.charcoal800,
                    ),
                  ),
                  _buildSummaryRow(
                    'Hemat Anggota',
                    '- Rp 7.000',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.emerald600,
                    ),
                    isDiscount: true,
                  ),
                  _buildSummaryRow(
                    'Pajak (0%)',
                    'Rp 0',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Total Section (Right)
          // Total Section (Right)
          Expanded(
            flex: 4,
            child: Container(
              color: AppColors.surface,
              child: Stack(
                children: [
                  // Background Blur Effect
                  Positioned(
                    top: -20,
                    right: -20,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: AppColors.emerald50.withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),

                  // Content
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'TOTAL AKHIR',
                            style: AppTextStyles.bodySmall.copyWith(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0, // tracking-widest
                              color: AppColors.textMuted,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text('59.500', style: AppTextStyles.priceLarge),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    required TextStyle style,
    bool isDiscount = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        if (isDiscount)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.emerald50,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(value, style: style),
          )
        else
          Text(value, style: style),
      ],
    );
  }
}
