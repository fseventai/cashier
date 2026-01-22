import 'package:cashier/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomVerticalDivider extends StatelessWidget {
  final bool isDark;

  const CustomVerticalDivider({super.key, this.isDark = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      color: isDark ? AppColors.slate700 : AppColors.slate200,
    );
  }
}
