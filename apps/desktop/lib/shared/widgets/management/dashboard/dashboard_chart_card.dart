import 'package:flutter/material.dart';
import 'package:cashier/core/constants/app_colors.dart';
import 'package:cashier/core/constants/app_text_styles.dart';
import 'package:hugeicons/hugeicons.dart';

class DashboardChartCard extends StatelessWidget {
  const DashboardChartCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark ? AppColors.slate700 : AppColors.slate100;
    final iconColor = isDark ? AppColors.slate400 : AppColors.slate400;

    return Container(
      height: 320,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? AppColors.slate800 : AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Monthly Sales - 2025',
                    style: AppTextStyles.h2.copyWith(
                      color: isDark ? AppColors.slate50 : AppColors.slate800,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Sales data grouped by month',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: isDark ? AppColors.slate500 : AppColors.slate500,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  _IconButton(
                    icon: HugeIcons.strokeRoundedRefresh,
                    color: iconColor,
                    onTap: () {},
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.slate200),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _IconButton(
                          icon: HugeIcons
                              .strokeRoundedTaskDaily02, // Minimal view assumption
                          color: AppColors
                              .slate50, // Active bg implicit simulation
                          backgroundColor: AppColors.slate300,
                          onTap: () {},
                          padding: 4,
                        ),
                        _IconButton(
                          icon: HugeIcons.strokeRoundedCalendar03, // Grid view
                          color: iconColor,
                          onTap: () {},
                          padding: 4,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  _IconButton(
                    icon: HugeIcons.strokeRoundedArrowLeft01,
                    color: iconColor,
                    onTap: () {},
                  ),
                  _IconButton(
                    icon: HugeIcons.strokeRoundedArrowRight01,
                    color: iconColor,
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Chart Area
          Expanded(
            child: Row(
              children: [
                // Chart Content
                Expanded(
                  child: Stack(
                    children: [
                      // Grid Lines
                      CustomPaint(
                        size: Size.infinite,
                        painter: _ChartGridPainter(
                          color: isDark
                              ? AppColors.slate700
                              : AppColors.slate100,
                        ),
                      ),
                      // Axis Labels (Bottom)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            12,
                            (index) => Text(
                              '0',
                              style: AppTextStyles.bodyXSmall.copyWith(
                                color: AppColors.slate400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Axis Label (Month)
                      Positioned(
                        bottom: -20, // Visual adjustment
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Text(
                            'Month',
                            style: AppTextStyles.bodyXSmall.copyWith(
                              color: AppColors.slate400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final dynamic icon;
  final Color color;
  final VoidCallback onTap;
  final double padding;
  final Color? backgroundColor;

  const _IconButton({
    required this.icon,
    required this.color,
    required this.onTap,
    this.padding = 8,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: EdgeInsets.all(padding),
        color: backgroundColor,
        child: HugeIcon(icon: icon, color: color, size: 18),
      ),
    );
  }
}

class _ChartGridPainter extends CustomPainter {
  final Color color;

  _ChartGridPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Dash effect
    const dashWidth = 4;
    const dashSpace = 4;

    // Draw 4 horizontal lines
    final step = size.height / 4;
    for (int i = 0; i < 5; i++) {
      double y = step * i;
      if (i == 4) y = size.height - 1; // Align last one

      double startX = 0;
      while (startX < size.width) {
        canvas.drawLine(
          Offset(startX, y),
          Offset(startX + dashWidth, y),
          paint,
        );
        startX += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
