import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
// import 'package:flutter/foundation.dart';
import 'package:internal_database/internal_database.dart';

import '../../domain/errors/management_failures.dart';
import '../../domain/repositories/management_repository.dart';

class ManagementRepositoryDummyImpl implements ManagementRepository {
  final AppDatabase appDatabase;

  ManagementRepositoryDummyImpl(this.appDatabase);

  // Products

  @override
  Future<Either<Failure, List<Category>>> listAllCategories() async {
    // await Future.delayed(const Duration(seconds: 2));

    final categories = await appDatabase
        .select(appDatabase.category)
        .map(CategoryAdapter.fromCategoryData)
        .get();
    return Right(categories);
  }

  @override
  Future<Either<Failure, int>> createCategory(Category category) async {
    // await Future.delayed(const Duration(seconds: 2));

    final created = await appDatabase
        .into(appDatabase.category)
        .insert(CategoryAdapter.toCategoryData(category));

    return Right(created);
  }

  @override
  Future<Either<Failure, int>> updateCategory(Category category) async {
    // await Future.delayed(const Duration(seconds: 2));
    if (category.id == null) {
      throw Error();
    }
    try {
      final updated = await (appDatabase.update(appDatabase.category)
            ..where((t) => t.id.equals(category.id!)))
          .write(CategoryAdapter.toCategoryCompanion(category));
      return Right(updated);
    } catch (e, stackTrace) {
      return Left(
        ManagementError(stackTrace, e.toString(), e.toString(), e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, int>> deleteCategory(String id) async {
    // await Future.delayed(const Duration(seconds: 2));

    final deleted = await (appDatabase.delete(appDatabase.category)
          ..where((tbl) => tbl.id.equals(id)))
        .go();

    return Right(deleted);
  }

  // Products

  @override
  Future<Either<Failure, List<Product>>> listAllProducts() async {
    final products = await appDatabase
        .select(appDatabase.product)
        .map(ProductAdapter.fromProductData)
        .get();
    return Right(products);
  }

  @override
  Future<Either<Failure, int>> createProduct(Product product) async {
    // await Future.delayed(const Duration(seconds: 2));
    final created = await appDatabase
        .into(appDatabase.product)
        .insert(ProductAdapter.createProductData(product));
    return Right(created);
  }

  @override
  Future<Either<Failure, int>> updateProduct(Product product) async {
    // await Future.delayed(const Duration(seconds: 2));
    if (product.id == null) {
      throw Error();
    }
    final updated = await (appDatabase.update(appDatabase.product)
          ..where((t) => t.id.equals(product.id!)))
        .write(ProductAdapter.toProductCompanion(product));
    return Right(updated);
  }

  @override
  Future<Either<Failure, int>> deleteProduct(String id) async {
    // await Future.delayed(const Duration(seconds: 2));

    final deleted = await (appDatabase.delete(appDatabase.product)
          ..where((tbl) => tbl.id.equals(id)))
        .go();

    return Right(deleted);
  }
}
