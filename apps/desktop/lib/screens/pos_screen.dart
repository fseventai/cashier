import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/shared/widgets/pos/pos_header.dart';
import 'package:cashier/shared/widgets/pos/product_list.dart';
import 'package:cashier/shared/widgets/pos/cart_summary.dart';
import 'package:cashier/shared/widgets/pos/pos_sidebar.dart';

import 'package:cashier/shared/widgets/pos/pos_menu_drawer.dart';

class PosScreen extends StatefulWidget {
  const PosScreen({super.key});

  @override
  State<PosScreen> createState() => _PosScreenState();
}

class _PosScreenState extends State<PosScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                const PosHeader(),
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
            ),
          ),
        ],
      ),
    );
  }
}
