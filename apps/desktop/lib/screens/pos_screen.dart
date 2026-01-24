import 'package:cashier/screens/pos_screen_v2.dart';
import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/shared/widgets/pos/pos_header.dart';
import 'package:cashier/shared/widgets/pos/product_list.dart';
import 'package:cashier/shared/widgets/pos/cart_summary.dart';
import 'package:cashier/shared/widgets/pos/pos_sidebar.dart';

import 'package:cashier/shared/widgets/pos/pos_menu_drawer.dart';
import 'package:cashier/shared/widgets/pos/payment_modal.dart';
import 'package:cashier/shared/widgets/pos/quantity_input_modal.dart';
import 'package:flutter/services.dart';

class PosScreen extends StatefulWidget {
  const PosScreen({super.key});

  @override
  State<PosScreen> createState() => _PosScreenState();
}

class _PosScreenState extends State<PosScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isV2 = false;

  void _toggleLayout() {
    // Clear focus to avoid RawKeyboard assertion errors during tree replacement
    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      _isV2 = !_isV2;
    });
  }

  void _showPaymentModal() {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.4),
      builder: (context) => const PaymentModal(
        totalAmount:
            59500, // This should come from a state manager or cart model
      ),
    );
  }

  void _showQuantityModal() {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.4),
      builder: (context) => const QuantityInputModal(),
    ).then((value) {
      if (value != null) {
        // Handle the returned quantity value
        debugPrint('Confirmed Quantity: $value');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isV2) {
      return PosScreenV2(onToggleLayout: _toggleLayout);
    }

    return Focus(
      autofocus: true,
      onKeyEvent: (FocusNode node, KeyEvent event) {
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.f10) {
          _showPaymentModal();
          return KeyEventResult.handled;
        }
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.f6) {
          _showQuantityModal();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.surfaceAlt,
        endDrawer: const PosMenuDrawer(),
        body: Row(
          children: [
            // Main Content (Left Panel) - 75%
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  PosHeader(onToggleLayout: _toggleLayout),
                  // Product List Headers would go here or inside ProductList
                  const ProductList(),
                  const CartSummary(),
                ],
              ),
            ),

            // Sidebar (Right Panel) - 25%
            Expanded(
              flex: 1,
              child: PosSidebar(
                onMorePressed: () => _scaffoldKey.currentState?.openEndDrawer(),
                onPayPressed: _showPaymentModal,
                onQtyPressed: _showQuantityModal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
