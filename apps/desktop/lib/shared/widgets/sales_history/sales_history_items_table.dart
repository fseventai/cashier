import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';

/// Model for a document line item
class SalesDocumentItem {
  final int id;
  final String code;
  final String name;
  final String unit;
  final double quantity;
  final double priceExcl;
  final double taxPercent;
  final double price;
  final double subtotal;
  final double discount;
  final double total;

  const SalesDocumentItem({
    required this.id,
    required this.code,
    required this.name,
    required this.unit,
    required this.quantity,
    required this.priceExcl,
    required this.taxPercent,
    required this.price,
    required this.subtotal,
    required this.discount,
    required this.total,
  });
}

class SalesHistoryItemsTable extends StatelessWidget {
  final List<SalesDocumentItem> items;

  const SalesHistoryItemsTable({super.key, required this.items});

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
              children: [
                Text(
                  'Item dokumen',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w700,
                    color: isDark ? AppColors.slate200 : AppColors.slate700,
                  ),
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
                          DataColumn(label: Text('Kode')),
                          DataColumn(label: Text('Nama')),
                          DataColumn(label: Text('Satuan')),
                          DataColumn(label: Text('Kuantitas'), numeric: true),
                          DataColumn(
                            label: Text('Harga (Excl)'),
                            numeric: true,
                          ),
                          DataColumn(label: Text('Pajak %'), numeric: true),
                          DataColumn(label: Text('Harga'), numeric: true),
                          DataColumn(label: Text('Subtotal'), numeric: true),
                          DataColumn(label: Text('Diskon'), numeric: true),
                          DataColumn(label: Text('Total'), numeric: true),
                        ],
                        rows: items.map((item) {
                          return DataRow(
                            cells: [
                              DataCell(
                                Text(
                                  item.id.toString(),
                                  style: TextStyle(
                                    color: isDark
                                        ? Colors.white
                                        : AppColors.textMain,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  item.code,
                                  style: TextStyle(
                                    fontFamily: 'monospace',
                                    color: isDark
                                        ? AppColors.slate400
                                        : AppColors.slate500,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  item.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: isDark
                                        ? AppColors.slate200
                                        : AppColors.textMain,
                                  ),
                                ),
                              ),
                              DataCell(Text(item.unit)),
                              DataCell(Text(_formatNumber(item.quantity))),
                              DataCell(Text(_formatNumber(item.priceExcl))),
                              DataCell(
                                Text('${item.taxPercent.toStringAsFixed(0)}%'),
                              ),
                              DataCell(Text(_formatNumber(item.price))),
                              DataCell(Text(_formatNumber(item.subtotal))),
                              DataCell(Text(_formatNumber(item.discount))),
                              DataCell(
                                Text(
                                  _formatNumber(item.total),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: isDark
                                        ? Colors.white
                                        : AppColors.textMain,
                                  ),
                                ),
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

  String _formatNumber(double value) {
    return value
        .toStringAsFixed(2)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}
