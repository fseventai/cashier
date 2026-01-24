import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';

class PaymentSuccessModal extends StatelessWidget {
  final double totalAmount;
  final double paidAmount;
  final String paymentMethod;
  final String transactionId;

  const PaymentSuccessModal({
    super.key,
    required this.totalAmount,
    required this.paidAmount,
    required this.paymentMethod,
    this.transactionId = '#TRX-99283',
  });

  double get _changeAmount {
    if (paidAmount <= totalAmount) return 0;
    return paidAmount - totalAmount;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Left Side: Receipt Preview
        Expanded(
          flex: 5,
          child: Container(
            color: AppColors.slate50,
            padding: const EdgeInsets.all(40),
            child: Center(
              child: SingleChildScrollView(
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOutCubic,
                  tween: Tween(begin: 0.0, end: 1.0),
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(0, 30 * (1 - value)),
                      child: Opacity(opacity: value, child: child),
                    );
                  },
                  child: _ReceiptPreview(
                    totalAmount: totalAmount,
                    paidAmount: paidAmount,
                    changeAmount: _changeAmount,
                    paymentMethod: paymentMethod,
                    transactionId: transactionId,
                  ),
                ),
              ),
            ),
          ),
        ),

        // Vertical Divider
        Container(width: 1, color: AppColors.slate100),

        // Right Side: Actions Panel
        SizedBox(
          width: 350,
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutCubic,
              tween: Tween(begin: 0.0, end: 1.0),
              builder: (context, value, child) {
                return Opacity(opacity: value, child: child);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Langkah Selanjutnya', style: AppTextStyles.h2),
                  const SizedBox(height: 8),
                  Text(
                    'Pilih aksi untuk struk digital atau selesaikan transaksi ini.',
                    style: AppTextStyles.bodySmall,
                  ),
                  const SizedBox(height: 32),
                  _ActionBtn(
                    icon: HugeIcons.strokeRoundedPrinter,
                    label: 'Cetak Struk',
                    onTap: () {},
                  ),
                  const SizedBox(height: 12),
                  _ActionBtn(
                    icon: HugeIcons.strokeRoundedSmartPhone01,
                    label: 'Kirim via WhatsApp',
                    iconColor: const Color(0xFF10b981),
                    hoverBorderColor: const Color(
                      0xFF10b981,
                    ).withValues(alpha: 0.5),
                    hoverBgColor: const Color(
                      0xFF10b981,
                    ).withValues(alpha: 0.05),
                    onTap: () {},
                  ),
                  const SizedBox(height: 12),
                  _ActionBtn(
                    icon: HugeIcons.strokeRoundedMail01,
                    label: 'Kirim ke Email',
                    iconColor: Colors.blue,
                    hoverBorderColor: Colors.blue.withValues(alpha: 0.5),
                    hoverBgColor: Colors.blue.withValues(alpha: 0.05),
                    onTap: () {},
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.emerald500,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Selesai',
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward, size: 20),
                        ],
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

class _ReceiptPreview extends StatelessWidget {
  final double totalAmount;
  final double paidAmount;
  final double changeAmount;
  final String paymentMethod;
  final String transactionId;

  const _ReceiptPreview({
    required this.totalAmount,
    required this.paidAmount,
    required this.changeAmount,
    required this.paymentMethod,
    required this.transactionId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Success Icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.emerald500.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle,
              color: AppColors.emerald500,
              size: 40,
            ),
          ),
          const SizedBox(height: 16),
          Text('Transaksi Berhasil!', style: AppTextStyles.h2),
          Text(
            'Terima kasih atas kunjungan Anda',
            style: AppTextStyles.bodySmall,
          ),
          const SizedBox(height: 24),

          // Store Info
          Text(
            'Koperasi Maju Bersama',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Jl. Merdeka No. 123, Jakarta Pusat',
            style: AppTextStyles.bodyXSmall,
          ),
          Text('Telp: (021) 555-0123', style: AppTextStyles.bodyXSmall),
          const SizedBox(height: 16),

          // Meta Info
          _buildMetaRow('ID Transaksi:', transactionId),
          _buildMetaRow('Kasir:', 'Admin - Budi'),
          _buildMetaRow('Waktu:', '24 Oct 2023, 14:20'),
          const SizedBox(height: 16),

          // DASHED LINE
          CustomPaint(
            size: const Size(double.infinity, 1),
            painter: _DashedLinePainter(),
          ),
          const SizedBox(height: 16),

          // Items (Mocked)
          _buildItemRow('Beras Premium 5kg', '2x Rp 65.000', 130000),
          const SizedBox(height: 12),
          _buildItemRow('Minyak Goreng 2L', '1x Rp 35.000', 35000),
          const SizedBox(height: 12),
          _buildItemRow('Gula Pasir 1kg', '3x Rp 15.000', 45000),
          const SizedBox(height: 16),

          // DASHED LINE
          CustomPaint(
            size: const Size(double.infinity, 1),
            painter: _DashedLinePainter(),
          ),
          const SizedBox(height: 16),

          // Financials
          _buildFinancialRow('Subtotal', totalAmount * 0.9), // mocked
          _buildFinancialRow('Pajak (11%)', totalAmount * 0.1), // mocked
          const SizedBox(height: 8),
          const Divider(thickness: 1, color: AppColors.slate100),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Akhir', style: AppTextStyles.h3),
              Text(
                'Rp ${totalAmount.toStringAsFixed(0)}',
                style: AppTextStyles.h3.copyWith(color: AppColors.emerald600),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Payment Summary
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.slate50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildPaymentSmallRow(
                  'Metode Pembayaran:',
                  paymentMethod,
                  true,
                ),
                _buildPaymentSmallRow(
                  'Bayar:',
                  'Rp ${paidAmount.toStringAsFixed(0)}',
                  false,
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Kembali:',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textMain,
                      ),
                    ),
                    Text(
                      'Rp ${changeAmount.toStringAsFixed(0)}',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textMain,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Barcode Decoration
          _BarcodeDecoration(),
          const SizedBox(height: 8),
          Text(
            'KOPERASI POS DIGITAL',
            style: AppTextStyles.bodyXSmall.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              color: AppColors.slate400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetaRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.bodyXSmall),
          Text(
            value,
            style: AppTextStyles.bodyXSmall.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemRow(String name, String qtyAndPrice, double total) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(qtyAndPrice, style: AppTextStyles.bodyXSmall),
          ],
        ),
        Text(
          'Rp ${total.toStringAsFixed(0)}',
          style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildFinancialRow(String label, double amount) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.slate500),
          ),
          Text(
            'Rp ${amount.toStringAsFixed(0)}',
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.slate500),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSmallRow(String label, String value, bool isBoldValue) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodyXSmall.copyWith(color: AppColors.slate500),
          ),
          Text(
            value,
            style: AppTextStyles.bodyXSmall.copyWith(
              fontWeight: isBoldValue ? FontWeight.bold : FontWeight.normal,
              color: AppColors.slate500,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionBtn extends StatefulWidget {
  final List<List<dynamic>> icon;
  final String label;
  final Color? iconColor;
  final Color? hoverBorderColor;
  final Color? hoverBgColor;
  final VoidCallback onTap;

  const _ActionBtn({
    required this.icon,
    required this.label,
    this.iconColor,
    this.hoverBorderColor,
    this.hoverBgColor,
    required this.onTap,
  });

  @override
  State<_ActionBtn> createState() => _ActionBtnState();
}

class _ActionBtnState extends State<_ActionBtn> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered
                  ? (widget.hoverBorderColor ??
                        AppColors.emerald500.withValues(alpha: 0.5))
                  : AppColors.slate100,
              width: 2,
            ),
            color: _isHovered
                ? (widget.hoverBgColor ??
                      AppColors.emerald500.withValues(alpha: 0.05))
                : Colors.white,
          ),
          child: Row(
            children: [
              HugeIcon(
                icon: widget.icon,
                color: widget.iconColor ?? AppColors.slate400,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.label,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.charcoal900,
                  ),
                ),
              ),
              Icon(Icons.chevron_right, color: AppColors.slate300, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 5;
    double dashSpace = 3;
    final paint = Paint()
      ..color = AppColors.slate200
      ..strokeWidth = 1;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _BarcodeDecoration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      width: double.infinity,
      child: Row(
        children: List.generate(
          40,
          (index) => Expanded(
            child: Container(
              margin: EdgeInsets.only(right: index % 3 == 0 ? 3 : 1),
              color: AppColors.slate100,
            ),
          ),
        ),
      ),
    );
  }
}
