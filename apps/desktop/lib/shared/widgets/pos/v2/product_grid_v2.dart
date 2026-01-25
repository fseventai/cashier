import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';

class ProductGridV2 extends StatelessWidget {
  const ProductGridV2({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      {
        'name': 'Beras Premium 5kg - Cap Bunga',
        'sku': '89910023',
        'oldPrice': 65000,
        'price': 60000,
        'stock': 45,
        'image':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuBKVpcuAbBM_MxUZurR6scM7_ddQJY1SGlmJKau0vl9qulDtmuH4nPfOuGtvK-cGFvk7nFyEkB924K9R3OS-KNVAo5w0zXTNYIvm2pq47yjHuJeE9_qckbsuY_RGkqYn2tUOqIyk5zX2sh-qoyk3dnoRUyP3Uk77ZSYTFjEK2kdWTdyrWcyz_ij3t6PT86Wym8EUoH-8D8vIhip_aq5VObNz45nfH73nneFJG5fAOljhM_PW7gn_PwAhbihCi2CZW0lk2vPpu6YfVo',
        'isMemberPrice': true,
      },
      {
        'name': 'Minyak Goreng 2 Liter',
        'sku': '77210044',
        'oldPrice': 28000,
        'price': 26500,
        'stock': null,
        'image':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuDYhxQJbxYOidsRZbwsZLzKsT7X_xKZsPfKTdHScVD7jsf6q4dTkjyLkwrTNheMXGDziz5Sx9CNveDQ_ez0TzOXS53_C0H--YBRT54GIuA070TD5T-JB1re41XGFUgvh4Xx8fQxm2mXsZg2DT5Uxv5dzt7SAUYepWrO-GMMOA47mU4hHc0PQ127S5YNGiae709Sz-n1BKF_moY5x97II1nIwCicWsGnaQltpwttCfhmuOqth8BUNteMfAyi76iYfHlOIlftEeiVJ5Y',
        'isMemberPrice': true,
      },
      {
        'name': 'Susu UHT Full Cream 1L',
        'sku': '33219900',
        'oldPrice': 19000,
        'price': 17500,
        'stock': null,
        'isPromo': true,
        'image':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuC48oFzDQmdf97i4EH0Dzv_dy0aK4wbjXMT8EIcKbLlGxalp89ACn5xglmEBL7S8_4SI_AZGrmnVTlcA58HpQPwYvC7uFi8mVH3zFWVvij8zZYK4AIpPYtoolHAzDjIdafw6-REy0i6gQ4_Taw9caPW0ccSV_amvsjRTmDhNjoaNTzmN0MguQrysykpVMRoLae37gbucczvbYaBl09RBDBEh6rA7R3rVNavmK47phbBaAle7XsId9CoOi4rV3mZ4ssD7jZkvRm7pjg',
        'isMemberPrice': true,
      },
      {
        'name': 'Mie Instan Goreng (Dus)',
        'sku': '11029922',
        'oldPrice': null,
        'price': 100000,
        'stock': null,
        'image':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuDQrds0SHbPKOCG3eBpadHXLBNbceouhnjHwz8HrAj_4-55pdNzcu1flbGBdidclmu3TN1H36_apfNmJOFCLtw3zmcAJPL-Z8srav_FM-wkxNLH1tM6Pvi0SrMHfqpYwiqvCAJC7QQZCw4uGCKQwJ8rgXPklX_g9g7elt6_x_Y9ThKgr1rmiaQBxB414whxCwypSwUbpoMl7A_pgPFPZAfGgT0dHxxJg4VSs5nRez1FnKb6HzIzi8CdmphxiPLHrJgjkMqvx00OnIY',
        'isMemberPrice': true,
      },
      {
        'name': 'Sabun Mandi Cair 450ml Refill',
        'sku': '55410022',
        'oldPrice': 22000,
        'price': 20000,
        'stock': null,
        'image':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuBmTu9kItbUG1Ud8BL8LBsfFvv9Ud2LCthp1TgH4auMC2UDFO0lduOnJ-E2_tisLwCyKPMyGho9Rc5zmhWifLKRt2kAyZwiCWxrNW_IC78DjyhGDaB5kE9FEtb1uFHveo7VPEkkj524svZB58xwr2E4oXtoqzT6zZE3v44bSh8TUORLal8LnfQt0olNnXutCN3yfMa8zZpwL7tOG9BwQJ00RUo07BzIVIZ5SWVnKx_ci05_z7tQs34XaE-hWZPBX8SwYLyqWIyLJV8',
        'isMemberPrice': true,
      },
      {
        'name': 'Es Kopi Susu Gula Aren',
        'sku': '99120011',
        'oldPrice': null,
        'price': 15000,
        'stock': null,
        'image':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuBtiGqsm-vtPuyGu4q_yyJ_i5L4g3xqpFIC-UOU6IQ7v6Qg1nGUTRc8URUWX9LH_d70USdZlz7yP9HRqhx6NxetvqhBsjIZZ5mcUl36zOicaGTmTQ65zrrCnomwFM0rTrR2aEL4GYBkboJRjKQ1y0HukAPnR4LL8orHTkSZVjZjylkAxoXzt_guQkb3fmCdtiFlQouAVgCsiEIDotpfs3aBKKWJffemS1uu5ookPJfnURuCMIIZ19xNxMLac6YyrofxogYYCC0xGUU',
        'isMemberPrice': false,
      },
    ];

    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.72,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return _ProductCard(product: products[index]);
      },
    );
  }
}

class _ProductCard extends StatefulWidget {
  final Map<String, dynamic> product;

  const _ProductCard({required this.product});

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    final isPromo = p['isPromo'] == true;
    final stock = p['stock'] as int?;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered
                ? AppColors.emerald500.withValues(alpha: 0.2)
                : Colors.transparent,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? Colors.black.withValues(alpha: 0.08)
                  : Colors.black.withValues(alpha: 0.04),
              blurRadius: _isHovered ? 16 : 8,
              offset: Offset(0, _isHovered ? 8 : 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      Container(
                        color: AppColors.slate50,
                        width: double.infinity,
                        height: double.infinity,
                        child: AnimatedScale(
                          scale: _isHovered ? 1.1 : 1.0,
                          duration: const Duration(milliseconds: 500),
                          child: CachedNetworkImage(
                            imageUrl: p['image'] as String,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: AppColors.slate100,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.emerald500,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: AppColors.slate100,
                              child: const Icon(
                                Icons.image_not_supported_outlined,
                                color: AppColors.slate400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (stock != null)
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.9),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppColors.emerald500.withValues(
                                  alpha: 0.1,
                                ),
                              ),
                            ),
                            child: Text(
                              'Stok: $stock',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.emerald500,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      if (isPromo)
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red[50],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Promo',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: Colors.red[600],
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            // Info Section
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p['name'] as String,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.charcoal900,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'SKU: ${p['sku']}',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.slate400,
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Price Section
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (p['oldPrice'] != null)
                            Text(
                              'Rp ${p['oldPrice']}',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.slate400,
                                decoration: TextDecoration.lineThrough,
                                fontSize: 10,
                              ),
                            ),
                          Row(
                            children: [
                              Text(
                                'Rp ${p['price']}',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: p['isMemberPrice'] == true
                                      ? AppColors.emerald600
                                      : AppColors.charcoal900,
                                ),
                              ),
                              if (p['isMemberPrice'] == true) ...[
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.verified_user,
                                  size: 14,
                                  color: AppColors.emerald500,
                                ),
                              ],
                            ],
                          ),
                          Text(
                            p['isMemberPrice'] == true
                                ? 'Harga Anggota'
                                : 'Harga Normal',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: p['isMemberPrice'] == true
                                  ? AppColors.emerald500
                                  : AppColors.slate400,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Add Button
                  _AddButton(isHovered: _isHovered),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final bool isHovered;

  const _AddButton({required this.isHovered});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 36,
      decoration: BoxDecoration(
        color: isHovered ? AppColors.emerald600 : const Color(0xFFF0F5F3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.add_shopping_cart,
              size: 16,
              color: isHovered ? Colors.white : AppColors.emerald600,
            ),
            const SizedBox(width: 8),
            Text(
              'Tambah',
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.bold,
                color: isHovered ? Colors.white : AppColors.emerald600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
