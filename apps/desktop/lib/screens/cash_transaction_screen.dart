import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';

class CashTransactionScreen extends StatefulWidget {
  const CashTransactionScreen({super.key});

  @override
  State<CashTransactionScreen> createState() => _CashTransactionScreenState();
}

class _CashTransactionScreenState extends State<CashTransactionScreen> {
  bool _isCashIn = true;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _handleClose() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: isDark ? AppColors.charcoal900 : AppColors.surfaceAlt,
      body: Column(
        children: [
          // Header
          _buildHeader(isDark),

          // Main Content
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
              child: Container(
                constraints: BoxConstraints(maxWidth: size.width),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Toggle Buttons
                    _buildToggles(isDark),
                    const SizedBox(height: 40),

                    // Amount Input
                    _buildAmountField(isDark),
                    const SizedBox(height: 32),

                    // Description Input
                    _buildDescriptionField(isDark),
                    const SizedBox(height: 48),

                    // Activity List
                    _buildActivitySection(isDark),
                  ],
                ),
              ),
            ),
          ),

          // Sticky Footer
          _buildFooter(isDark),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.charcoal800 : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: isDark ? AppColors.slate700 : AppColors.surfaceBorder,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: AppColors.emerald500.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const HugeIcon(
                  icon: HugeIcons.strokeRoundedMoney03,
                  color: AppColors.emerald600,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'Uang Masuk / Keluar',
                style: AppTextStyles.h3.copyWith(
                  color: isDark ? Colors.white : AppColors.charcoal900,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: _handleClose,
            icon: Icon(
              Icons.close,
              color: isDark ? AppColors.slate400 : AppColors.textMuted,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            hoverColor: isDark ? AppColors.slate700 : AppColors.emerald50,
          ),
        ],
      ),
    );
  }

  Widget _buildToggles(bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _ToggleBtn(
              label: 'Tambahkan\nuang tunai',
              icon: HugeIcons.strokeRoundedArrowDown03,
              isActive: _isCashIn,
              isPrimary: true,
              onTap: () => setState(() => _isCashIn = true),
            ),
            const SizedBox(width: 24),
            _ToggleBtn(
              label: 'Hapus\nuang tunai',
              icon: HugeIcons.strokeRoundedArrowUp03,
              isActive: !_isCashIn,
              isPrimary: false,
              onTap: () => setState(() => _isCashIn = false),
            ),
          ],
        ),
        const SizedBox(width: 24),
        _ActionSmallBtn(
          label: 'Cash drawer',
          icon: HugeIcons.strokeRoundedPackage,
          onTap: () {},
          isDark: isDark,
        ),
      ],
    );
  }

  Widget _buildAmountField(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Jumlah',
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: isDark ? AppColors.slate300 : AppColors.textMain,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: 350,
          child: TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            style: AppTextStyles.h2.copyWith(
              color: isDark ? Colors.white : AppColors.charcoal900,
            ),
            decoration: InputDecoration(
              hintText: '0',
              hintStyle: TextStyle(
                color: isDark ? AppColors.slate600 : AppColors.slate300,
              ),
              prefixIcon: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Rp',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 0,
                minHeight: 0,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 20,
              ),
              filled: true,
              fillColor: isDark ? AppColors.charcoal800 : Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: isDark ? AppColors.slate700 : AppColors.surfaceBorder,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: isDark ? AppColors.slate700 : AppColors.surfaceBorder,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.emerald600,
                  width: 2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionField(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Deskripsi',
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: isDark ? AppColors.slate300 : AppColors.textMain,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _descriptionController,
          maxLines: 4,
          style: AppTextStyles.bodyMedium.copyWith(
            color: isDark ? Colors.white : AppColors.charcoal900,
          ),
          decoration: InputDecoration(
            hintText:
                'Masukkan alasan untuk menambahkan atau menghapus uang tunai ...',
            hintStyle: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textMuted,
            ),
            contentPadding: const EdgeInsets.all(20),
            filled: true,
            fillColor: isDark ? AppColors.charcoal800 : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark ? AppColors.slate700 : AppColors.surfaceBorder,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark ? AppColors.slate700 : AppColors.surfaceBorder,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.emerald600,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActivitySection(bool isDark) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Entri uang tunai (0)',
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.slate400 : AppColors.textMuted,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Divider(
                color: isDark ? AppColors.slate700 : AppColors.surfaceBorder,
                thickness: 1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 80),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isDark ? AppColors.charcoal800 : Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedInvoice01,
                size: 48,
                color: isDark ? AppColors.slate600 : AppColors.slate300,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Tidak ada catatan',
              style: AppTextStyles.bodyLarge.copyWith(
                color: isDark ? AppColors.slate500 : AppColors.textMuted,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Catatan transaksi uang tunai Anda akan muncul di sini',
              style: AppTextStyles.bodySmall.copyWith(
                color: isDark ? AppColors.slate600 : AppColors.slate400,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFooter(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      decoration: BoxDecoration(
        color: isDark ? AppColors.charcoal800 : Colors.white,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.slate700 : AppColors.surfaceBorder,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(
            onPressed: _handleClose,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
              side: BorderSide(
                color: isDark ? AppColors.slate700 : AppColors.surfaceBorder,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: isDark ? AppColors.charcoal900 : Colors.white,
            ),
            child: Text(
              'Batal',
              style: AppTextStyles.bodyLarge.copyWith(
                color: isDark ? Colors.white : AppColors.textMain,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
              backgroundColor: AppColors.emerald600,
              foregroundColor: Colors.white,
              elevation: 4,
              shadowColor: AppColors.emerald600.withValues(alpha: 0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.check_circle_outline, size: 20),
                const SizedBox(width: 12),
                Text(
                  'Simpan Transaksi',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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

class _ToggleBtn extends StatelessWidget {
  final String label;
  final List<List<dynamic>> icon;
  final bool isActive;
  final bool isPrimary;
  final VoidCallback onTap;

  const _ToggleBtn({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 140,
        height: 140,
        decoration: BoxDecoration(
          color: isActive
              ? (isPrimary
                    ? AppColors.emerald600
                    : (isDark ? AppColors.charcoal800 : Colors.white))
              : (isDark ? AppColors.charcoal800 : Colors.white),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isActive
                ? (isPrimary ? AppColors.emerald600 : AppColors.emerald600)
                : (isDark ? AppColors.slate700 : AppColors.surfaceBorder),
            width: 2.5,
          ),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color:
                        (isPrimary
                                ? AppColors.emerald600
                                : AppColors.emerald500)
                            .withValues(alpha: 0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HugeIcon(
              icon: icon,
              color: isActive
                  ? (isPrimary ? Colors.white : AppColors.emerald600)
                  : AppColors.textMuted,
              size: 36,
            ),
            const SizedBox(height: 16),
            Text(
              label,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.bold,
                height: 1.2,
                color: isActive
                    ? (isPrimary ? Colors.white : AppColors.emerald600)
                    : AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionSmallBtn extends StatelessWidget {
  final String label;
  final List<List<dynamic>> icon;
  final VoidCallback onTap;
  final bool isDark;

  const _ActionSmallBtn({
    required this.label,
    required this.icon,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 140,
        height: 140,
        decoration: BoxDecoration(
          color: isDark ? AppColors.charcoal800 : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? AppColors.slate700 : AppColors.surfaceBorder,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HugeIcon(
              icon: icon,
              color: isDark ? AppColors.slate400 : AppColors.textMuted,
              size: 36,
            ),
            const SizedBox(height: 16),
            Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.slate400 : AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
