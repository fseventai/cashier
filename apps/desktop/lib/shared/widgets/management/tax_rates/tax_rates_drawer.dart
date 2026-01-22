import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';

class TaxRateDrawer extends StatefulWidget {
  const TaxRateDrawer({super.key});

  @override
  State<TaxRateDrawer> createState() => _TaxRateDrawerState();
}

class _TaxRateDrawerState extends State<TaxRateDrawer> {
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  final _rateController = TextEditingController(text: '0');

  bool _isFixed = false;
  bool _isEnabled = true;

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _rateController.dispose();
    super.dispose();
  }

  void _incrementRate() {
    final double current = double.tryParse(_rateController.text) ?? 0;
    setState(() {
      _rateController.text = (current + 1).toInt().toString();
    });
  }

  void _decrementRate() {
    final double current = double.tryParse(_rateController.text) ?? 0;
    if (current > 0) {
      setState(() {
        _rateController.text = (current - 1).toInt().toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      width: 400,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Column(
        children: [
          // Header
          Container(
            height: 64,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isDark ? AppColors.slate700 : AppColors.surfaceBorder,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'New tax rate',
                  style: AppTextStyles.h3.copyWith(
                    fontWeight: FontWeight.w300, // font-light
                    color: isDark ? Colors.white : AppColors.charcoal800,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.arrow_forward,
                    color: isDark ? AppColors.slate400 : AppColors.slate400,
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                _buildField(
                  label: 'NAME',
                  child: TextField(
                    controller: _nameController,
                    autofocus: true,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      // Design shows red border for required
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.emerald600),
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                _buildField(
                  label: 'CODE',
                  child: SizedBox(
                    width: 120,
                    child: TextField(
                      controller: _codeController,
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.surfaceBorder,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.surfaceBorder,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.emerald600),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                _buildField(
                  label: 'RATE',
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.surfaceBorder),
                          borderRadius: BorderRadius.circular(4),
                          color: isDark ? AppColors.slate800 : Colors.white,
                        ),
                        child: Row(
                          children: [
                            _NumberButton(
                              icon: Icons.remove,
                              onTap: _decrementRate,
                            ),
                            Expanded(
                              child: TextField(
                                controller: _rateController,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                            _NumberButton(
                              icon: Icons.add,
                              onTap: _incrementRate,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '%',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Toggles
                _buildToggle(
                  label: 'Fixed',
                  value: _isFixed,
                  onChanged: (v) => setState(() => _isFixed = v),
                ),
                const SizedBox(height: 16),
                _buildToggle(
                  label: 'Enabled',
                  value: _isEnabled,
                  onChanged: (v) => setState(() => _isEnabled = v),
                ),
              ],
            ),
          ),

          // Footer
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.slate800.withValues(alpha: 0.5)
                  : AppColors.surfaceAlt,
              border: Border(
                top: BorderSide(
                  color: isDark ? AppColors.slate700 : AppColors.surfaceBorder,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed:
                        null, // Disabled as per design (cursor-not-allowed)
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.slate400,
                      elevation: 0,
                      side: const BorderSide(color: AppColors.surfaceBorder),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check, size: 16),
                        const SizedBox(width: 8),
                        Text('Simpan', style: AppTextStyles.buttonLabel),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.charcoal800,
                      side: const BorderSide(color: AppColors.surfaceBorder),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.close, size: 16),
                        const SizedBox(width: 8),
                        Text('Batal', style: AppTextStyles.buttonLabel),
                      ],
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

  Widget _buildField({required String label, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            color: AppColors.textMuted,
          ),
        ),
        const SizedBox(height: 4),
        child,
      ],
    );
  }

  Widget _buildToggle({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      children: [
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: Colors.white, // thumb color when on
          activeTrackColor: AppColors.emerald600, // track color when on
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: AppColors.slate300,
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textMain),
        ),
      ],
    );
  }
}

class _NumberButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _NumberButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.transparent, // or slight hover
        ),
        child: Icon(icon, size: 16, color: AppColors.textMuted),
      ),
    );
  }
}
