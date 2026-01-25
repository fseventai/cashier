import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';
import 'package:hugeicons/hugeicons.dart';

class CategoriesContentArea extends StatelessWidget {
  const CategoriesContentArea({super.key});

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
          Expanded(child: _buildDataTable(context, isDark)),

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
                    'Category Name',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: isDark ? AppColors.slate300 : AppColors.slate700,
                    ),
                  ),
                ),
                // Search Input Area
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search categories',
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

  Widget _buildDataTable(BuildContext context, bool isDark) {
    final headerStyle = AppTextStyles.tableHeader.copyWith(
      color: AppColors.slate500,
      fontSize: 11,
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
          ),
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
              DataColumn(label: _buildHeader('NO.', headerStyle)),
              DataColumn(label: _buildHeader('CATEGORY NAME', headerStyle)),
              DataColumn(label: _buildHeader('DESCRIPTION', headerStyle)),
              DataColumn(label: _buildHeader('PRODUCT COUNT', headerStyle)),
              DataColumn(label: _buildHeader('STATUS', headerStyle)),
            ],
            rows: [
              DataRow(
                cells: [
                  const DataCell(Text('1.')),
                  DataCell(
                    Text(
                      'Makanan',
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isDark ? AppColors.slate200 : AppColors.slate800,
                      ),
                    ),
                  ),
                  DataCell(_buildEmptyCell('(Buah-buahan)', isDark)),
                  DataCell(_buildEmptyCell('10', isDark)),
                  DataCell(_buildEmptyCell('Active', isDark)),
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
