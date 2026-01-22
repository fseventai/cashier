import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';

class StockFilterBar extends StatelessWidget {
  const StockFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.surfaceBorder)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              _FilterCheckbox(
                color: Color(0xFF9ca3af),
                label: 'Negative quantity',
              ),
              SizedBox(width: 16),
              _FilterCheckbox(
                color: Color(0xFF4b5563),
                label: 'Non zero quantity',
              ),
              SizedBox(width: 16),
              _FilterCheckbox(color: Color(0xFF1f2937), label: 'Zero quantity'),
            ],
          ),
          Row(
            children: const [
              _CountBadge(count: 0, color: Colors.red),
              SizedBox(width: 4),
              _CountBadge(count: 0, color: Colors.blue),
              SizedBox(width: 4),
              _CountBadge(count: 0, color: AppColors.emerald600),
            ],
          ),
        ],
      ),
    );
  }
}

class _FilterCheckbox extends StatelessWidget {
  final Color color;
  final String label;

  const _FilterCheckbox({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          Container(
            width: 24,
            height: 16,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.slate600),
          ),
        ],
      ),
    );
  }
}

class _CountBadge extends StatelessWidget {
  final int count;
  final Color color;

  const _CountBadge({required this.count, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        count.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
