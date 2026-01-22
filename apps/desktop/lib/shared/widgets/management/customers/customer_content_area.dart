import 'package:flutter/material.dart';
import 'package:cashier/core/constants/app_colors.dart';
import 'package:cashier/core/constants/app_text_styles.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomerContentArea extends StatelessWidget {
  const CustomerContentArea({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      color: isDark ? AppColors.slate900 : Colors.white,
      child: Column(
        children: [
          // Search/Filter Bar
          _buildFilterBar(isDark),

          // Data Table
          Expanded(child: _buildDataTable(isDark)),

          // Bottom border/indicator
          Container(
            height: 4,
            color: isDark ? AppColors.slate700 : AppColors.slate200,
            width: double.infinity,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.slate800 : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: isDark ? AppColors.slate700 : AppColors.slate200,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 500,
            height: 36,
            decoration: BoxDecoration(
              color: isDark ? AppColors.slate900 : Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: isDark ? AppColors.slate700 : AppColors.slate300,
              ),
            ),
            child: Row(
              children: [
                // Dropdown Area
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    // color: isDark ? AppColors.slate800 : AppColors.slate50,
                    border: Border(
                      right: BorderSide(
                        color: isDark ? AppColors.slate700 : AppColors.slate300,
                      ),
                    ),
                  ),
                  child: Text(
                    'Name',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: isDark ? AppColors.slate300 : AppColors.slate700,
                    ),
                  ),
                ),
                // Search Input Area
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search customers & suppliers',
                      hintStyle: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.slate400,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: HugeIcon(
                          icon: HugeIcons.strokeRoundedSearch01,
                          size: 16,
                          color: AppColors.slate400,
                        ),
                      ),
                      suffixIconConstraints: const BoxConstraints(
                        minWidth: 32,
                        minHeight: 32,
                      ),
                    ),
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: isDark ? AppColors.slate200 : AppColors.slate700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildDataTable(bool isDark) {
    final headerStyle = AppTextStyles.tableHeader.copyWith(
      color: AppColors.slate500,
      fontSize: 11,
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: Container(
          constraints: const BoxConstraints(minWidth: 100),
          child: DataTable(
            headingRowHeight: 40,
            dataRowMinHeight: 40,
            dataRowMaxHeight: 40,
            horizontalMargin: 16,
            columnSpacing: 30,
            headingRowColor: WidgetStateProperty.all(
              isDark ? AppColors.slate800 : AppColors.slate50,
            ),
            border: TableBorder(
              bottom: BorderSide(
                color: isDark ? AppColors.slate700 : AppColors.slate200,
              ),
              horizontalInside: BorderSide(
                color: isDark ? AppColors.slate700 : AppColors.slate100,
              ),
            ),
            columns: [
              DataColumn(label: _buildHeader('CODE', headerStyle)),
              DataColumn(label: _buildHeader('NAME', headerStyle)),
              DataColumn(label: _buildHeader('TAX NUMBER', headerStyle)),
              DataColumn(label: _buildHeader('ALAMAT', headerStyle)),
              DataColumn(label: _buildHeader('NEGARA', headerStyle)),
              DataColumn(label: _buildHeader('PHONE NUMBER', headerStyle)),
              DataColumn(label: _buildHeader('EMAIL', headerStyle)),
            ],
            rows: [
              DataRow(
                cells: [
                  const DataCell(Text('')),
                  DataCell(
                    Text(
                      'Walk-in customer',
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isDark ? AppColors.slate200 : AppColors.slate800,
                      ),
                    ),
                  ),
                  DataCell(_buildEmptyCell('(none)', isDark)),
                  DataCell(_buildEmptyCell('(none)', isDark)),
                  const DataCell(Text('')),
                  DataCell(_buildEmptyCell('(none)', isDark)),
                  DataCell(_buildEmptyCell('(none)', isDark)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String label, TextStyle style) {
    return Container(
      height: 40,
      alignment: Alignment.centerLeft,
      child: Text(label, style: style),
    );
  }

  Widget _buildEmptyCell(String text, bool isDark) {
    return Text(
      text,
      style: AppTextStyles.bodySmall.copyWith(
        fontStyle: FontStyle.italic,
        color: AppColors.slate400,
      ),
    );
  }
}
