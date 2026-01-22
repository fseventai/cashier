import 'package:flutter/material.dart';
import 'package:cashier/core/constants/app_colors.dart';
import 'package:cashier/core/constants/app_text_styles.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Data matching the screenshot
    final products = [
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
                _buildHeaderCell('Nama Produk', flex: 45),
                _buildHeaderCell(
                  'Kuantitas',
                  flex: 15,
                  align: Alignment.centerRight,
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
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  final isEven = index % 2 == 0;
                  final backgroundColor = isEven
                      ? Colors.white
                      : AppColors.surfaceAlt;

                  return _buildProductRow(product, backgroundColor);
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

  Widget _buildProductRow(_ProductItem product, Color backgroundColor) {
    return Container(
      height: 80, // h-20
      decoration: BoxDecoration(
        color: backgroundColor,
        border: const Border(
          bottom: BorderSide(color: AppColors.surfaceBorder),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {}, // Hover effect simulation
          hoverColor: AppColors.emerald50.withValues(alpha: 0.4),
          child: Row(
            children: [
              // Name Column (45%)
              Expanded(
                flex: 45,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
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
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        border: Border.all(color: AppColors.surfaceBorder),
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Text(
                        '${product.quantity}',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.charcoal900,
                        ),
                      ),
                    ),
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
