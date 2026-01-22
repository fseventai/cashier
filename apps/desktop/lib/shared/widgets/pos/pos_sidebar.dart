import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:cashier/shared/widgets/pos/action_grid.dart';
import 'package:cashier/core/constants/app_colors.dart';
import 'package:cashier/core/constants/app_text_styles.dart';

class PosSidebar extends StatelessWidget {
  final VoidCallback? onMorePressed;

  const PosSidebar({super.key, this.onMorePressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surfaceAlt,
        border: Border(left: BorderSide(color: AppColors.surfaceBorder)),
      ),
      child: Column(
        children: [
          // Top Action Buttons (Fixed)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              border: Border(
                bottom: BorderSide(color: AppColors.surfaceBorder),
              ),
            ),
            child: ActionGrid(
              crossAxisCount: 4,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1.05, // Adjusted for 4 columns
              children: [
                _ActionButton(
                  icon: HugeIcons.strokeRoundedDelete02,
                  label: 'Hapus',
                  shortcut: 'DEL',
                ),
                _ActionButton(
                  icon: HugeIcons.strokeRoundedPackage01,
                  label: 'Kqty',
                  shortcut: 'F6',
                ),
                _ActionButton(
                  icon: HugeIcons.strokeRoundedShoppingBasket01,
                  label: 'Baru',
                  shortcut: 'F1',
                ),
                _ActionButton(
                  icon: HugeIcons.strokeRoundedUserSearch01,
                  label: 'Member',
                  shortcut: 'F8',
                ),
              ],
            ),
          ),

          // Scrollable Middle Section (User Info & Logo)
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // User Info
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.emerald50.withValues(alpha: 0.3),
                      border: const Border(
                        bottom: BorderSide(color: AppColors.surfaceBorder),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF34d399),
                                Color(0xFF14b8a6),
                              ], // emerald-400 to teal-500
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            border: Border.all(color: Colors.white, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              'B',
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Budi Santoso',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.charcoal900,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  HugeIcon(
                                    icon: HugeIcons.strokeRoundedTicket01,
                                    size: 12,
                                    color: AppColors.emerald700,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Member • 1205 pts',
                                    style: AppTextStyles.bodySmall.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.emerald700,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Store Logo Watermark
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Center(
                      child: Opacity(
                        opacity: 0.1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            HugeIcon(
                              icon: HugeIcons.strokeRoundedStore01,
                              size: 72,
                              color: AppColors.emerald900,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'COOP POS',
                              style: AppTextStyles.display.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                                color: AppColors.emerald900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Section (Function Keys & Pay)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: const Border(
                top: BorderSide(color: AppColors.surfaceBorder),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  offset: const Offset(0, -5),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Column(
              children: [
                ActionGrid(
                  crossAxisCount: 4,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1.05, // Adjusted for 4 columns
                  children: [
                    _FunctionButton(
                      icon: HugeIcons.strokeRoundedDiscount01,
                      label: 'Diskon',
                      shortcut: 'F2',
                    ),
                    _FunctionButton(
                      icon: HugeIcons.strokeRoundedSearch01,
                      label: 'Cari',
                      shortcut: 'F3',
                    ),
                    _FunctionButton(
                      icon: HugeIcons.strokeRoundedUserGroup,
                      label: 'Plg',
                      shortcut: 'F4',
                    ),
                    _FunctionButton(
                      icon: HugeIcons.strokeRoundedWallet01,
                      label: 'Laci',
                      shortcut: 'F5',
                    ),
                    _FunctionButton(
                      icon: HugeIcons.strokeRoundedSaveMoneyDollar,
                      label: 'Simpan',
                      shortcut: 'F9',
                    ),
                    _FunctionButton(
                      icon: HugeIcons.strokeRoundedArrowLeftRight,
                      label: 'Trans',
                      shortcut: 'F7',
                    ),
                    _ConfigButton(
                      icon: HugeIcons.strokeRoundedLock,
                      label: 'Kunci',
                      isRed: true,
                    ),
                    _ConfigButton(
                      icon: HugeIcons.strokeRoundedMoreHorizontal,
                      label: 'Lain',
                      onTap: onMorePressed,
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Pay Button (F10)
                Material(
                  color: AppColors.emerald500,
                  borderRadius: BorderRadius.circular(12),
                  elevation: 4,
                  shadowColor: AppColors.emerald500.withValues(alpha: 0.3),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: 72, // Reduced height
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'F10',
                                style: AppTextStyles.display.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'BAYAR SEKARANG',
                                style: AppTextStyles.bodySmall.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.emerald100,
                                  letterSpacing: 1.0,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: HugeIcon(
                              icon: HugeIcons.strokeRoundedWallet01,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                    ),
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

class _ActionButton extends StatelessWidget {
  final List<List<dynamic>> icon;
  final String label;
  final String? shortcut;

  const _ActionButton({required this.icon, required this.label, this.shortcut});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.surfaceBorder),
      ),
      elevation: 0,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        hoverColor: AppColors.emerald50,
        child: Stack(
          children: [
            if (shortcut != null)
              Positioned(
                top: 6,
                left: 8,
                child: Text(
                  shortcut!,
                  style: AppTextStyles.bodyXSmall.copyWith(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textMuted,
                  ),
                ),
              ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HugeIcon(icon: icon, color: AppColors.emerald600, size: 22),
                  const SizedBox(height: 2),
                  Text(
                    label.toUpperCase(),
                    style: AppTextStyles.buttonLabel.copyWith(fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FunctionButton extends StatelessWidget {
  final List<List<dynamic>> icon;
  final String label;
  final String shortcut;

  const _FunctionButton({
    required this.icon,
    required this.label,
    required this.shortcut,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: AppColors.surfaceBorder),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(8),
        hoverColor: AppColors.emerald50,
        child: Stack(
          children: [
            Positioned(
              top: 6,
              left: 8,
              child: Text(
                shortcut,
                style: AppTextStyles.bodyXSmall.copyWith(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textMuted,
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HugeIcon(icon: icon, color: AppColors.emerald600, size: 20),
                  const SizedBox(height: 2),
                  Text(
                    label.toUpperCase(),
                    style: AppTextStyles.buttonLabel.copyWith(fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConfigButton extends StatelessWidget {
  final List<List<dynamic>> icon;
  final String label;
  final bool isRed;

  final VoidCallback? onTap;

  const _ConfigButton({
    required this.icon,
    required this.label,
    this.isRed = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isRed
        ? const Color(0xFFfef2f2)
        : const Color(0xFFf9fafb); // red-50 or gray-50
    final hoverColor = isRed
        ? const Color(0xFFfee2e2)
        : const Color(0xFFf3f4f6); // red-100 or gray-100
    final borderColor = isRed
        ? const Color(0xFFfecaca)
        : const Color(0xFFe5e7eb); // red-200 or gray-200
    final iconColor = isRed ? Colors.red : Colors.grey;
    final textColor = isRed ? Colors.red[700] : Colors.grey[600];

    return Material(
      color: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: borderColor),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        hoverColor: hoverColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HugeIcon(icon: icon, color: iconColor, size: 20),
            const SizedBox(height: 2),
            Text(
              label.toUpperCase(),
              style: AppTextStyles.buttonLabel.copyWith(
                color: textColor,
                fontSize: 9,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
