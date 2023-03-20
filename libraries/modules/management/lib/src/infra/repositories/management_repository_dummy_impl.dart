import 'package:core/src/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/category.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/management_repository.dart';

class ManagementRepositoryDummyImpl implements ManagementRepository {
  @override
  Future<Either<Failure, Category>> createCategory(Category category) async {
    await Future.delayed(const Duration(seconds: 2));

    return Right(category);
  }

  @override
  Future<Either<Failure, Category>> updateCategory(Category category) async {
    await Future.delayed(const Duration(seconds: 2));

    return Right(category);
  }

  @override
  Future<Either<Failure, Category>> deleteCategory(String id) async {
    await Future.delayed(const Duration(seconds: 2));

    return Right(
      Category(
        id: id,
        name: "Not Available",
        description: "Not Available",
      ),
    );
  }

  @override
  Future<Either<Failure, Product>> createProduct(Product product) async {
    await Future.delayed(const Duration(seconds: 2));

    return Right(product);
  }

  @override
  Future<Either<Failure, Product>> updateProduct(Product product) async {
    await Future.delayed(const Duration(seconds: 2));

    return Right(product);
  }

  @override
  Future<Either<Failure, Product>> deleteProduct(String id) async {
    await Future.delayed(const Duration(seconds: 2));

    return Right(
      Product(
        id: id,
        name: "Not Available",
        unitValue: 0,
      ),
    );
  }
}
