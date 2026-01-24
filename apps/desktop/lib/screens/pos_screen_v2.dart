import 'package:cashier/shared/widgets/pos/pos_menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/shared/widgets/pos/v2/pos_header_v2.dart';
import 'package:cashier/shared/widgets/pos/v2/member_status_bar.dart';
import 'package:cashier/shared/widgets/pos/v2/product_grid_v2.dart';
import 'package:cashier/shared/widgets/pos/v2/cart_sidebar_v2.dart';
import 'package:cashier/shared/widgets/pos/payment_modal.dart';
import 'package:flutter/services.dart';

class PosScreenV2 extends StatefulWidget {
  final VoidCallback onToggleLayout;

  const PosScreenV2({super.key, required this.onToggleLayout});

  @override
  State<PosScreenV2> createState() => _PosScreenV2State();
}

class _PosScreenV2State extends State<PosScreenV2> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _showPaymentModal() {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.4),
      builder: (context) => const PaymentModal(
        totalAmount:
            121500, // This should come from a state manager or cart model
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onKeyEvent: (FocusNode node, KeyEvent event) {
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.f10) {
          _showPaymentModal();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.slate50,
        endDrawer: const PosMenuDrawer(),
        body: Column(
          children: [
            // Header
            PosHeaderV2(
              onToggleLayout: widget.onToggleLayout,
              onMorePressed: () => _scaffoldKey.currentState?.openEndDrawer(),
            ),

            // Main Content
            Expanded(
              child: Row(
                children: [
                  // Left Panel: Member Status + Product Grid
                  const Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        MemberStatusBar(),
                        Expanded(child: ProductGridV2()),
                      ],
                    ),
                  ),

                  // Right Panel: Cart Sidebar
                  Expanded(
                    flex: 2,
                    child: CartSidebarV2(onPayPressed: _showPaymentModal),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
