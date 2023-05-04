import 'package:core/core.dart';

abstract class ManagementDataSource {
  Future<List<Product>> listAllProducts();
  Future<int> updateProduct(Product product);
  Future<int> createProduct(Product product);
  Future<int> deleteProduct(String id);

  Future<List<Category>> listAllCategories();
  Future<int> updateCategory(Category category);
  Future<int> createCategory(Category category);
  Future<int> deleteCategory(String id);
}
