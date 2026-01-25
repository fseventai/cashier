import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';
import 'package:cashier/shared/widgets/management/products/product_drawer/components/form/section_title.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class ImageAndColorTab extends StatelessWidget {
  const ImageAndColorTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        // Product Image Section
        const SectionTitle(title: 'Product image'),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 128,
              height: 128,
              decoration: BoxDecoration(
                color: AppColors.slate50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _DashedRectPainter(color: AppColors.slate300),
                    ),
                  ),
                  const Center(
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedImage01,
                      color: AppColors.slate400,
                      size: 32,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Maximum file size is 2MB. Only .jpg and .png formats are supported.',
                    style: AppTextStyles.bodyXSmall.copyWith(
                      color: AppColors.slate500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildSmallActionBtn(label: 'Upload file', onTap: () {}),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                          textStyle: AppTextStyles.bodyXSmall.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                        child: const Text('Remove'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),

        // POS Color Section
        const SectionTitle(title: 'POS button color'),
        const SizedBox(height: 16),
        _buildColorGrid(),
        const SizedBox(height: 24),

        // Hex Code Input
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hex code',
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.slate700,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 140,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: AppColors.slate200),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  Text(
                    '#',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.slate400,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: TextEditingController(text: '10B981'),
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.slate800,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSmallActionBtn({
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: AppColors.slate200),
        ),
        child: Text(
          label,
          style: AppTextStyles.bodyXSmall.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.slate700,
          ),
        ),
      ),
    );
  }

  Widget _buildColorGrid() {
    final colors = [
      AppColors.slate100,
      Colors.red.shade500,
      Colors.orange.shade500,
      Colors.amber.shade500,
      AppColors.emerald500,
      Colors.blue.shade500,
      Colors.indigo.shade500,
      AppColors.violet500,
      AppColors.rose500,
      Colors.cyan.shade500,
      Colors.teal.shade500,
      Colors.lime.shade500,
      Colors.yellow.shade500,
      AppColors.fuchsia500,
      AppColors.slate500,
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        ...colors.map((color) {
          final isSelected = color == AppColors.emerald500;
          return Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
              border: color == AppColors.slate100
                  ? Border.all(color: AppColors.slate300)
                  : null,
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppColors.emerald600.withValues(alpha: 0.4),
                        blurRadius: 0,
                        spreadRadius: 2,
                        offset: const Offset(0, 0),
                      ),
                    ]
                  : null,
            ),
          );
        }),
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: AppColors.slate200),
          ),
          child: const Center(
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedColorPicker,
              size: 14,
              color: AppColors.slate600,
            ),
          ),
        ),
      ],
    );
  }
}

class _DashedRectPainter extends CustomPainter {
  final Color color;

  _DashedRectPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 1.0;
    const dashWidth = 4.0;
    const dashSpace = 4.0;

    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          const Radius.circular(8),
        ),
      );

    final dashPath = Path();
    for (final metric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        dashPath.addPath(
          metric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
