import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/shared/widgets/sales_history/sales_history_header.dart';
import 'package:cashier/shared/widgets/sales_history/sales_history_toolbar.dart';
import 'package:cashier/shared/widgets/sales_history/sales_history_documents_table.dart';
import 'package:cashier/shared/widgets/sales_history/sales_history_items_table.dart';
import 'package:cashier/shared/widgets/sales_history/sales_history_footer.dart';

class SalesHistoryScreen extends StatefulWidget {
  const SalesHistoryScreen({super.key});

  @override
  State<SalesHistoryScreen> createState() => _SalesHistoryScreenState();
}

class _SalesHistoryScreenState extends State<SalesHistoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedDocumentIndex = 0;

  // Resizing state
  double _topTableHeight = 350.0;
  static const double _minTableHeight = 100.0;

  // Date range state
  late DateTime _startDate;
  late DateTime _endDate;
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    // Default to today
    final now = DateTime.now();
    _startDate = DateTime(now.year, now.month, now.day);
    _endDate = DateTime(now.year, now.month, now.day);
  }

  String get _dateRangeText =>
      '${_dateFormat.format(_startDate)} - ${_dateFormat.format(_endDate)}';

  // Search suggestions based on document numbers and customers
  List<String> get _searchSuggestions => {
    ..._documents.map((d) => d.number),
    ..._documents.map((d) => d.customer),
  }.toList();

  // Sample data for demonstration
  final List<SalesDocument> _documents = const [
    SalesDocument(
      id: 1024,
      documentType: 'Faktur Penjualan',
      user: 'Admin',
      number: 'INV-2025-001',
      refDocument: null,
      customer: 'Budi Santoso',
      date: '22/12/2025',
      createdTime: '09:45',
      pos: 'Utama',
      discount: 0.00,
      subtotal: 150000.00,
      tax: 16500.00,
      total: 166500.00,
    ),
    SalesDocument(
      id: 1023,
      documentType: 'Faktur Penjualan',
      user: 'Kasir 2',
      number: 'INV-2025-002',
      refDocument: null,
      customer: 'Siti Aminah',
      date: '22/12/2025',
      createdTime: '09:30',
      pos: 'Cabang 1',
      discount: 5000.00,
      subtotal: 45000.00,
      tax: 4500.00,
      total: 44500.00,
    ),
    SalesDocument(
      id: 1022,
      documentType: 'Retur Penjualan',
      user: 'Admin',
      number: 'RET-2025-001',
      refDocument: 'INV-2024-998',
      customer: 'Umum',
      date: '22/12/2025',
      createdTime: '08:15',
      pos: 'Utama',
      discount: 0.00,
      subtotal: -25000.00,
      tax: -2750.00,
      total: -27750.00,
    ),
  ];

  // Sample items data for first document
  final Map<int, List<SalesDocumentItem>> _documentItems = {
    0: const [
      SalesDocumentItem(
        id: 1,
        code: 'PRD-001',
        name: 'Kopi Arabika 250g',
        unit: 'Pcs',
        quantity: 2.00,
        priceExcl: 50000.00,
        taxPercent: 11,
        price: 55500.00,
        subtotal: 100000.00,
        discount: 0.00,
        total: 111000.00,
      ),
      SalesDocumentItem(
        id: 2,
        code: 'PRD-005',
        name: 'Gula Aren Cair',
        unit: 'Botol',
        quantity: 1.00,
        priceExcl: 25000.00,
        taxPercent: 11,
        price: 27750.00,
        subtotal: 25000.00,
        discount: 0.00,
        total: 27750.00,
      ),
      SalesDocumentItem(
        id: 3,
        code: 'SVC-DEL',
        name: 'Biaya Pengiriman',
        unit: 'Jasa',
        quantity: 1.00,
        priceExcl: 25000.00,
        taxPercent: 11,
        price: 27750.00,
        subtotal: 25000.00,
        discount: 0.00,
        total: 27750.00,
      ),
    ],
    1: const [
      SalesDocumentItem(
        id: 1,
        code: 'PRD-010',
        name: 'Teh Hijau Premium',
        unit: 'Pcs',
        quantity: 3.00,
        priceExcl: 15000.00,
        taxPercent: 11,
        price: 16650.00,
        subtotal: 45000.00,
        discount: 5000.00,
        total: 44500.00,
      ),
    ],
    2: const [
      SalesDocumentItem(
        id: 1,
        code: 'PRD-001',
        name: 'Kopi Arabika 250g (Retur)',
        unit: 'Pcs',
        quantity: -1.00,
        priceExcl: -25000.00,
        taxPercent: 11,
        price: -27750.00,
        subtotal: -25000.00,
        discount: 0.00,
        total: -27750.00,
      ),
    ],
  };

  List<SalesDocumentItem> get _currentItems =>
      _documentItems[_selectedDocumentIndex] ?? [];

  double get _totalAmount =>
      _documents.fold(0.0, (sum, doc) => sum + doc.total);

  void _handleClose() {
    Navigator.of(context).pop();
  }

  Future<void> _showDateRangePicker() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDateRange: DateTimeRange(start: _startDate, end: _endDate),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.emerald500,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: AppColors.textMain,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
      // TODO: Reload data based on new date range
    }
  }

  void _onResize(double delta, double totalHeight) {
    setState(() {
      _topTableHeight = (_topTableHeight + delta).clamp(
        _minTableHeight,
        totalHeight - _minTableHeight - 16, // 16 for divider height
      );
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Theme(
      data: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
        brightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: isDark ? AppColors.slate900 : AppColors.surfaceAlt,
        body: Column(
          children: [
            // Header
            SalesHistoryHeader(onClose: _handleClose),

            // Filter bar and toolbar
            Container(
              decoration: BoxDecoration(
                color: isDark ? AppColors.slate800 : AppColors.surface,
                border: Border(
                  bottom: BorderSide(
                    color: isDark
                        ? AppColors.slate700
                        : AppColors.surfaceBorder,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: SalesHistoryToolbar(onRefresh: () {}, onDelete: () {}),
            ),

            // Main content area with tables
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Column(
                      children: [
                        // Documents table - Dynamic height based on resize
                        SizedBox(
                          height: _topTableHeight,
                          child: SalesHistoryDocumentsTable(
                            documents: _documents,
                            selectedIndex: _selectedDocumentIndex,
                            dateRangeText: _dateRangeText,
                            onDateRangeTap: _showDateRangePicker,
                            searchController: _searchController,
                            searchSuggestions: _searchSuggestions,
                            onRowSelected: (index) {
                              setState(() => _selectedDocumentIndex = index);
                            },
                          ),
                        ),

                        // Resizable divider
                        _ResizableDivider(
                          onDrag: (delta) =>
                              _onResize(delta, constraints.maxHeight),
                        ),

                        // Items table - fills remaining space
                        Expanded(
                          child: SalesHistoryItemsTable(items: _currentItems),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

            // Footer
            SalesHistoryFooter(
              documentCount: _documents.length,
              totalAmount: _totalAmount,
              onClose: _handleClose,
            ),
          ],
        ),
      ),
    );
  }
}

class _ResizableDivider extends StatefulWidget {
  final ValueChanged<double> onDrag;

  const _ResizableDivider({required this.onDrag});

  @override
  State<_ResizableDivider> createState() => _ResizableDividerState();
}

class _ResizableDividerState extends State<_ResizableDivider> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onVerticalDragUpdate: (details) => widget.onDrag(details.delta.dy),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.resizeRow,
        child: Container(
          height: 16,
          decoration: BoxDecoration(
            color: _isHovered
                ? (isDark ? AppColors.slate700 : AppColors.slate200)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Container(
              width: 32,
              height: 4,
              decoration: BoxDecoration(
                color: isDark ? AppColors.slate500 : AppColors.slate400,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
