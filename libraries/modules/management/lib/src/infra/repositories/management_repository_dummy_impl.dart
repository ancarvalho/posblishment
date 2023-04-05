import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
// import 'package:flutter/foundation.dart';
import 'package:internal_database/internal_database.dart';

import '../../domain/repositories/management_repository.dart';

class ManagementRepositoryDummyImpl implements ManagementRepository {
  final AppDatabase appDatabase;

  ManagementRepositoryDummyImpl(this.appDatabase);

  @override
  Future<Either<Failure, int>> createCategory(Category category) async {
    // await Future.delayed(const Duration(seconds: 2));

    final created = await appDatabase.createCategory(category);
    print(created);

    return Right(created);
  }

  @override
  Future<Either<Failure, int>> updateCategory(Category category) async {
    // await Future.delayed(const Duration(seconds: 2));
    final updated = await appDatabase.updateCategory(category);

    return Right(updated);
  }

  @override
  Future<Either<Failure, int>> deleteCategory(String id) async {
    // await Future.delayed(const Duration(seconds: 2));

    final deleted = await appDatabase.deleteCategory(id);

    return Right(deleted);
  }

  @override
  Future<Either<Failure, int>> createProduct(Product product) async {
    // await Future.delayed(const Duration(seconds: 2));
    final created = await appDatabase.createProduct(product);
    return Right(created);
  }

  @override
  Future<Either<Failure, int>> updateProduct(Product product) async {
    // await Future.delayed(const Duration(seconds: 2));

    final updated = await appDatabase.updateProduct(product);
    return Right(updated);
  }

  @override
  Future<Either<Failure, int>> deleteProduct(String id) async {
    // await Future.delayed(const Duration(seconds: 2));

    final deleted = await appDatabase.deleteProduct(id);
    return Right(deleted);
  }

  @override
  Future<Either<Failure, List<Category>>> listAllCategories() async {
    // await Future.delayed(const Duration(seconds: 2));

    final categories = await appDatabase.getCategories();
    return Right(categories);


  }

  @override
  Future<Either<Failure, List<Product>>> listAllProducts() async {
    // await Future.delayed(const Duration(seconds: 2));

     final products = await appDatabase.getProducts();
    return Right(products);


   
  }
}
