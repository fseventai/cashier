import 'package:cashier/core/models/product.dart';
import 'package:cashier/core/services/api_service.dart';

abstract class IProductRepository {
  Future<List<Product>> getProducts();
  Future<Product> getProductById(String id);
  Future<String> createProduct(Product product);
  Future<void> updateProduct(String id, Product product);
  Future<void> deleteProduct(String id);

  Future<List<ProductGroup>> getGroups();
  Future<List<Tax>> getTaxes();
  Future<List<StorageLocation>> getLocations();
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
  Future<void> deleteProduct(String id) async {
    await _apiService.dio.delete('/products/$id');
  }

  @override
  Future<List<ProductGroup>> getGroups() async {
    final response = await _apiService.dio.get('/products/groups');
    return (response.data as List)
        .map((e) => ProductGroup.fromJson(e))
        .toList();
  }

  @override
  Future<List<Tax>> getTaxes() async {
    final response = await _apiService.dio.get('/products/taxes');
    return (response.data as List).map((e) => Tax.fromJson(e)).toList();
  }

  @override
  Future<List<StorageLocation>> getLocations() async {
    final response = await _apiService.dio.get('/products/locations');
    return (response.data as List)
        .map((e) => StorageLocation.fromJson(e))
        .toList();
  }
}
