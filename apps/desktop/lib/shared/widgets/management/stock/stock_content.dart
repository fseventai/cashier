import 'package:flutter/material.dart';
import 'package:cashier/shared/widgets/management/stock/stock_category_tree.dart';
import 'package:cashier/shared/widgets/management/stock/stock_footer.dart';
import 'package:cashier/shared/widgets/management/stock/stock_product_list.dart';

class StockContent extends StatelessWidget {
  const StockContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
