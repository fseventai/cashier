import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';

class CartSidebarV2 extends StatelessWidget {
  final VoidCallback? onPayPressed;

  const CartSidebarV2({super.key, this.onPayPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 420,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(left: BorderSide(color: Color(0xFFF0F5F3))),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 20,
            offset: Offset(-4, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          const _CartHeader(),

          // Items List
          const Expanded(child: _CartItemsList()),

          // Footer / Payment Summary
          _PaymentSummary(onPayPressed: onPayPressed),
        ],
      ),
    );
  }
}

class _CartHeader extends StatelessWidget {
  const _CartHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF0F5F3))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.shopping_basket,
                color: AppColors.emerald600,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Keranjang',
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF101816),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.slate100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '3 Item',
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.slate600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CartItemsList extends StatelessWidget {
  const _CartItemsList();

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'name': 'Beras Premium 5kg',
        'price': 60000,
        'quantity': 1,
        'image':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuAvFUJcNiMdgJpD_-5gkBFi-iU6HrDVYCD2PmRPMYyUCtyc_GPVFLohlfW_BkLXZGSo8TO8E1NncNts-uW-pFQt9kASYahYUik4VDN0t2FqTlwl4oTBCf209mwJPOGdNru9EdQP6sSm73uIUkB1IeZS9fm5YKN-kJI_7PBEklI-40wNccxGyFa2478mKUPzh9XTe5Ijnvy7s1oqy-Sc22EpdN8q3euTLmGsg0EaODYPfhCdI4bDykJsq3KFUKav38BwRgeij2HhmHQ',
        'isMember': true,
      },
      {
        'name': 'Susu UHT Full Cream 1L',
        'price': 17500,
        'quantity': 2,
        'image':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuDZENFVsjTgCovCdcbrwmp29S5o8IrRpTNfYabghSbfdkF1JhwKdAAcxGZmtO7C2aXitcUl4M5j554Ux52J0YuQi4H2zRzCd5vb10HNLnlE7wsmpmjmNDWZ2A7elq74htVVn6ye0WY7215yA_WyL46-GQplWKsAbuJ-ha-IOw1uuqAsKSKM6sJUIoylN-fTrgbeYfWiTYxCNEoa50X_F8LmehErw-waCnc54QAHmhc9gEdgM_MY5iwGsOEQPbID118UzvR9sN2RB3I',
        'isMember': true,
      },
      {
        'name': 'Minyak Goreng 2 Liter',
        'price': 26500,
        'quantity': 1,
        'image':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuAQQpIHodQ4wK8OFSU42pGcXN5VaU7ITeiEOShykKbtXhl1jVLyJRiWmIofeMQ_TMhnuCIAOCGsPwaTIB9dFPykD1cY6i_O1MFMruA2_1y7dzjHiO36I3TQzvO5oHF2zhYzIqgBB1lnwHbFPUcDEo0oVMX8lfYWekvRhtvs4GYTYmMcskb0ga7GMlmqWzmNzTzL7fwcJHmzecB6MoTDo2k7B8zoT2i-q3r122l_9320AHm-jHfQz2ZeKMhBPeZjbUhXbbPW9B1VIxQ',
        'isMember': true,
      },
    ];

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return _CartItem(item: items[index]);
      },
    );
  }
}

class _CartItem extends StatelessWidget {
  final Map<String, dynamic> item;

  const _CartItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.transparent),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.slate100,
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(item['image'] as String),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'] as String,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF101816),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          '@ Rp ${item['price']}',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.emerald600,
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                        ),
                        if (item['isMember'] == true) ...[
                          const SizedBox(width: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 1,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.emerald500.withValues(
                                alpha: 0.1,
                              ),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: AppColors.emerald500.withValues(
                                  alpha: 0.2,
                                ),
                              ),
                            ),
                            child: const Text(
                              'Member',
                              style: TextStyle(
                                color: AppColors.emerald500,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 28,
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.slate200),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.02),
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.remove, size: 14),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(minWidth: 24),
                          ),
                          SizedBox(
                            width: 20,
                            child: Text(
                              '${item['quantity']}',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.bodySmall.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.add, size: 14),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(minWidth: 24),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Rp ${item['price'] * item['quantity']}',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF101816),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentSummary extends StatelessWidget {
  final VoidCallback? onPayPressed;

  const _PaymentSummary({this.onPayPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.slate50,
        border: Border(top: BorderSide(color: Color(0xFFF0F5F3))),
      ),
      child: Column(
        children: [
          // Detail Pembayaran Pin
          Center(
            child: Container(
              transform: Matrix4.translationValues(0, -32, 0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.slate200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  'DETAIL PEMBAYARAN',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.slate400,
                    fontWeight: FontWeight.w800,
                    fontSize: 8,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ),

          // Subtotal & Tax
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtotal',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.slate500,
                ),
              ),
              Text(
                'Rp 121.500',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.charcoal900,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pajak (PPN 11%)',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.slate500,
                ),
              ),
              Text(
                'Termasuk',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.charcoal900,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          // Divider
          Container(
            height: 1,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColors.slate200,
                  style: BorderStyle.none, // Custom dash
                ),
              ),
            ),
            child: Row(
              children: List.generate(
                30,
                (index) => Expanded(
                  child: Container(
                    height: 1,
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    color: AppColors.slate300,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Total',
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Rp 121.500',
                style: AppTextStyles.h1.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 28,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Checkout Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: onPayPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.emerald600,
                foregroundColor: Colors.white,
                elevation: 4,
                shadowColor: AppColors.emerald600.withValues(alpha: 0.4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bayar Sekarang',
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_forward, size: 20),
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
