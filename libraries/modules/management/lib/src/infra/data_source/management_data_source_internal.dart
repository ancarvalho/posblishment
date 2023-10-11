import 'package:core/core.dart';

abstract class ManagementDataSource {
  Future<List<Product>> listAllProducts();
  Future<int> updateProduct(UpdateProductModel product);
  Future<int> createProduct(NewProduct product);
  Future<int> deleteProduct(String id);

  Future<List<Category>> listAllCategories();
  Future<int> updateCategory(Category category);
  Future<int> createCategory(Category category);
  Future<int> deleteCategory(String id);

    Future<BillType> getDefaultBillType();
  Future<BillType> getBillType(String id);
  Future<bool> updateBillType(BillType billType);
  Future<bool> createBillType(NewBillType newBillType);
  Future<List<BillType>> getBillTypes();
  Future<int> deleteBillType(String id);
  Future<bool> removeBillTypeDefaultValue();
  Future<bool> setDefaultBillType(String id);
}
