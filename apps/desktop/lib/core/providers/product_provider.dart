import 'dart:async';
import 'package:cashier/core/models/product.dart';

import 'package:cashier/core/repositories/product_repository.dart';
import 'package:cashier/core/services/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository(ref.watch(apiServiceProvider));
});

final productListProvider = AsyncNotifierProvider<ProductList, List<Product>>(
  ProductList.new,
);

class ProductList extends AsyncNotifier<List<Product>> {
  @override
  FutureOr<List<Product>> build() async {
    return ref.watch(productRepositoryProvider).getProducts();
  }

  Future<void> saveProduct(Product product) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      if (product.id.isEmpty) {
        await ref.read(productRepositoryProvider).createProduct(product);
      } else {
        await ref
            .read(productRepositoryProvider)
            .updateProduct(product.id, product);
      }
      return ref.read(productRepositoryProvider).getProducts();
    });
  }

  Future<void> deleteProduct(String id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(productRepositoryProvider).deleteProduct(id);
      return ref.read(productRepositoryProvider).getProducts();
    });
  }
}

final productFormProvider = NotifierProvider<ProductForm, Product>(
  ProductForm.new,
);

class ProductForm extends Notifier<Product> {
  @override
  Product build() {
    return const Product(id: '', name: '');
  }

  void updateProduct(Product product) {
    state = product;
  }

  void updateName(String name) {
    state = state.copyWith(name: name);
  }
}
