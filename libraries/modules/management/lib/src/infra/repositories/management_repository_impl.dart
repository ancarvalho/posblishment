import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/management_repository.dart';
import '../data_source/management_data_source_internal.dart';

class ManagementRepositoryImpl implements ManagementRepository {
  // final AppDatabase appDatabase;

  final ManagementDataSource _dataSource;

  ManagementRepositoryImpl(this._dataSource);

  // Products

  @override
  Future<Either<Failure, List<Category>>> listAllCategories() async {
    try {
      final categories = await _dataSource.listAllCategories();
      if (categories.isEmpty) {
        return Left(NoDataFound());
      }

      return Right(categories);
    } on Failure catch (e) {
      return Left(e);
    } on Exception catch (exception, stacktrace) {
      return Left(
        UnknownError(
          exception: exception,
          stackTrace: stacktrace,
          label: 'ManagementDataSource-listAllCategories',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, int>> createCategory(Category category) async {
    try {
      final txId = await _dataSource.createCategory(category);
      return Right(txId);
    } on Failure catch (e) {
      return Left(e);
    } on Exception catch (exception, stacktrace) {
      return Left(
        UnknownError(
          exception: exception,
          stackTrace: stacktrace,
          label: 'ManagementDataSource-createCategory',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, int>> updateCategory(Category category) async {
    try {
      final txId = await _dataSource.updateCategory(category);
      return Right(txId);
    } on Failure catch (e) {
      return Left(e);
    } on Exception catch (exception, stacktrace) {
      return Left(
        UnknownError(
          exception: exception,
          stackTrace: stacktrace,
          label: 'ManagementDataSource-updateCategory',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, int>> deleteCategory(String id) async {
    try {
      final txId = await _dataSource.deleteCategory(id);
      return Right(txId);
    } on Failure catch (e) {
      return Left(e);
    } on Exception catch (exception, stacktrace) {
      return Left(
        UnknownError(
          exception: exception,
          stackTrace: stacktrace,
          label: 'ManagementDataSource-deleteCategory',
        ),
      );
    }
  }

  // Products

  @override
  Future<Either<Failure, List<Product>>> listAllProducts() async {
    try {
      final products = await _dataSource.listAllProducts();

      if (products.isEmpty) {
        return Left(NoDataFound());
      }

      return Right(products);
    } on Failure catch (e) {
      return Left(e);
    } on Exception catch (exception, stacktrace) {
      return Left(
        UnknownError(
          exception: exception,
          stackTrace: stacktrace,
          label: 'ManagementDataSource-listAllProducts',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, int>> createProduct(NewProduct product) async {
    try {
      final txId = await _dataSource.createProduct(product);
      return Right(txId);
    } on Failure catch (e) {
      return Left(e);
    } on Exception catch (exception, stacktrace) {
      return Left(
        UnknownError(
          exception: exception,
          stackTrace: stacktrace,
          label: 'ManagementDataSource-createProduct',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, int>> updateProduct(UpdateProductModel product) async {
    try {
      final txId = await _dataSource.updateProduct(product);
      return Right(txId);
    } on Failure catch (e) {
      return Left(e);
    } on Exception catch (exception, stacktrace) {
      return Left(
        UnknownError(
          exception: exception,
          stackTrace: stacktrace,
          label: 'ManagementDataSource-updateProduct',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, int>> deleteProduct(String id) async {
    try {
      final txId = await _dataSource.deleteProduct(id);
      return Right(txId);
    } on Failure catch (e) {
      return Left(e);
    } on Exception catch (exception, stacktrace) {
      return Left(
        UnknownError(
          exception: exception,
          stackTrace: stacktrace,
          label: 'ManagementDataSource-deleteProduct',
        ),
      );
    }
  }
}
