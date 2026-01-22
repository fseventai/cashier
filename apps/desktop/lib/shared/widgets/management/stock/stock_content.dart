import 'package:flutter/material.dart';
import 'package:cashier/shared/widgets/management/stock/stock_category_tree.dart';
import 'package:cashier/shared/widgets/management/stock/stock_footer.dart';
import 'package:cashier/shared/widgets/management/stock/stock_product_list.dart';
import 'package:cashier/shared/widgets/management/stock/stock_toolbar.dart';

class StockContent extends StatelessWidget {
  const StockContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const StockToolbar(),
        Expanded(
          child: Row(
            children: [
              const StockCategoryTree(),
              const Expanded(child: StockProductList()),
            ],
          ),
        ),
        const StockFooter(),
      ],
    );
  }
}
