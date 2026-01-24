import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';
import 'package:cashier/shared/widgets/pos/payment_success_modal.dart';

class PaymentModal extends StatefulWidget {
  final double totalAmount;

  const PaymentModal({super.key, required this.totalAmount});

  @override
  State<PaymentModal> createState() => _PaymentModalState();
}

class _PaymentModalState extends State<PaymentModal> {
  final TextEditingController _customerController = TextEditingController();
  final TextEditingController _paymentController = TextEditingController();
  final FocusNode _paymentFocusNode = FocusNode();
  String _paymentMethod = 'Tunai';
  double _paidAmount = 0;
  bool _isSuccess = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _paymentFocusNode.requestFocus();
    });
    _paymentController.text = '0';
  }

  @override
  void dispose() {
    _customerController.dispose();
    _paymentController.dispose();
    _paymentFocusNode.dispose();
    super.dispose();
  }

  double get _changeAmount {
    if (_paidAmount <= widget.totalAmount) return 0;
    return _paidAmount - widget.totalAmount;
  }

  void _updatePaidAmount(String value) {
    setState(() {
      _paidAmount = double.tryParse(value) ?? 0;
    });
  }

  void _setAmount(double amount) {
    setState(() {
      _paidAmount = amount;
      _paymentController.text = amount.toStringAsFixed(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
        width: _isSuccess ? 1000 : 900,
        height: _isSuccess ? 700 : 650,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 40,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: _isSuccess
              ? PaymentSuccessModal(
                  key: const ValueKey('payment_success'),
                  totalAmount: widget.totalAmount,
                  paidAmount: _paidAmount,
                  paymentMethod: _paymentMethod,
                )
              : Column(
                  key: const ValueKey('payment_form'),
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    _buildHeader(context),

                    // Content
                    Flexible(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          children: [
                            // Summary Cards
                            _buildSummaryCards(),
                            const SizedBox(height: 32),

                            // Inputs Row
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Left Column
                                Expanded(child: _buildLeftColumn()),
                                const SizedBox(width: 40),
                                // Right Column
                                Expanded(child: _buildRightColumn()),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Footer
                    _buildFooter(context),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: AppColors.emerald600,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const HugeIcon(
                icon: HugeIcons.strokeRoundedWallet01,
                color: Colors.white,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Pembayaran',
                style: AppTextStyles.h2.copyWith(color: Colors.white),
              ),
            ],
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const HugeIcon(
              icon: HugeIcons.strokeRoundedCancel01,
              color: Colors.white,
              size: 24,
            ),
            hoverColor: Colors.white.withValues(alpha: 0.1),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Row(
      children: [
        // Total Belanja
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.emerald600,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.emerald600.withValues(alpha: 0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    HugeIcon(
                      icon: HugeIcons.strokeRoundedShoppingCart01,
                      color: Colors.white.withValues(alpha: 0.8),
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'TOTAL BELANJA',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Rp ${widget.totalAmount.toStringAsFixed(0)}',
                  style: AppTextStyles.display.copyWith(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 24),
        // Kembalian
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surfaceAlt,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.surfaceBorder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const HugeIcon(
                      icon: HugeIcons.strokeRoundedWallet01,
                      color: AppColors.textMuted,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'KEMBALIAN',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textMuted,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Rp ${_changeAmount.toStringAsFixed(0)}',
                  style: AppTextStyles.display.copyWith(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: AppColors.emerald600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLeftColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Nama Customer
        _buildInputLabel(HugeIcons.strokeRoundedUser, 'Nama Customer'),
        const SizedBox(height: 8),
        TextField(
          controller: _customerController,
          style: AppTextStyles.bodyMedium,
          decoration: _inputDecoration('Masukkan nama customer (opsional)'),
        ),
        const SizedBox(height: 24),

        // Metode Pembayaran
        _buildInputLabel(
          HugeIcons.strokeRoundedCreditCard,
          'Metode Pembayaran',
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.surfaceAlt,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.surfaceBorder),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _paymentMethod,
              isExpanded: true,
              icon: const HugeIcon(
                icon: HugeIcons.strokeRoundedArrowDown01,
                size: 20,
                color: AppColors.textMuted,
              ),
              items: ['Tunai', 'Debit / QRIS', 'Simpanan Anggota']
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e, style: AppTextStyles.bodyMedium),
                    ),
                  )
                  .toList(),
              onChanged: (v) => setState(() => _paymentMethod = v!),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRightColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Nominal Bayar
        _buildInputLabel(HugeIcons.strokeRoundedMoney03, 'Nominal Bayar'),
        const SizedBox(height: 8),
        TextField(
          controller: _paymentController,
          focusNode: _paymentFocusNode,
          keyboardType: TextInputType.number,
          style: AppTextStyles.h2.copyWith(fontSize: 24),
          onChanged: _updatePaidAmount,
          decoration: _inputDecoration('').copyWith(
            prefixIcon: Container(
              padding: const EdgeInsets.only(left: 16, right: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Rp',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.emerald600,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Quick Amounts
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _buildQuickAmountButton('10k', 10000),
            _buildQuickAmountButton('20k', 20000),
            _buildQuickAmountButton('50k', 50000),
            _buildQuickAmountButton('100k', 100000),
            _buildQuickAmountButton('150k', 150000),
            _buildUangPasButton(),
          ],
        ),
      ],
    );
  }

  Widget _buildInputLabel(List<List<dynamic>> icon, String label) {
    return Row(
      children: [
        HugeIcon(icon: icon, color: AppColors.emerald600, size: 18),
        const SizedBox(width: 8),
        Text(
          label.toUpperCase(),
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.charcoal800,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textMuted),
      filled: true,
      fillColor: AppColors.surfaceAlt,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.surfaceBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.surfaceBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.emerald500, width: 2),
      ),
    );
  }

  Widget _buildQuickAmountButton(String label, double amount) {
    return InkWell(
      onTap: () => _setAmount(amount),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.emerald100, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.emerald700,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildUangPasButton() {
    return InkWell(
      onTap: () => _setAmount(widget.totalAmount),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.emerald500,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.emerald500.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          'Uang Pas',
          style: AppTextStyles.bodySmall.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: const BoxDecoration(
        color: AppColors.surfaceAlt,
        border: Border(top: BorderSide(color: AppColors.surfaceBorder)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildActionButton(
              icon: HugeIcons.strokeRoundedSaveMoneyDollar,
              label: 'Bayar & Simpan',
              isPrimary: true,
              onPressed: () {
                setState(() => _isSuccess = true);
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildActionButton(
              icon: HugeIcons.strokeRoundedPrinter,
              label: 'Bayar & Cetak',
              isPrimary: false,
              onPressed: () {
                setState(() => _isSuccess = true);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required List<List<dynamic>> icon,
    required String label,
    required bool isPrimary,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: isPrimary ? AppColors.emerald600 : Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isPrimary
            ? BorderSide.none
            : const BorderSide(color: AppColors.emerald600, width: 2),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 60,
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              HugeIcon(
                icon: icon,
                color: isPrimary ? Colors.white : AppColors.emerald600,
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: isPrimary ? Colors.white : AppColors.emerald600,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
