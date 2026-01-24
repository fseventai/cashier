import 'dart:io';
import 'package:cashier/shared/components/apps/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';
import 'package:cashier/core/constants/apps/app_routes.dart';
import 'package:window_manager/window_manager.dart';
import 'package:intl/intl.dart';

class PosMenuDrawer extends StatefulWidget {
  const PosMenuDrawer({super.key});

  @override
  State<PosMenuDrawer> createState() => _PosMenuDrawerState();
}

class _PosMenuDrawerState extends State<PosMenuDrawer> with WindowListener {
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    _checkInitialState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  Future<void> _checkInitialState() async {
    final isFullScreen = await windowManager.isFullScreen();
    if (mounted) {
      setState(() {
        _isFullScreen = isFullScreen;
      });
    }
  }

  @override
  void onWindowEnterFullScreen() {
    setState(() {
      _isFullScreen = true;
    });
  }

  @override
  void onWindowLeaveFullScreen() {
    setState(() {
      _isFullScreen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 320,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Column(
        children: [
          // Header
          _buildHeader(context),

          // Menu Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _buildMenuItem(
                  icon: HugeIcons.strokeRoundedSettings03,
                  label: 'Management',
                  onTap: () {
                    Navigator.pop(context); // Close drawer
                    Navigator.pushNamed(context, AppRoutes.management);
                  },
                ),
                const Divider(
                  height: 16,
                  indent: 24,
                  endIndent: 24,
                  color: AppColors.surfaceBorder,
                ),
                _buildMenuItem(
                  icon: HugeIcons.strokeRoundedTransactionHistory,
                  label: 'Riwayat penjualan',
                  onTap: () {
                    Navigator.pop(context); // Close drawer
                    Navigator.pushNamed(context, AppRoutes.salesHistory);
                  },
                ),
                _buildMenuItem(
                  icon: HugeIcons.strokeRoundedInbox,
                  label: 'Uang Masuk / Keluar  (pro)',
                  onTap: () {
                    Navigator.pop(context); // Close drawer
                    Navigator.pushNamed(context, AppRoutes.cashTransaction);
                  },
                ),
                _buildMenuItem(
                  icon: HugeIcons
                      .strokeRoundedCells, // Using something for "Akhiri Hari Ini"
                  label: 'Akhiri Hari Ini',
                  onTap: () {},
                ),
                const SizedBox(height: 16),
                _buildSectionHeader('PENGGUNA'),
                _buildMenuItem(
                  icon: HugeIcons.strokeRoundedUser,
                  label: 'Info Pengguna',
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: HugeIcons.strokeRoundedLogout01,
                  label: 'Keluar',
                  onTap: () {},
                ),
              ],
            ),
          ),

          // Footer
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.surfaceBorder)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const AppLogo(),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_forward, size: 20),
            color: AppColors.charcoal800,
            hoverColor: AppColors.emerald50,
            style: IconButton.styleFrom(
              padding: const EdgeInsets.all(4),
              minimumSize: Size.zero,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        children: [
          Text(
            title,
            style: AppTextStyles.bodyXSmall.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textMuted,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(child: Divider(color: AppColors.surfaceBorder)),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required List<List<dynamic>> icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      hoverColor: AppColors.emerald50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Row(
          children: [
            HugeIcon(icon: icon, color: Colors.black, size: 20),
            const SizedBox(width: 16),
            Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.charcoal900,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    final today = DateFormat('dd/MM/yyyy').format(DateTime.now());

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt.withValues(alpha: 0.3),
        border: const Border(top: BorderSide(color: AppColors.surfaceBorder)),
      ),
      child: Column(
        children: [
          Text(
            today,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: AppColors.textMuted,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildFooterButton(
                HugeIcons.strokeRoundedSlidersHorizontal,
                onTap: () {},
              ),
              _buildFooterButton(
                HugeIcons.strokeRoundedCancelCircle,
                onTap: () => windowManager.close(),
              ),
              _buildFooterButton(
                _isFullScreen
                    ? HugeIcons.strokeRoundedMinimizeScreen
                    : HugeIcons.strokeRoundedArrowExpand,
                onTap: () async {
                  if (_isFullScreen) {
                    await windowManager.setFullScreen(false);
                  } else {
                    await windowManager.setFullScreen(true);
                  }
                  if (context.mounted) Navigator.pop(context);
                },
              ),
              _buildFooterButton(
                HugeIcons.strokeRoundedShutDown,
                onTap: () async {
                  final result = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Konfirmasi'),
                      content: const Text(
                        'Apakah Anda yakin ingin mematikan komputer?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Batal'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.red,
                          ),
                          child: const Text('Matikan'),
                        ),
                      ],
                    ),
                  );

                  if (result == true) {
                    if (Platform.isWindows) {
                      await Process.run('shutdown', ['/s', '/t', '0']);
                    } else {
                      // fallback for non-windows if needed, or just close app
                      await windowManager.close();
                    }
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooterButton(List<List<dynamic>> icon, {VoidCallback? onTap}) {
    return IconButton(
      onPressed: onTap,
      icon: HugeIcon(icon: icon, color: AppColors.charcoal900, size: 24),
      hoverColor: AppColors.emerald50,
      padding: const EdgeInsets.all(8),
    );
  }
}
