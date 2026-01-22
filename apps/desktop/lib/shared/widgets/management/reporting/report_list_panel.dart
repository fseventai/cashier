import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';

class ReportListPanel extends StatefulWidget {
  final String? selectedReport;
  final Set<String> favorites;
  final void Function(String) onSelectReport;
  final void Function(String) onToggleFavorite;

  const ReportListPanel({
    super.key,
    this.selectedReport,
    required this.favorites,
    required this.onSelectReport,
    required this.onToggleFavorite,
  });

  @override
  State<ReportListPanel> createState() => _ReportListPanelState();
}

class _ReportListPanelState extends State<ReportListPanel> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  static const List<Map<String, dynamic>> _salesReports = [
    {
      'name': 'Products',
      'icon': Icons.insert_drive_file_outlined,
      'isFile': true,
    },
    {
      'name': 'Product groups',
      'icon': Icons.folder_open_outlined,
      'isFile': false,
    },
    {'name': 'Customers', 'icon': Icons.folder_open_outlined, 'isFile': false},
    {'name': 'Tax rates', 'icon': Icons.folder_open_outlined, 'isFile': false},
    {'name': 'Users', 'icon': Icons.folder_open_outlined, 'isFile': false},
    {'name': 'Item list', 'icon': Icons.description_outlined, 'isFile': true},
    {
      'name': 'Payment types',
      'icon': Icons.folder_open_outlined,
      'isFile': false,
    },
    {
      'name': 'Daily sales',
      'icon': Icons.folder_open_outlined,
      'isFile': false,
    },
    {
      'name': 'Hourly sales',
      'icon': Icons.folder_open_outlined,
      'isFile': false,
    },
    {
      'name': 'Profit & margin',
      'icon': Icons.folder_open_outlined,
      'isFile': false,
    },
  ];

  List<Map<String, dynamic>> get _filteredReports {
    if (_searchQuery.isEmpty) return _salesReports;
    return _salesReports
        .where(
          (r) => (r['name'] as String).toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ),
        )
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Tab button
        Container(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.surfaceBorder)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: const BoxDecoration(color: AppColors.emerald600),
                child: Row(
                  children: [
                    const Icon(Icons.search, size: 16, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(
                      'Select report',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Search bar
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _searchController,
            onChanged: (value) => setState(() => _searchQuery = value),
            style: AppTextStyles.bodyMedium,
            decoration: InputDecoration(
              hintText: 'Search reports',
              hintStyle: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.slate400,
              ),
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 12, right: 8),
                child: Icon(Icons.search, size: 20, color: AppColors.slate400),
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
                borderSide: const BorderSide(color: AppColors.surfaceBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: AppColors.surfaceBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: AppColors.emerald600),
              ),
            ),
          ),
        ),

        // Report list
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section header
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Row(
                    children: [
                      Text(
                        'Sales',
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.slate800,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: AppColors.surfaceBorder,
                        ),
                      ),
                    ],
                  ),
                ),

                // Report items
                ..._filteredReports.map((report) {
                  final name = report['name'] as String;
                  final icon = report['icon'] as IconData;
                  final isSelected = widget.selectedReport == name;
                  final isFavorite = widget.favorites.contains(name);

                  return _ReportListItem(
                    name: name,
                    icon: icon,
                    isSelected: isSelected,
                    isFavorite: isFavorite,
                    onTap: () => widget.onSelectReport(name),
                    onToggleFavorite: () => widget.onToggleFavorite(name),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ReportListItem extends StatefulWidget {
  final String name;
  final IconData icon;
  final bool isSelected;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onToggleFavorite;

  const _ReportListItem({
    required this.name,
    required this.icon,
    required this.isSelected,
    required this.isFavorite,
    required this.onTap,
    required this.onToggleFavorite,
  });

  @override
  State<_ReportListItem> createState() => _ReportListItemState();
}

class _ReportListItemState extends State<_ReportListItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? AppColors.emerald600
                : (widget.isFavorite
                      ? AppColors.slate100
                      : (_isHovered ? AppColors.slate50 : Colors.transparent)),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Icon(
                widget.icon,
                size: 20,
                color: widget.isSelected
                    ? Colors.white.withAlpha(230)
                    : AppColors.slate400,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.name,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: widget.isSelected
                        ? FontWeight.w500
                        : FontWeight.w400,
                    color: widget.isSelected
                        ? Colors.white
                        : AppColors.slate600,
                  ),
                ),
              ),
              if (_isHovered || widget.isFavorite)
                GestureDetector(
                  onTap: widget.onToggleFavorite,
                  child: Icon(
                    widget.isFavorite ? Icons.star : Icons.star_border,
                    size: 18,
                    color: widget.isFavorite
                        ? Colors.amber
                        : (widget.isSelected
                              ? Colors.white
                              : AppColors.slate400),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
