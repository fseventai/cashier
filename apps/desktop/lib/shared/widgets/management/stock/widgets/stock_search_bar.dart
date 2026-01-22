import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';

class StockSearchBar extends StatelessWidget {
  const StockSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        color: AppColors.surfaceAlt,
        border: Border(bottom: BorderSide(color: AppColors.surfaceBorder)),
      ),
      child: Row(
        children: [
          const SizedBox(width: 4),
          _IconButton(icon: Icons.filter_list, onTap: () {}),
          const SizedBox(width: 4),
          _IconButton(icon: Icons.view_column, onTap: () {}),
          const SizedBox(width: 4),
          _IconButton(icon: Icons.tag, onTap: () {}),
          const SizedBox(width: 8),
          Expanded(
            child: SizedBox(
              height: 32,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Nama Produk',
                      hintStyle: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.slate400,
                      ),
                      contentPadding: const EdgeInsets.only(
                        left: 32,
                        right: 32,
                        bottom: 12, // Adjust vertical alignment
                      ),
                      filled: true,
                      fillColor: AppColors.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(
                          color: AppColors.surfaceBorder,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(
                          color: AppColors.surfaceBorder,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(
                          color: AppColors.emerald500,
                        ),
                      ),
                    ),
                    style: AppTextStyles.bodyMedium,
                  ),
                  const Positioned(
                    left: 8,
                    child: Icon(
                      Icons.local_offer_outlined,
                      size: 18,
                      color: AppColors.slate400,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.search, size: 18),
                      color: AppColors.slate400,
                      hoverColor: Colors.transparent,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'Products count: ',
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.slate500),
          ),
          Text(
            '0',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.charcoal800,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _IconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      hoverColor: AppColors.slate200,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Icon(icon, size: 20, color: AppColors.slate500),
      ),
    );
  }
}
