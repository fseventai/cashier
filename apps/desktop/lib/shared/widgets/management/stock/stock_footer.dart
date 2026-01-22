import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';

class StockFooter extends StatelessWidget {
  const StockFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.surfaceBorder)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SummarySection(
            title: 'Cost price',
            rows: const [
              _SummaryRow(label: 'Total cost:', value: '0.00'),
              _SummaryRow(label: 'Total cost inc. tax:', value: '0.00'),
            ],
          ),
          const SizedBox(width: 48),
          _SummarySection(
            title: 'Sale price',
            rows: const [
              _SummaryRow(label: 'Total:', value: '0.00'),
              _SummaryRow(label: 'Total inc. tax:', value: '0.00'),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummarySection extends StatelessWidget {
  final String title;
  final List<Widget> rows;

  const _SummarySection({required this.title, required this.rows});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 192, // w-48
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 4),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.surfaceBorder),
              ),
            ),
            margin: const EdgeInsets.only(bottom: 4),
            child: Text(
              title,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.slate500,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ...rows,
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.slate600),
          ),
          Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.charcoal800,
            ),
          ),
        ],
      ),
    );
  }
}
