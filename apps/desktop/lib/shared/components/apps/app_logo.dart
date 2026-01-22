import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.local_mall_outlined,
          color: AppColors.emerald600,
          size: 32,
        ),
        const SizedBox(width: 4),
        RichText(
          text: TextSpan(
            style: AppTextStyles.display.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
            children: const [
              TextSpan(
                text: 'Coop',
                style: TextStyle(color: AppColors.emerald600),
              ),
              TextSpan(
                text: 'POS',
                style: TextStyle(color: AppColors.charcoal900),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
