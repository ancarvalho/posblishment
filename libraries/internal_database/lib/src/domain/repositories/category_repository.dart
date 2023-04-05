import "package:core/core.dart";


abstract class CategoryRepository {
  Future<List<Category>> getCategories();
  Future<List<CategorizedProduct>> getCategorizedProducts();
  Future<Category> getCategory(String id);
  //
  Future<int> createCategory(Category category);
  Future<int> updateCategory(Category category);
  Future<int> deleteCategory(String id);
}
