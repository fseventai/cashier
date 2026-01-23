import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/shared/widgets/management/reporting/report_list_panel.dart';
import 'package:cashier/shared/widgets/management/reporting/report_filter_panel.dart';

class ReportingContent extends StatefulWidget {
  const ReportingContent({super.key});

  @override
  State<ReportingContent> createState() => _ReportingContentState();
}

class _ReportingContentState extends State<ReportingContent> {
  String? _selectedReport = 'Products';
  final Set<String> _favorites = {'Item list'};

  void _toggleFavorite(String reportName) {
    setState(() {
      if (_favorites.contains(reportName)) {
        _favorites.remove(reportName);
      } else {
        _favorites.add(reportName);
      }
    });
  }

  void _selectReport(String reportName) {
    setState(() {
      _selectedReport = reportName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surfaceAlt,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main content area
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border.all(color: AppColors.surfaceBorder),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromRGBO(
                      226,
                      232,
                      240,
                      0.5,
                    ), // slate200 with 50% opacity
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Left Panel - Report List (2/3)
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          right: BorderSide(color: AppColors.surfaceBorder),
                        ),
                      ),
                      child: ReportListPanel(
                        selectedReport: _selectedReport,
                        favorites: _favorites,
                        onSelectReport: _selectReport,
                        onToggleFavorite: _toggleFavorite,
                      ),
                    ),
                  ),

                  // Right Panel - Filters (1/3)
                  SizedBox(
                    width: 384, // w-96 = 24rem = 384px
                    child: ReportFilterPanel(
                      onShowReport: () {
                        // Handle show report
                      },
                      onPrint: () {
                        // Handle print
                      },
                      onExportExcel: () {
                        // Handle Excel export
                      },
                      onExportPdf: () {
                        // Handle PDF export
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
