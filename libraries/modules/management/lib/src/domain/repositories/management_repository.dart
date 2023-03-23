import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/entities.dart' as e;

abstract class ManagementRepository {
  Future<Either<Failure, List<e.Product>>> listAllProducts();

  Future<Either<Failure, e.Product>> updateProduct(e.Product product);
  Future<Either<Failure, e.Product>> createProduct(e.Product product);
  Future<Either<Failure, e.Product>> deleteProduct(String id);
  Future<Either<Failure, List<e.Category>>> listAllCategories();
  Future<Either<Failure, e.Category>> updateCategory(e.Category category);
  Future<Either<Failure, e.Category>> createCategory(e.Category category);
  Future<Either<Failure, e.Category>> deleteCategory(String id);
}
