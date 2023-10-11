import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

// import '../entities/entities.dart' as e;

abstract class ManagementRepository {
  Future<Either<Failure, List<Product>>> listAllProducts();

  Future<Either<Failure, int>> updateProduct(UpdateProductModel product);
  Future<Either<Failure, int>> createProduct(NewProduct product);
  Future<Either<Failure, int>> deleteProduct(String id);

  Future<Either<Failure, List<Category>>> listAllCategories();
  Future<Either<Failure, int>> updateCategory(Category category);
  Future<Either<Failure, int>> createCategory(Category category);
  Future<Either<Failure, int>> deleteCategory(String id);

 Future<Either<Failure, List<BillType>>> getBillTypes();
  Future<Either<Failure, BillType>> getBillType(String id);
  Future<Either<Failure, bool>> createBillType(NewBillType newBillType);
  Future<Either<Failure, bool>> updateBillType(BillType newBillType);
  Future<Either<Failure, BillType>> getDefaultBillType();
  Future<Either<Failure, bool>> removeBillTypeDefaultValue();
  Future<Either<Failure, bool>> setDefaultBillType(String id);
  Future<Either<Failure, int>> deleteBillType(String id);
}
