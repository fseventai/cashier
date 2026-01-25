import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: AppTextStyles.bodyXSmall.copyWith(
        fontWeight: FontWeight.w700,
        color: AppColors.slate900,
        letterSpacing: 1.2,
      ),
    );
  }
}
