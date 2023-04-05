import "package:core/core.dart";

abstract class ProductRepository {
  Future<List<Product>> getProducts();
  Future<Product> getProduct(String id);
  //
  Future<int> createProduct(Product product);
  Future<int> updateProduct(Product product);
  Future<int> deleteProduct(String id);
}
