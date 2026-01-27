import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';
import 'package:cashier/core/models/product.dart';
import 'package:cashier/core/providers/product_group_provider.dart';
import 'package:cashier/core/providers/product_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';

class ProductContentArea extends ConsumerStatefulWidget {
  final VoidCallback? onNewProduct;
  final VoidCallback? onNewGroup;

  const ProductContentArea({super.key, this.onNewProduct, this.onNewGroup});

  @override
  ConsumerState<ProductContentArea> createState() => _ProductContentAreaState();
}

class _ProductContentAreaState extends ConsumerState<ProductContentArea> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _horizontalScrollController = ScrollController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _horizontalScrollController.dispose();
    super.dispose();
  }

  String _formatCurrency(String value) {
    final amount = double.tryParse(value) ?? 0;
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(amount);
  }

  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(productListProvider);
    final selectedGroupId = ref.watch(selectedProductGroupIdProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      color: isDark ? AppColors.slate950 : Colors.white,
      child: Column(
        children: [
          // Filter Bar
          _buildFilterBar(isDark),

          // Content
          Expanded(
            child: productsAsync.when(
              data: (products) {
                // Filter by group
                var filtered = products;
                if (selectedGroupId != null) {
                  filtered = filtered
                      .where((p) => p.groupId == selectedGroupId)
                      .toList();
                }

                // Filter by search
                if (_searchQuery.isNotEmpty) {
                  filtered = filtered
                      .where((p) => p.name.toLowerCase().contains(_searchQuery))
                      .toList();
                }

                if (filtered.isEmpty) {
                  return _buildEmptyState(isDark);
                }

                return _buildProductTable(filtered, isDark);
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('Error: $err')),
            ),
          ),

          // Footer
          _buildFooter(isDark),
        ],
      ),
    );
  }

  Widget _buildProductTable(List<Product> products, bool isDark) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Table min width is 1000, but it will grow to fill the container if it's wider
        final tableWidth = constraints.maxWidth > 1000
            ? constraints.maxWidth
            : 1000.0;

        return Scrollbar(
          controller: _horizontalScrollController,
          thumbVisibility: false,
          trackVisibility: false,
          child: SingleChildScrollView(
            controller: _horizontalScrollController,
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: tableWidth,
              child: Column(
                children: [
                  // Table Header - Stays at top because it's first in a Column
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.slate900 : AppColors.slate50,
                      border: Border(
                        bottom: BorderSide(
                          color: isDark
                              ? AppColors.slate800
                              : AppColors.slate200,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        _buildHeaderCell('IMG', width: 60),
                        _buildHeaderCell('CODE', width: 100),
                        _buildHeaderCell('PRODUCT NAME', isExpanded: true),
                        _buildHeaderCell('CATEGORY', width: 140),
                        _buildHeaderCell('STOCK', width: 80, isCenter: true),
                        _buildHeaderCell('UNIT', width: 80),
                        _buildHeaderCell(
                          'COST PRICE',
                          width: 130,
                          isRight: true,
                        ),
                        _buildHeaderCell(
                          'SALE PRICE',
                          width: 130,
                          isRight: true,
                        ),
                      ],
                    ),
                  ),

                  // Table Body - Virtualized vertically with ListView.builder
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return _buildProductRow(
                            product,
                            isDark,
                            index % 2 == 1,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeaderCell(
    String label, {
    double? width,
    bool isExpanded = false,
    bool isCenter = false,
    bool isRight = false,
  }) {
    Widget child = Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: isCenter
          ? Alignment.center
          : (isRight ? Alignment.centerRight : Alignment.centerLeft),
      child: Text(
        label,
        style: AppTextStyles.bodyXSmall.copyWith(
          fontWeight: FontWeight.bold,
          letterSpacing: 0.8,
          color: AppColors.slate500,
        ),
      ),
    );

    if (isExpanded) {
      return Expanded(child: child);
    }
    return SizedBox(width: width, child: child);
  }

  Widget _buildProductRow(Product product, bool isDark, bool isOdd) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: isOdd
            ? (isDark
                  ? AppColors.slate900.withValues(alpha: 0.3)
                  : AppColors.slate50.withValues(alpha: 0.5))
            : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: isDark ? AppColors.slate900 : AppColors.slate100,
          ),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          hoverColor: isDark
              ? AppColors.slate800.withValues(alpha: 0.5)
              : AppColors.emerald50.withValues(alpha: 0.3),
          child: Row(
            children: [
              // Image
              SizedBox(
                width: 60,
                child: Center(
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.slate800 : AppColors.slate100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedImage01,
                        size: 16,
                        color: AppColors.slate400,
                      ),
                    ),
                  ),
                ),
              ),

              // Code
              SizedBox(
                width: 100,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    product.code ?? '-',
                    style: AppTextStyles.bodySmall.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.slate200 : AppColors.slate800,
                    ),
                  ),
                ),
              ),

              // Name
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    product.name,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.slate200 : AppColors.slate700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),

              // Category
              SizedBox(
                width: 140,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    product.group?.name ?? '-',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.slate500,
                    ),
                  ),
                ),
              ),

              // Stock
              SizedBox(
                width: 80,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: _getStockColor(
                        product.stockQuantity,
                      ).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      product.stockQuantity,
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: _getStockColor(product.stockQuantity),
                      ),
                    ),
                  ),
                ),
              ),

              // Unit
              SizedBox(
                width: 80,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    product.unit?.toUpperCase() ?? 'PCS',
                    style: AppTextStyles.bodyXSmall.copyWith(
                      color: AppColors.slate400,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Cost Price
              SizedBox(
                width: 130,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.centerRight,
                  child: Text(
                    _formatCurrency(product.cost),
                    style: AppTextStyles.bodySmall.copyWith(
                      color: isDark ? AppColors.slate400 : AppColors.slate600,
                    ),
                  ),
                ),
              ),

              // Sale Price
              SizedBox(
                width: 130,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.centerRight,
                  child: Text(
                    _formatCurrency(product.salePrice),
                    style: AppTextStyles.bodySmall.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.emerald600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStockColor(String stock) {
    final qty = double.tryParse(stock) ?? 0;
    if (qty <= 0) return Colors.red;
    if (qty <= 10) return Colors.orange;
    return AppColors.emerald600;
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: isDark ? AppColors.slate900 : AppColors.slate50,
              shape: BoxShape.circle,
            ),
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedViewOff,
              size: 48,
              color: isDark ? AppColors.slate700 : AppColors.slate300,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Selected group contains no products',
            style: AppTextStyles.h3.copyWith(
              color: isDark ? AppColors.slate300 : AppColors.slate600,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLinkText(
                'Add new product',
                isDark,
                onTap: widget.onNewProduct,
              ),
              const SizedBox(width: 8),
              Text(
                'or',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.slate400,
                ),
              ),
              const SizedBox(width: 8),
              _buildLinkText(
                'new product group',
                isDark,
                onTap: widget.onNewGroup,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar(bool isDark) {
    final productsCount = ref.watch(productListProvider).value?.length ?? 0;

    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: isDark ? AppColors.slate900 : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: isDark ? AppColors.slate800 : AppColors.slate200,
          ),
        ),
      ),
      child: Row(
        children: [
          // Search Indicators
          _buildSearchIcon(HugeIcons.strokeRoundedSquare, isDark, 'Wildcard'),
          _buildSearchIcon(HugeIcons.strokeRoundedBarCode01, isDark, 'Barcode'),
          _buildSearchIcon(
            HugeIcons.strokeRoundedSearch01,
            isDark,
            'Search',
            isSelected: true,
          ),

          // Search Field
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search product name...',
                hintStyle: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.slate400,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                isCollapsed: true,
              ),
              style: AppTextStyles.bodySmall.copyWith(
                color: isDark ? Colors.white : AppColors.slate900,
              ),
            ),
          ),

          // Items Found
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: double.infinity,
            decoration: BoxDecoration(
              color: isDark ? AppColors.slate950 : AppColors.slate50,
              border: Border(
                left: BorderSide(
                  color: isDark ? AppColors.slate800 : AppColors.slate200,
                ),
              ),
            ),
            child: Center(
              child: RichText(
                text: TextSpan(
                  style: AppTextStyles.bodyXSmall.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.slate500,
                    letterSpacing: 0.5,
                  ),
                  children: [
                    const TextSpan(text: 'ITEMS FOUND: '),
                    TextSpan(
                      text: '$productsCount',
                      style: TextStyle(
                        color: isDark ? Colors.white : AppColors.slate900,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchIcon(
    List<List<dynamic>> icon,
    bool isDark,
    String tooltip, {
    bool isSelected = false,
  }) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.emerald600 : Colors.transparent,
        border: Border(
          right: BorderSide(
            color: isDark ? AppColors.slate800 : AppColors.slate200,
          ),
        ),
      ),
      child: Center(
        child: HugeIcon(
          icon: icon,
          size: 16,
          color: isSelected ? Colors.white : AppColors.slate400,
        ),
      ),
    );
  }

  Widget _buildFooter(bool isDark) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.slate950 : AppColors.slate50,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.slate800 : AppColors.slate200,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _buildFooterNavIcon(HugeIcons.strokeRoundedArrowLeft01, isDark),
              _buildFooterNavIcon(HugeIcons.strokeRoundedArrowRight01, isDark),
              const SizedBox(width: 8),
              Text(
                'Page 1 of 1',
                style: AppTextStyles.bodyXSmall.copyWith(
                  color: AppColors.slate500,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
            'Showing items...',
            style: AppTextStyles.bodyXSmall.copyWith(color: AppColors.slate400),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterNavIcon(List<List<dynamic>> icon, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Icon(
        Icons.chevron_left, // Simple for now
        size: 18,
        color: AppColors.slate400,
      ),
    );
  }

  Widget _buildLinkText(String text, bool isDark, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.emerald600,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
