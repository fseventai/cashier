import 'package:cashier/core/models/product.dart';
import 'package:cashier/core/services/api_service.dart';

abstract class IProductRepository {
  Future<List<Product>> getProducts();
  Future<Product> getProductById(String id);
  Future<String> createProduct(Product product);
  Future<void> updateProduct(String id, Product product);
  Future<dynamic> deleteProduct(String id);

  Future<List<ProductGroup>> getGroups();
  Future<ProductGroup> createGroup(ProductGroup group);
  Future<void> updateGroup(String id, ProductGroup group);
  Future<dynamic> deleteGroup(String id);

  Future<List<Tax>> getTaxes();
  Future<Tax> createTax(Tax tax);
  Future<void> updateTax(String id, Tax tax);
  Future<dynamic> deleteTax(String id);

  Future<List<StorageLocation>> getLocations();
  Future<StorageLocation> createLocation(StorageLocation location);
  Future<void> updateLocation(String id, StorageLocation location);
  Future<void> deleteLocation(String id);
}

class ProductRepository implements IProductRepository {
  final ApiService _apiService;

  ProductRepository(this._apiService);

  @override
  Future<List<Product>> getProducts() async {
    final response = await _apiService.dio.get('/products');
    return (response.data as List).map((e) => Product.fromJson(e)).toList();
  }

  @override
  Future<Product> getProductById(String id) async {
    final response = await _apiService.dio.get('/products/$id');
    return Product.fromJson(response.data);
  }

  @override
  Future<String> createProduct(Product product) async {
    final response = await _apiService.dio.post(
      '/products',
      data: product.toJson(),
    );
    return response.data['id'];
  }

  @override
  Future<void> updateProduct(String id, Product product) async {
    await _apiService.dio.patch('/products/$id', data: product.toJson());
  }

  @override
  Future<dynamic> deleteProduct(String id) async {
    final response = await _apiService.dio.delete('/products/$id');
    return response.data;
  }

  @override
  Future<List<ProductGroup>> getGroups() async {
    final response = await _apiService.dio.get('/products/groups');
    return (response.data as List)
        .map((e) => ProductGroup.fromJson(e))
        .toList();
  }

  @override
  Future<ProductGroup> createGroup(ProductGroup group) async {
    final response = await _apiService.dio.post(
      '/products/groups',
      data: group.toJson(),
    );
    return ProductGroup.fromJson(response.data);
  }

  @override
  Future<void> updateGroup(String id, ProductGroup group) async {
    await _apiService.dio.patch('/products/groups/$id', data: group.toJson());
  }

  @override
  Future<dynamic> deleteGroup(String id) async {
    final response = await _apiService.dio.delete('/products/groups/$id');
    return response.data;
  }

  @override
  Future<List<Tax>> getTaxes() async {
    final response = await _apiService.dio.get('/products/taxes');
    return (response.data as List).map((e) => Tax.fromJson(e)).toList();
  }

  @override
  Future<Tax> createTax(Tax tax) async {
    final response = await _apiService.dio.post(
      '/products/taxes',
      data: tax.toJson(),
    );
    return Tax.fromJson(response.data);
  }

  @override
  Future<void> updateTax(String id, Tax tax) async {
    await _apiService.dio.patch('/products/taxes/$id', data: tax.toJson());
  }

  @override
  Future<dynamic> deleteTax(String id) async {
    final response = await _apiService.dio.delete('/products/taxes/$id');
    return response.data;
  }

  @override
  Future<List<StorageLocation>> getLocations() async {
    final response = await _apiService.dio.get('/products/locations');
    return (response.data as List)
        .map((e) => StorageLocation.fromJson(e))
        .toList();
  }

  @override
  Future<StorageLocation> createLocation(StorageLocation location) async {
    final response = await _apiService.dio.post(
      '/products/locations',
      data: location.toJson(),
    );
    return StorageLocation.fromJson(response.data);
  }

  @override
  Future<void> updateLocation(String id, StorageLocation location) async {
    await _apiService.dio.patch(
      '/products/locations/$id',
      data: location.toJson(),
    );
  }

  @override
  Future<void> deleteLocation(String id) async {
    await _apiService.dio.delete('/products/locations/$id');
  }
}
