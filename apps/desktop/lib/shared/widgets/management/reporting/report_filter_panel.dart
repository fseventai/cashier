import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';

class ReportFilterPanel extends StatefulWidget {
  final VoidCallback? onShowReport;
  final VoidCallback? onPrint;
  final VoidCallback? onExportExcel;
  final VoidCallback? onExportPdf;

  const ReportFilterPanel({
    super.key,
    this.onShowReport,
    this.onPrint,
    this.onExportExcel,
    this.onExportPdf,
  });

  @override
  State<ReportFilterPanel> createState() => _ReportFilterPanelState();
}

class _ReportFilterPanelState extends State<ReportFilterPanel> {
  String _customerFilter = 'All';
  String _userFilter = 'All';
  String _cashRegisterFilter = 'All';
  String _productFilter = 'All';
  String _productGroupFilter = 'Products';
  bool _includeSubgroups = true;
  final TextEditingController _dateController = TextEditingController(
    text: '01/12/2025 - 22/12/2025',
  );

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.slate50,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter header
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.surfaceBorder),
              ),
            ),
            child: Text(
              'Filter',
              style: AppTextStyles.h2.copyWith(
                fontWeight: FontWeight.w300,
                color: AppColors.slate700,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Filter fields
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDropdownField(
                    label: 'Customers & suppliers',
                    value: _customerFilter,
                    items: ['All', 'VIP Customers', 'Wholesalers'],
                    onChanged: (v) => setState(() => _customerFilter = v!),
                  ),
                  const SizedBox(height: 16),

                  _buildDropdownField(
                    label: 'User',
                    value: _userFilter,
                    items: ['All', 'Admin', 'Staff'],
                    onChanged: (v) => setState(() => _userFilter = v!),
                  ),
                  const SizedBox(height: 16),

                  _buildDropdownField(
                    label: 'Cash register',
                    value: _cashRegisterFilter,
                    items: ['All', 'Register 1', 'Register 2'],
                    onChanged: (v) => setState(() => _cashRegisterFilter = v!),
                  ),
                  const SizedBox(height: 16),

                  _buildDropdownField(
                    label: 'Product',
                    value: _productFilter,
                    items: ['All', 'Specific Product'],
                    onChanged: (v) => setState(() => _productFilter = v!),
                  ),
                  const SizedBox(height: 16),

                  _buildDropdownField(
                    label: 'Product group',
                    value: _productGroupFilter,
                    items: ['Products', 'Services'],
                    onChanged: (v) => setState(() => _productGroupFilter = v!),
                  ),
                  const SizedBox(height: 16),

                  // Include subgroups checkbox
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                          value: _includeSubgroups,
                          onChanged: (v) =>
                              setState(() => _includeSubgroups = v ?? true),
                          activeColor: AppColors.emerald600,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Include subgroups',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.slate700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Date range field
                  TextField(
                    controller: _dateController,
                    readOnly: true,
                    style: AppTextStyles.bodyMedium,
                    decoration: InputDecoration(
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 12, right: 8),
                        child: Icon(
                          Icons.calendar_today_outlined,
                          size: 20,
                          color: AppColors.slate400,
                        ),
                      ),
                      prefixIconConstraints: const BoxConstraints(minWidth: 40),
                      filled: true,
                      fillColor: AppColors.surface,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(
                          color: AppColors.surfaceBorder,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(
                          color: AppColors.surfaceBorder,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(
                          color: AppColors.emerald600,
                        ),
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),

          // Action buttons
          Container(
            padding: const EdgeInsets.only(top: 24),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.surfaceBorder)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _ActionButton(
                        label: 'Show report',
                        icon: Icons.visibility_outlined,
                        isPrimary: true,
                        onTap: widget.onShowReport,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ActionButton(
                        label: 'Cetak',
                        icon: Icons.print_outlined,
                        onTap: widget.onPrint,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _ActionButton(
                        label: 'Excel',
                        icon: Icons.grid_on,
                        iconColor: Colors.green.shade600,
                        onTap: widget.onExportExcel,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ActionButton(
                        label: 'PDF',
                        icon: Icons.picture_as_pdf,
                        iconColor: Colors.red.shade500,
                        onTap: widget.onExportPdf,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.slate500,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppColors.surfaceBorder),
            boxShadow: [
              BoxShadow(
                color: const Color.fromRGBO(0, 0, 0, 0.05),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                size: 18,
                color: AppColors.slate400,
              ),
              style: AppTextStyles.bodyMedium,
              items: items.map((item) {
                return DropdownMenuItem(value: item, child: Text(item));
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final Color? iconColor;
  final bool isPrimary;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    this.iconColor,
    this.isPrimary = false,
    this.onTap,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.isPrimary
        ? (_isHovered ? AppColors.emerald50 : Colors.transparent)
        : (_isHovered ? AppColors.slate50 : AppColors.surface);

    final borderColor = widget.isPrimary
        ? AppColors.emerald600
        : AppColors.surfaceBorder;

    final textColor = widget.isPrimary
        ? AppColors.emerald600
        : AppColors.slate700;

    final iconColor = widget.iconColor ?? textColor;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: borderColor),
            boxShadow: [
              BoxShadow(
                color: const Color.fromRGBO(0, 0, 0, 0.05),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon, size: 18, color: iconColor),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
