import 'package:cashier/shared/widgets/pos/pos_menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/shared/widgets/pos/v2/pos_header_v2.dart';
import 'package:cashier/shared/widgets/pos/v2/member_status_bar.dart';
import 'package:cashier/shared/widgets/pos/v2/product_grid_v2.dart';
import 'package:cashier/shared/widgets/pos/v2/cart_sidebar_v2.dart';

class PosScreenV2 extends StatefulWidget {
  final VoidCallback onToggleLayout;

  const PosScreenV2({super.key, required this.onToggleLayout});

  @override
  State<PosScreenV2> createState() => _PosScreenV2State();
}

class _PosScreenV2State extends State<PosScreenV2> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: Column(
                    children: [
                      MemberStatusBar(),
                      Expanded(child: ProductGridV2()),
                    ],
                  ),
                ),

                // Right Panel: Cart Sidebar
                const CartSidebarV2(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
