import 'package:cashier/shared/components/apps/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';
import 'package:window_manager/window_manager.dart';

class PosHeaderV2 extends StatelessWidget {
  final VoidCallback onToggleLayout;
  final VoidCallback? onMorePressed;

  const PosHeaderV2({
    super.key,
    required this.onToggleLayout,
    this.onMorePressed,
  });

  @override
  Widget build(BuildContext context) {
    return DragToMoveArea(
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(bottom: BorderSide(color: Color(0xFFF0F5F3))),
        ),
        child: Row(
          children: [
            // Brand Section
            const AppLogo(),
            const SizedBox(width: 32),

            // Search Bar
            const Expanded(child: _SearchBarV2()),

            const SizedBox(width: 32),

            // Layout Switcher
            IconButton(
              onPressed: onToggleLayout,
              icon: const Icon(Icons.swap_horiz, color: AppColors.emerald600),
              tooltip: 'Switch to V1 Layout',
            ),

            const SizedBox(width: 16),

            // Right Actions
            _HeaderActions(onMorePressed: onMorePressed),

            const SizedBox(width: 24),
            const _VerticalDivider(),
            const SizedBox(width: 24),

            // Cashier Profile
            const _CashierProfile(),
          ],
        ),
      ),
    );
  }
}

class _SearchBarV2 extends StatelessWidget {
  const _SearchBarV2();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.slate50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.transparent),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: AppColors.slate400, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari produk (SKU/Nama) atau scan barcode...',
                hintStyle: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.slate400,
                  fontWeight: FontWeight.w500,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.qr_code_scanner,
              color: AppColors.slate500,
              size: 20,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
        ],
      ),
    );
  }
}

class _HeaderActions extends StatelessWidget {
  final VoidCallback? onMorePressed;

  const _HeaderActions({this.onMorePressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [_CircleIconButton(icon: Icons.settings, onTap: onMorePressed)],
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _CircleIconButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: Icon(icon, color: AppColors.slate600, size: 20),
        ),
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 32, color: AppColors.slate200);
  }
}

class _CashierProfile extends StatelessWidget {
  const _CashierProfile();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Rina Wijaya',
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Kasir ID: 8821',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.slate500,
              ),
            ),
          ],
        ),
        const SizedBox(width: 12),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.emerald500.withValues(alpha: 0.1),
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
            image: const DecorationImage(
              image: NetworkImage(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuCxuNkpgkeRkXzGmnLej0iJ_mI7M-iXO2U56ZVyNMPSpZT6FchmaGHxE2msBNZJ03FHyi97OzPGn5Dl4_GsVfFbGE-Oym0Vpt1bh_8RmmKBXFh0S9VoWSGWPplHe5djsyF1fYWQor7_xMasJf2QRzRia44eO2gl3D9d-qAmL480TFgzJmun3l05RDSSEV5nUsB3dbU6GouKD0sau1Jno6XU6TD8IDvInaamQrbzQZsGCTgcTaAlYQUfJ443D5glgFjzS80BeZ-3sto',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
