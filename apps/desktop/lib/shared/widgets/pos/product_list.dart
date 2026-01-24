import 'package:cashier/shared/components/quantity_state.dart';
import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  // Products moved to state
  final List<_ProductItem> _products = [
    _ProductItem(
      name: 'Air Mineral 600ml',
      discountLabel: 'Hemat Anggota: @3.5k',
      quantity: 2,
      price: '3.500',
      total: '7.000',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuA5mGOd0URK_4lC4RnpMRZTcdXMp4_2T-ltx25PVnMKW63uuI_zRy9Luu2Psu3wDqRNBTvGLRHZrEPCXxyBvwsLsX4lyroDU_HpictP1eSJggMmd0RveGZDq1cLIQc4rZ9PwRkktgVTrTp4FsGgFw4COIXeFDUY8Y6qnIGh-p91BO_Nkg4FHK99fdWcgXovYZG0wi_w3DL_obh0gDz-U8l3mknLK91gGd2AeV086zu8omWdjwuvts3UE0sbHhgzvCIcwqDb1OoO3S8',
    ),
    _ProductItem(
      name: 'Roti Tawar Kupas',
      discountLabel: 'Hemat Anggota: @13.5k',
      quantity: 1,
      price: '13.500',
      total: '13.500',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBU9CEK7C7B-RbkjF4lF5n7EALl2zGBYmc19Ea8ol3Nm_PmvElyjQEDxlJkSIXSfUdE3G09c4Ve0RBR9LiykB-mk5jnEbwOGcFCVSH2pZjGCbZtpvYccP4qS5bteUmDRdx395AkgWLkUOWyfKGUM23od8mcAq0z3GPXcLvpxw2OeAnrwgFYksfcoZMXULm5G1l4fiUJaFTpD5MSPrh57NkjFj2ByM0T7nhEEODeuqUiOmPrZINljLGpn3a47mnV7qQZZthwcPR4zKk',
    ),
    _ProductItem(
      name: 'Biskuit Coklat Family',
      discountLabel: 'Hemat Anggota: @19.5k',
      quantity: 2,
      price: '19.500',
      total: '39.000',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBH7wYlmTbXP8XlibToNkGeEj6AXNdD29Qoa_qIXjk-4WnAG9hN2jmLeeEyq5h5USxJbYRSzet3OxbBaRr59VYTnnJkHe6ocxhqT4WEBl-pHPgE5gkaFhG4D85MwbWy7ycU5z4dgO7GQoXfXc0BpAoF6eB1qZvWTckrrAYTSXBRsPRlVtqJWQMlZHmDaCC-wxx0r_ii85s8z3sTo45pccNk7q25zOMk0WNP2_IhDEW40bmw8jO6Cd-jpFkrvK-gJxRqqRgO1X9lIZ0',
    ),
  ];

  final Set<int> _selectedIndices = {};

  @override
  void initState() {
    super.initState();
    // Only select the first index initially
    if (_products.isNotEmpty) {
      _selectedIndices.add(0);
    }
  }

  void _toggleSelection(int index) {
    setState(() {
      if (_selectedIndices.contains(index)) {
        _selectedIndices.remove(index);
      } else {
        _selectedIndices.add(index);
      }
    });
  }

  void _toggleSelectAll() {
    setState(() {
      if (_selectedIndices.length == _products.length) {
        _selectedIndices.clear();
      } else {
        _selectedIndices.clear();
        for (int i = 0; i < _products.length; i++) {
          _selectedIndices.add(i);
        }
      }
    });
  }

  // void _deleteSelected() {
  //   setState(() {
  //     final sortedIndices = _selectedIndices.toList()
  //       ..sort((a, b) => b.compareTo(a));
  //     for (final index in sortedIndices) {
  //       _products.removeAt(index);
  //     }
  //     _selectedIndices.clear();
  //   });
  // }

  void _incrementQuantity(int index) {
    setState(() {
      final product = _products[index];
      _products[index] = _ProductItem(
        name: product.name,
        discountLabel: product.discountLabel,
        quantity: product.quantity + 1,
        price: product.price,
        total: product.total, // In a real app, this should be recalculated
        imageUrl: product.imageUrl,
      );
    });
  }

  void _decrementQuantity(int index) {
    setState(() {
      final product = _products[index];
      if (product.quantity > 1) {
        _products[index] = _ProductItem(
          name: product.name,
          discountLabel: product.discountLabel,
          quantity: product.quantity - 1,
          price: product.price,
          total: product.total,
          imageUrl: product.imageUrl,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          // Header Row
          Container(
            height: 48, // h-12
            decoration: const BoxDecoration(
              color: AppColors.emerald50,
              border: Border(bottom: BorderSide(color: AppColors.emerald100)),
            ),
            child: Row(
              children: [
                // Selection Header
                SizedBox(
                  width: 64,
                  child: Center(
                    child: Checkbox(
                      value:
                          _products.isNotEmpty &&
                          _selectedIndices.length == _products.length,
                      onChanged: (value) => _toggleSelectAll(),
                      activeColor: AppColors.emerald600,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 37,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text(
                          'Nama Produk'.toUpperCase(),
                          style: AppTextStyles.tableHeader,
                        ),
                      ],
                    ),
                  ),
                ),
                _buildHeaderCell(
                  'Kuantitas',
                  flex: 15,
                  align: Alignment.center,
                ),
                _buildHeaderCell(
                  'Harga',
                  flex: 20,
                  align: Alignment.centerRight,
                ),
                _buildHeaderCell(
                  'Jumlah',
                  flex: 20,
                  align: Alignment.centerRight,
                ),
              ],
            ),
          ),

          // Product List
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  final product = _products[index];
                  final isEven = index % 2 == 0;
                  final backgroundColor = isEven
                      ? Colors.white
                      : AppColors.surfaceAlt;

                  final isSelected = _selectedIndices.contains(index);

                  return _buildProductRow(
                    index,
                    product,
                    backgroundColor,
                    isSelected,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(
    String text, {
    required int flex,
    Alignment align = Alignment.centerLeft,
  }) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        alignment: align,
        child: Text(text.toUpperCase(), style: AppTextStyles.tableHeader),
      ),
    );
  }

  Widget _buildProductRow(
    int index,
    _ProductItem product,
    Color backgroundColor,
    bool isSelected,
  ) {
    return Container(
      height: 80, // h-20
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.emerald50.withValues(alpha: 0.3)
            : backgroundColor,
        border: const Border(
          bottom: BorderSide(color: AppColors.surfaceBorder),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _toggleSelection(index),
          hoverColor: AppColors.emerald50.withValues(alpha: 0.4),
          child: Row(
            children: [
              // Checkbox Column
              SizedBox(
                width: 64,
                child: Center(
                  child: Checkbox(
                    value: isSelected,
                    onChanged: (value) => _toggleSelection(index),
                    activeColor: AppColors.emerald600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),

              // Name Column (37%)
              Expanded(
                flex: 37,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.surfaceBorder),
                          image: DecorationImage(
                            image: NetworkImage(product.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: AppTextStyles.bodyMedium.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.charcoal900,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.emerald50,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                product.discountLabel,
                                style: AppTextStyles.bodyXSmall.copyWith(
                                  color: AppColors.emerald600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Quantity Column (15%)
              Expanded(
                flex: 15,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: QuantityState(
                    quantity: product.quantity,
                    onPlus: () => _incrementQuantity(index),
                    onMinus: () => _decrementQuantity(index),
                  ),
                ),
              ),

              // Price Column (20%)
              Expanded(
                flex: 20,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      product.price,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                  ),
                ),
              ),

              // Total Column (20%)
              Expanded(
                flex: 20,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      product.total,
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.charcoal900,
                      ),
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
}

class _ProductItem {
  final String name;
  final String discountLabel;
  final int quantity;
  final String price;
  final String total;
  final String imageUrl;

  const _ProductItem({
    required this.name,
    required this.discountLabel,
    required this.quantity,
    required this.price,
    required this.total,
    required this.imageUrl,
  });
}
