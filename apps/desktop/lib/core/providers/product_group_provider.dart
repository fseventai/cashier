import 'dart:async';
import 'package:cashier/core/models/product.dart';
import 'package:cashier/core/providers/product_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productGroupListProvider =
    AsyncNotifierProvider<ProductGroupList, List<ProductGroup>>(
      ProductGroupList.new,
    );

class ProductGroupList extends AsyncNotifier<List<ProductGroup>> {
  @override
  FutureOr<List<ProductGroup>> build() async {
    return ref.watch(productRepositoryProvider).getGroups();
  }

  Future<void> saveGroup(ProductGroup group) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      if (group.id.isEmpty) {
        await ref.read(productRepositoryProvider).createGroup(group);
      } else {
        await ref.read(productRepositoryProvider).updateGroup(group.id, group);
      }
      return ref.read(productRepositoryProvider).getGroups();
    });
  }

  Future<void> deleteGroup(String id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(productRepositoryProvider).deleteGroup(id);
      return ref.read(productRepositoryProvider).getGroups();
    });
  }
}

final productGroupFormProvider =
    NotifierProvider<ProductGroupForm, ProductGroup>(ProductGroupForm.new);

class ProductGroupForm extends Notifier<ProductGroup> {
  @override
  ProductGroup build() {
    return const ProductGroup(id: '', name: '');
  }

  void setGroup(ProductGroup group) {
    state = group;
  }

  void updateName(String name) {
    state = state.copyWith(name: name);
  }

  void updateParentId(String? parentId) {
    state = state.copyWith(parentId: parentId);
  }

  void updateDescription(String? description) {
    state = state.copyWith(description: description);
  }

  void updateIsActive(bool isActive) {
    state = state.copyWith(isActive: isActive);
  }

  void reset() {
    state = const ProductGroup(id: '', name: '');
  }
}
