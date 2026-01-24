import 'package:cashier/shared/widgets/sales_history/sales_history_filter_bar.dart';
import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';

/// Model for a sales document
class SalesDocument {
  final int id;
  final String documentType;
  final String user;
  final String number;
  final String? refDocument;
  final String customer;
  final String date;
  final String createdTime;
  final String pos;
  final double discount;
  final double subtotal;
  final double tax;
  final double total;

  const SalesDocument({
    required this.id,
    required this.documentType,
    required this.user,
    required this.number,
    this.refDocument,
    required this.customer,
    required this.date,
    required this.createdTime,
    required this.pos,
    required this.discount,
    required this.subtotal,
    required this.tax,
    required this.total,
  });
}

class SalesHistoryDocumentsTable extends StatelessWidget {
  final List<SalesDocument> documents;
  final int? selectedIndex;
  final ValueChanged<int>? onRowSelected;
  final String dateRangeText;
  final VoidCallback? onDateRangeTap;
  final TextEditingController? searchController;
  final ValueChanged<String>? onSearchChanged;
  final List<String> searchSuggestions;

  const SalesHistoryDocumentsTable({
    super.key,
    required this.documents,
    this.selectedIndex,
    this.onRowSelected,
    this.dateRangeText = '22/12/2025 - 22/12/2025',
    this.onDateRangeTap,
    this.searchController,
    this.onSearchChanged,
    this.searchSuggestions = const [],
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.slate800 : AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark ? AppColors.slate700 : AppColors.surfaceBorder,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.slate800.withValues(alpha: 0.5)
                  : AppColors.surfaceAlt,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8),
              ),
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
                  'Dokumen',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w700,
                    color: isDark ? AppColors.slate200 : AppColors.slate700,
                  ),
                ),
                SalesHistoryFilterBar(
                  dateRangeText: dateRangeText,
                  onDateRangeTap: onDateRangeTap,
                  searchController: searchController,
                  onSearchChanged: onSearchChanged,
                  searchSuggestions: searchSuggestions,
                ),
              ],
            ),
          ),

          // Table
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: constraints.maxWidth),
                    child: SingleChildScrollView(
                      child: DataTable(
                        headingRowColor: WidgetStateProperty.all(
                          isDark ? AppColors.slate800 : AppColors.slate100,
                        ),
                        dataRowColor: WidgetStateProperty.resolveWith((states) {
                          return isDark
                              ? AppColors.slate800
                              : AppColors.surface;
                        }),
                        headingTextStyle: AppTextStyles.bodySmall.copyWith(
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? AppColors.slate400
                              : AppColors.slate600,
                        ),
                        dataTextStyle: AppTextStyles.bodySmall.copyWith(
                          color: isDark
                              ? AppColors.slate300
                              : AppColors.textMain,
                        ),
                        columnSpacing: 16,
                        horizontalMargin: 12,
                        columns: const [
                          DataColumn(label: Text('ID')),
                          DataColumn(label: Text('Tipe dokumen')),
                          DataColumn(label: Text('Pengguna')),
                          DataColumn(label: Text('Nomor')),
                          DataColumn(label: Text('Dokumen ref')),
                          DataColumn(label: Text('Pelanggan')),
                          DataColumn(label: Text('Tanggal')),
                          DataColumn(label: Text('Dibuat')),
                          DataColumn(label: Text('POS')),
                          DataColumn(label: Text('Diskon'), numeric: true),
                          DataColumn(
                            label: Text('Total bef...'),
                            numeric: true,
                          ),
                          DataColumn(label: Text('Tax'), numeric: true),
                          DataColumn(label: Text('Total'), numeric: true),
                        ],
                        rows: documents.asMap().entries.map((entry) {
                          final index = entry.key;
                          final doc = entry.value;
                          final isSelected = selectedIndex == index;
                          final isNegative = doc.total < 0;

                          return DataRow(
                            selected: isSelected,
                            color: WidgetStateProperty.resolveWith((states) {
                              if (isSelected) {
                                return isDark
                                    ? AppColors.emerald900.withValues(
                                        alpha: 0.1,
                                      )
                                    : AppColors.emerald50.withValues(
                                        alpha: 0.5,
                                      );
                              }
                              return null;
                            }),
                            onSelectChanged: (_) => onRowSelected?.call(index),
                            cells: [
                              DataCell(
                                _buildIdCell(doc.id, isSelected, isDark),
                              ),
                              DataCell(Text(doc.documentType)),
                              DataCell(Text(doc.user)),
                              DataCell(_buildNumberCell(doc.number, isDark)),
                              DataCell(
                                Text(
                                  doc.refDocument ?? '-',
                                  style: TextStyle(
                                    color: doc.refDocument != null
                                        ? (isDark
                                              ? AppColors.slate400
                                              : AppColors.slate500)
                                        : (isDark
                                              ? AppColors.slate600
                                              : AppColors.slate400),
                                  ),
                                ),
                              ),
                              DataCell(Text(doc.customer)),
                              DataCell(Text(doc.date)),
                              DataCell(Text(doc.createdTime)),
                              DataCell(Text(doc.pos)),
                              DataCell(Text(_formatNumber(doc.discount))),
                              DataCell(
                                _buildAmountCell(
                                  doc.subtotal,
                                  isNegative,
                                  isDark,
                                ),
                              ),
                              DataCell(
                                _buildAmountCell(doc.tax, isNegative, isDark),
                              ),
                              DataCell(
                                _buildTotalCell(doc.total, isNegative, isDark),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIdCell(int id, bool isSelected, bool isDark) {
    return Container(
      decoration: isSelected
          ? BoxDecoration(
              border: Border(
                left: BorderSide(color: AppColors.emerald500, width: 4),
              ),
            )
          : null,
      padding: isSelected ? const EdgeInsets.only(left: 8) : EdgeInsets.zero,
      child: Text(
        id.toString(),
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white : AppColors.textMain,
        ),
      ),
    );
  }

  Widget _buildNumberCell(String number, bool isDark) {
    return Text(
      number,
      style: TextStyle(
        color: AppColors.emerald500,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildAmountCell(double amount, bool isNegative, bool isDark) {
    return Text(
      _formatNumber(amount),
      style: TextStyle(color: isNegative ? Colors.red : null),
    );
  }

  Widget _buildTotalCell(double total, bool isNegative, bool isDark) {
    return Text(
      _formatNumber(total),
      style: TextStyle(
        fontWeight: FontWeight.w700,
        color: isNegative
            ? Colors.red
            : (isDark ? Colors.white : AppColors.textMain),
      ),
    );
  }

  String _formatNumber(double value) {
    final absValue = value.abs();
    final formatted = absValue
        .toStringAsFixed(2)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
    return value < 0 ? '-$formatted' : formatted;
  }
}
