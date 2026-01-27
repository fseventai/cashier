import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final bool isCollapsed;

  const AppLogo({super.key, this.isCollapsed = false});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.local_mall_outlined,
            color: AppColors.emerald600,
            size: 32,
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: SizedBox(
              width: isCollapsed ? 0 : 150, // Approximate width for logo text
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isCollapsed ? 0 : 1,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  child: Row(
                    children: [
                      const SizedBox(width: 4),
                      RichText(
                        softWrap: false,
                        overflow: TextOverflow.clip,
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
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
