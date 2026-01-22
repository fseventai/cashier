import 'package:cashier/shared/widgets/management/tax_rates/tax_rates_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:cashier/core/constants/app_colors.dart';
import 'package:cashier/core/constants/app_text_styles.dart';

class TaxRatesContent extends StatelessWidget {
  final VoidCallback onNewTaxRate;

  const TaxRatesContent({super.key, required this.onNewTaxRate});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Ribbon Toolbar
        TaxRatesToolbar(onAdd: onNewTaxRate),

        // Main Content Area
        Expanded(
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
        ),
      ],
    );
  }
}

class _HoverScaleIcon extends StatefulWidget {
  final IconData icon;
  final Color color;
  final Color hoverColor;

  const _HoverScaleIcon({
    required this.icon,
    required this.color,
    required this.hoverColor,
  });

  @override
  State<_HoverScaleIcon> createState() => _HoverScaleIconState();
}

class _HoverScaleIconState extends State<_HoverScaleIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 200),
        tween: Tween<double>(begin: 1.0, end: _isHovered ? 1.1 : 1.0),
        builder: (context, scale, child) {
          return Transform.scale(
            scale: scale,
            child: Icon(
              widget.icon,
              size: 24,
              color: _isHovered ? widget.hoverColor : widget.color,
            ),
          );
        },
      ),
    );
  }
}
