import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';
import 'package:cashier/shared/widgets/management/stock/widgets/stock_filter_bar.dart';
import 'package:cashier/shared/widgets/management/stock/widgets/stock_search_bar.dart';

class StockProductList extends StatelessWidget {
  const StockProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const StockFilterBar(),
        const StockSearchBar(),
        // Header
        Container(
          height: 32,
          decoration: const BoxDecoration(
            color: AppColors.slate200,
            border: Border(top: BorderSide(color: AppColors.surfaceBorder)),
          ),
          child: Row(
            children: [
              _HeaderCell(label: 'Code', flex: 2, borderRight: true),
              _HeaderCell(
                label: 'Name',
                flex: 4,
                borderRight: true,
                textColor: AppColors.emerald600,
              ),
              _HeaderCell(
                label: 'Quantity',
                flex: 1,
                borderRight: true,
                alignment: Alignment.centerRight,
              ),
              _HeaderCell(label: 'Unit', flex: 1, borderRight: true),
              _HeaderCell(
                label: 'Cost price',
                flex: 1,
                borderRight: true,
                alignment: Alignment.centerRight,
              ),
              _HeaderCell(
                label: 'Cost',
                flex: 1,
                borderRight: true,
                alignment: Alignment.centerRight,
              ),
              _HeaderCell(
                label: 'Cost incl. tax',
                flex: 2,
                borderRight: false,
                alignment: Alignment.centerRight,
              ),
            ],
          ),
        ),
        // Empty State
        Expanded(
          child: Stack(
            children: [
              // Background grid pattern
              Positioned.fill(child: CustomPaint(painter: GridPainter())),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.inbox_outlined,
                      size: 48,
                      color: AppColors.slate300,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'No items found',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.slate400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String label;
  final int flex;
  final bool borderRight;
  final Alignment alignment;
  final Color? textColor;

  const _HeaderCell({
    required this.label,
    required this.flex,
    this.borderRight = false,
    this.alignment = Alignment.centerLeft,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.slate100,
          border: borderRight
              ? const Border(right: BorderSide(color: Colors.white))
              : null,
        ),
        alignment: alignment,
        child: Text(
          label,
          style: AppTextStyles.tableHeader.copyWith(
            color: textColor ?? AppColors.slate700,
            fontSize: 10, // Match HTML text-xs
          ),
        ),
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.03)
      ..strokeWidth = 1;

    // Approximate the linear-gradient logic from CSS
    // linear-gradient(0deg, transparent 24px, #000 25px); background-size: 100% 25px;
    // This creates horizontal lines every 25 pixels.
    const double rowHeight = 25.0;

    for (double y = rowHeight; y < size.height; y += rowHeight) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
