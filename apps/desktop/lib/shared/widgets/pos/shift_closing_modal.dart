import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';
import 'package:intl/intl.dart';

class ShiftClosingModal extends StatefulWidget {
  const ShiftClosingModal({super.key});

  @override
  State<ShiftClosingModal> createState() => _ShiftClosingModalState();
}

class _ShiftClosingModalState extends State<ShiftClosingModal> {
  final TextEditingController _actualCashController = TextEditingController();
  final double _expectedBalance = 2800000;
  final double _startingBalance = 500000;
  final double _cashSales = 2350000;
  final double _cashInOut = -50000;

  double _actualCash = 2800000;

  @override
  void initState() {
    super.initState();
    _actualCashController.text = _formatCurrency(_actualCash);
  }

  @override
  void dispose() {
    _actualCashController.dispose();
    super.dispose();
  }

  String _formatCurrency(double amount) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: '',
      decimalDigits: 0,
    ).format(amount).trim();
  }

  void _onActualCashChanged(String value) {
    final cleanValue = value.replaceAll('.', '').replaceAll(',', '');
    setState(() {
      _actualCash = double.tryParse(cleanValue) ?? 0;
      // Keep formatting while typing
      final formatted = _formatCurrency(_actualCash);
      if (formatted != value) {
        _actualCashController.value = TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final difference = _actualCash - _expectedBalance;
    final isBalanced = difference == 0;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Container(
        width: 768, // max-w-3xl
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFdbe6df)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 50,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            _buildHeader(context),

            // Scrollable Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Expected Balance Highlight
                    _buildExpectedBalanceCard(),
                    const SizedBox(height: 32),

                    // Stats Grid
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            label: 'SALDO AWAL',
                            value: _startingBalance,
                            icon: HugeIcons.strokeRoundedWallet01,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildStatCard(
                            label: 'PENJUALAN TUNAI',
                            value: _cashSales,
                            icon: HugeIcons.strokeRoundedMoney03,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildStatCard(
                            label: 'MASUK / KELUAR',
                            value: _cashInOut,
                            icon: HugeIcons.strokeRoundedShuffle,
                            isNegative: _cashInOut < 0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Input & Discrepancy Section
                    _buildInputSection(isBalanced, difference),
                  ],
                ),
              ),
            ),

            // Footer
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFdbe6df))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Manajemen Shift - Penutupan',
                style: AppTextStyles.h2.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.emerald500,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Shift #1024 • Kasir: Budi Santoso',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: const Color(0xFF61896f),
                    ),
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const HugeIcon(
              icon: HugeIcons.strokeRoundedCancel01,
              color: Color(0xFF61896f),
              size: 24,
            ),
            hoverColor: AppColors.slate50,
          ),
        ],
      ),
    );
  }

  Widget _buildExpectedBalanceCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFFf0fdf4), const Color(0xFFf6f8f6)],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFdbe6df)),
      ),
      child: Column(
        children: [
          Text(
            'EKSPEKTASI SALDO LACI',
            style: AppTextStyles.bodySmall.copyWith(
              color: const Color(0xFF61896f),
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Rp ${_formatCurrency(_expectedBalance)}',
            style: AppTextStyles.display.copyWith(
              fontSize: 36,
              fontWeight: FontWeight.w800,
              color: AppColors.charcoal900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Dihitung dari Saldo Awal + Penjualan Tunai + Masuk/Keluar',
            style: AppTextStyles.bodyXSmall.copyWith(
              color: const Color(0xFF61896f).withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String label,
    required double value,
    required List<List<dynamic>> icon,
    bool isNegative = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFdbe6df)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.slate50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: HugeIcon(
                  icon: icon,
                  color: AppColors.charcoal900,
                  size: 16,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTextStyles.bodyXSmall.copyWith(
                  color: const Color(0xFF61896f),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '${isNegative ? '-' : ''} Rp ${_formatCurrency(value.abs())}',
            style: AppTextStyles.h3.copyWith(
              fontSize: 18,
              color: isNegative ? Colors.red.shade600 : AppColors.charcoal900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputSection(bool isBalanced, double difference) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFf6f8f6),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFdbe6df)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Actual Cash Input
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'UANG TUNAI AKTUAL DI LACI',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.charcoal900,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _actualCashController,
                  keyboardType: TextInputType.number,
                  onChanged: _onActualCashChanged,
                  style: AppTextStyles.h2.copyWith(fontSize: 20),
                  decoration: InputDecoration(
                    prefixIcon: Container(
                      padding: const EdgeInsets.only(left: 16, right: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Rp',
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: AppColors.charcoal900.withValues(
                                alpha: 0.4,
                              ),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFdbe6df)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: AppColors.emerald500,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const HugeIcon(
                      icon: HugeIcons.strokeRoundedInformationCircle,
                      color: Color(0xFF61896f),
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Hitung manual uang fisik di laci kasir',
                      style: AppTextStyles.bodyXSmall.copyWith(
                        color: const Color(0xFF61896f),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 32),
          // Discrepancy
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SELISIH (DIFFERENCE)',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF61896f),
                        letterSpacing: 0.5,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: isBalanced
                            ? Colors.green.shade50
                            : Colors.red.shade50,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: isBalanced
                              ? Colors.green.shade200
                              : Colors.red.shade200,
                        ),
                      ),
                      child: Text(
                        isBalanced ? 'BALANCED' : 'DIFFERENCE',
                        style: AppTextStyles.bodyXSmall.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: isBalanced
                              ? Colors.green.shade700
                              : Colors.red.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  height: 56,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isBalanced
                          ? Colors.green.shade300
                          : Colors.red.shade300,
                      style: BorderStyle
                          .solid, // dashed border is not directly supported easily
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: isBalanced
                                  ? Colors.green.shade50
                                  : Colors.red.shade50,
                              shape: BoxShape.circle,
                            ),
                            child: HugeIcon(
                              icon: isBalanced
                                  ? HugeIcons.strokeRoundedCheckList
                                  : HugeIcons.strokeRoundedAlertCircle,
                              color: isBalanced
                                  ? Colors.green.shade600
                                  : Colors.red.shade600,
                              size: 14,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            isBalanced
                                ? 'Sesuai Ekspektasi'
                                : 'Terdapat Selisih',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: isBalanced
                                  ? Colors.green.shade700
                                  : Colors.red.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Rp ${_formatCurrency(difference)}',
                        style: AppTextStyles.h3.copyWith(
                          fontSize: 20,
                          color: isBalanced
                              ? Colors.green.shade600
                              : Colors.red.shade600,
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

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: const BoxDecoration(
        color: Color(0xFFfcfdfc),
        border: Border(top: BorderSide(color: Color(0xFFdbe6df))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Terakhir disimpan: Barusan',
            style: AppTextStyles.bodyXSmall.copyWith(
              color: const Color(0xFF61896f),
            ),
          ),
          Row(
            children: [
              _buildSecondaryButton(
                label: 'CETAK LAPORAN',
                icon: HugeIcons.strokeRoundedPrinter,
                onPressed: () {},
              ),
              const SizedBox(width: 12),
              _buildPrimaryButton(
                label: 'TUTUP SHIFT & KELUAR',
                icon: HugeIcons.strokeRoundedLockPassword,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSecondaryButton({
    required String label,
    required List<List<dynamic>> icon,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF0a3f1d),
        side: const BorderSide(color: AppColors.emerald500, width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      icon: HugeIcon(icon: icon, color: const Color(0xFF0a3f1d), size: 20),
      label: Text(
        label,
        style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildPrimaryButton({
    required String label,
    required List<List<dynamic>> icon,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.emerald500,
        foregroundColor: const Color(0xFF0a3f1d),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 4,
        shadowColor: AppColors.emerald500.withValues(alpha: 0.3),
      ),
      icon: HugeIcon(icon: icon, color: const Color(0xFF0a3f1d), size: 20),
      label: Text(
        label,
        style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
