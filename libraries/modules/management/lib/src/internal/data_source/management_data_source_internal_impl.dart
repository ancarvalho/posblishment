import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:internal_database/internal_database.dart';
import 'package:management/src/domain/errors/management_failures.dart';
import "package:drift/drift.dart";

import '../../infra/data_source/management_data_source_internal.dart';

class ManagementDataSourceInternalImpl implements ManagementDataSource {
  final AppDatabase appDatabase;

  ManagementDataSourceInternalImpl(this.appDatabase);

  //  try {

  //   } catch (e, stackTrace) {
  //     throw ManagementError(
  //       stackTrace,
  //       'ManagementDataSource-listAllCategories',
  //       e,
  //       e.toString(),
  //     );
  //   }

  @override
  Future<List<Product>> listAllProducts() async {
    try {
      final products = await appDatabase
          .select(appDatabase.product)
          .map(ProductAdapter.fromProductData)
          .get();
      return products;
    } catch (e, stackTrace) {
      throw ManagementError(
        stackTrace,
        'ManagementDataSource-listAllProducts',
        e,
        e.toString(),
      );
    }
  }

  @override
  Future<int> createProduct(Product product) async {
    try {
      final created = await appDatabase
          .into(appDatabase.product)
          .insert(ProductAdapter.createProductData(product));
      return created;
    } on InvalidDataException catch (e, s) {
      throw InternalDatabaseErrorDataException(
          s,
          'ManagementDataSource-createProduct-DataExeption',
          e.message,
          e.message);
    } catch (e, stackTrace) {
      throw ManagementError(
        stackTrace,
        'ManagementDataSource-createProduct',
        e,
        e.toString(),
      );
    }
  }

  @override
  Future<int> deleteProduct(String id) async {
    try {
      final deleted = await (appDatabase.delete(appDatabase.product)
            ..where((tbl) => tbl.id.equals(id)))
          .go();

      return deleted;
    } catch (e, stackTrace) {
      throw ManagementError(
        stackTrace,
        'ManagementDataSource-deleteProduct',
        e,
        e.toString(),
      );
    }
  }

  @override
  Future<int> updateProduct(Product product) async {
    try {
      final updated = await (appDatabase.update(appDatabase.product)
            ..where((t) => t.id.equals(product.id!)))
          .write(ProductAdapter.toProductCompanion(product));
      return updated;
    } catch (e, stackTrace) {
      throw ManagementError(
        stackTrace,
        'ManagementDataSource-updateProduct',
        e,
        e.toString(),
      );
    }
  }

  @override
  Future<List<Category>> listAllCategories() async {
    try {
      final categories = await appDatabase
          .select(appDatabase.category)
          .map(CategoryAdapter.fromCategoryData)
          .get();
      return categories;
    } catch (e, stackTrace) {
      throw ManagementError(
        stackTrace,
        'ManagementDataSource-listAllCategories',
        e,
        e.toString(),
      );
    }
  }

  @override
  Future<int> createCategory(Category category) async {
    try {
      final created = await appDatabase
          .into(appDatabase.category)
          .insert(CategoryAdapter.toCategoryData(category));

      return created;
    } on InvalidDataException catch (e, s) {
      // print(e.message.split("\n").last);
      throw InternalDatabaseErrorDataException(
        s,
        'ManagementDataSource-createCategory-DataException',
        e.message,
        e.message.split("•").last.trim(),
      );
    } catch (e, stackTrace) {
      throw ManagementError(
        stackTrace,
        'ManagementDataSource-createCategory',
        e,
        e.toString(),
      );
    }
  }

  @override
  Future<int> deleteCategory(String id) async {
    try {
      final deleted = await (appDatabase.delete(appDatabase.category)
            ..where((tbl) => tbl.id.equals(id)))
          .go();
      return deleted;
    } catch (e, stackTrace) {
      throw ManagementError(
        stackTrace,
        'ManagementDataSource-deleteCategory',
        e,
        e.toString(),
      );
    }
  }

  @override
  Future<int> updateCategory(Category category) async {
    try {
      final updated = await (appDatabase.update(appDatabase.category)
            ..where((t) => t.id.equals(category.id!)))
          .write(CategoryAdapter.toCategoryCompanion(category));
      return updated;
    } catch (e, stackTrace) {
      throw ManagementError(
        stackTrace,
        'ManagementDataSource-updateCategory',
        e,
        e.toString(),
      );
    }
  }
}
