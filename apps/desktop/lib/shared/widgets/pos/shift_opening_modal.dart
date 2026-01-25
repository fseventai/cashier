import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';

class ShiftOpeningModal extends StatefulWidget {
  const ShiftOpeningModal({super.key});

  @override
  State<ShiftOpeningModal> createState() => _ShiftOpeningModalState();
}

class _ShiftOpeningModalState extends State<ShiftOpeningModal> {
  final TextEditingController _saldoController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final FocusNode _saldoFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _saldoFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _saldoController.dispose();
    _noteController.dispose();
    _saldoFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Container(
        width: 640,
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            _buildHeader(context),

            const Divider(height: 1, color: AppColors.slate100),

            // Form Content
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row 1: Info (Read Only)
                  Row(
                    children: [
                      Expanded(
                        child: _buildReadOnlyField(
                          label: 'Nama Kasir',
                          value: 'Budi Santoso',
                          icon: HugeIcons.strokeRoundedUser,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildReadOnlyField(
                          label: 'Waktu Buka',
                          value: '24 Okt 2023, 08:00',
                          icon: HugeIcons.strokeRoundedClock01,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Row 2: Saldo Awal (Large Input)
                  _buildSaldoInput(),
                  const SizedBox(height: 24),

                  // Row 3: Notes
                  _buildNoteInput(),
                ],
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 32, 32, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Manajemen Shift - Pembukaan',
                  style: AppTextStyles.h2.copyWith(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Verifikasi identitas dan masukkan saldo awal tunai laci kas.',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const HugeIcon(
              icon: HugeIcons.strokeRoundedCancel01,
              color: AppColors.textMuted,
              size: 24,
            ),
            hoverColor: AppColors.slate100,
          ),
        ],
      ),
    );
  }

  Widget _buildReadOnlyField({
    required String label,
    required String value,
    required List<List<dynamic>> icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.charcoal800,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.slate50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.slate200),
          ),
          child: Row(
            children: [
              HugeIcon(icon: icon, color: AppColors.textMuted, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  value,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const HugeIcon(
                icon: HugeIcons.strokeRoundedLockPassword,
                color: AppColors.slate300,
                size: 18,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSaldoInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Saldo Awal Tunai',
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.emerald50,
                borderRadius: BorderRadius.circular(9999),
                border: Border.all(color: AppColors.emerald100),
              ),
              child: Text(
                'Wajib Diisi',
                style: AppTextStyles.bodyXSmall.copyWith(
                  color: AppColors.emerald700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _saldoController,
          focusNode: _saldoFocusNode,
          keyboardType: TextInputType.number,
          style: AppTextStyles.display.copyWith(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppColors.charcoal900,
          ),
          decoration: InputDecoration(
            hintText: '0',
            hintStyle: const TextStyle(color: AppColors.slate300),
            prefixIcon: Container(
              padding: const EdgeInsets.only(left: 16, right: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Rp',
                    style: AppTextStyles.display.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.charcoal900,
                    ),
                  ),
                ],
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 18),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.slate200, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: AppColors.emerald500,
                width: 2,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Pastikan nominal sesuai dengan uang fisik di laci.',
          style: AppTextStyles.bodyXSmall.copyWith(color: AppColors.textMuted),
        ),
      ],
    );
  }

  Widget _buildNoteInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'Catatan Pembukaan ',
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.charcoal800,
            ),
            children: [
              TextSpan(
                text: '(Opsional)',
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _noteController,
          maxLines: 4,
          minLines: 3,
          style: AppTextStyles.bodyMedium,
          decoration: InputDecoration(
            hintText:
                'Tuliskan kondisi laci kas, jumlah receh, atau catatan penting lainnya...',
            hintStyle: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.slate400,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.slate200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.emerald500),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
      child: Material(
        color: AppColors.emerald500,
        borderRadius: BorderRadius.circular(16),
        elevation: 4,
        shadowColor: AppColors.emerald500.withValues(alpha: 0.3),
        child: InkWell(
          onTap: () => Navigator.pop(context),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            height: 60,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const HugeIcon(
                  icon: HugeIcons.strokeRoundedCreditCardPos,
                  color: Colors.white,
                  size: 22,
                ),
                const SizedBox(width: 12),
                Text(
                  'BUKA SHIFT & LACI KAS',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
