import 'package:core/core.dart';
import "package:drift/drift.dart";
import 'package:internal_database/internal_database.dart';
import 'package:management/src/domain/errors/management_failures.dart';

import '../../infra/data_source/management_data_source_internal.dart';

class ManagementDataSourceInternalImpl implements ManagementDataSource {
  final AppDatabase appDatabase;

  ManagementDataSourceInternalImpl(this.appDatabase);


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
  Future<int> createProduct(NewProduct product) async {
    try {
      final created = await appDatabase
          .into(appDatabase.product)
          .insert(ProductAdapter.createProduct(product));
      return created;
    } on InvalidDataException catch (e, s) {
      throw InternalDatabaseErrorDataException(
        s,
        'ManagementDataSource-createProduct-DataException',
        e.message,
        e.message,
      );
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
  Future<int> updateProduct(UpdateProductModel product) async {
    try {
      final updated = await (appDatabase.update(appDatabase.product)
            ..where((t) => t.id.equals(product.id)))
          .write(ProductAdapter.updateProduct(product));
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
          .insert(CategoryAdapter.createCategory(category));

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
          .write(CategoryAdapter.updateCategory(category));
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

    @override
  Future<BillType> getBillType(String id) async {
    try {
      final billType =
          await (appDatabase.select(appDatabase.billType)
                ..where((tbl) => tbl.id.equals(id)))
              // .map(BillTypeAdapter.convertToBillType)
              .getSingle();
      return BillTypeAdapter.convertToBillType(billType);
    } catch (e, s) {
      throw ManagementError(
        s,
        "InternalDatabase-Management-getBillType",
        e,
        e.toString(),
      );
    }
  }

  @override
  Future<BillType> getDefaultBillType() async {
    try {
      final billType =
          await (appDatabase.select(appDatabase.billType)
                ..where((tbl) => tbl.defaultType.equals(true)))
              // .map(BillTypeAdapter.convertToBillType)
              .getSingle();
      return BillTypeAdapter.convertToBillType(billType);
    } catch (e, s) {
      throw ManagementError(
        s,
        "InternalDatabase-Management-getDefaultBillType",
        e,
        e.toString(),
      );
    }
  }

  @override
  Future<List<BillType>> getBillTypes() {
    try {
      final billTypes = appDatabase
          .select(appDatabase.billType)
          .map(BillTypeAdapter.convertToBillType)
          .get();
      return billTypes;
    } catch (e, s) {
      throw ManagementError(
        s,
        "InternalDatabase-Management-getBillTypes",
        e,
        e.toString(),
      );
    }
  }

  @override
  Future<int> deleteBillType(String id) {
    try {
      final billTypes = (appDatabase.delete(appDatabase.billType)
            ..where((tbl) => tbl.id.equals(id)))
          .go();
      return billTypes;
    } catch (e, s) {
      throw ManagementError(
        s,
        "InternalDatabase-Management-deleteBillType",
        e,
        e.toString(),
      );
    }
  }

  @override
  Future<bool> createBillType(NewBillType newBillType) async {
    try {
      await appDatabase
          .into(appDatabase.billType)
          .insert(BillTypeAdapter.createBillType(newBillType));
      return true;
    } catch (e, s) {
      throw ManagementError(
        s,
        "InternalDatabase-Management-createBillType",
        e,
        e.toString(),
      );
    }
  }

  @override
  Future<bool> removeBillTypeDefaultValue() async {
    try {
      await appDatabase
          .update(appDatabase.billType)
          .write(const BillTypeCompanion(defaultType: Value(false)));
      return true;
    } catch (e, s) {
      throw ManagementError(
        s,
        "InternalDatabase-Management-removeDefaultValue",
        e,
        e.toString(),
      );
    }
  }

  @override
  Future<bool> setDefaultBillType(String id) async {
    try {
      await (appDatabase.update(appDatabase.billType)
            ..where((tbl) => tbl.id.equals(id)))
          .write(const BillTypeCompanion(defaultType: Value(true)));
      return true;
    } catch (e, s) {
      throw ManagementError(
        s,
        "InternalDatabase-Management-setDefaultBillType",
        e,
        e.toString(),
      );
    }
  }
  
  @override
  Future<bool> updateBillType(BillType newBillType) async {
    try {
      await (appDatabase.update(appDatabase.billType)
            ..where((tbl) => tbl.id.equals(newBillType.id)))
          .write(BillTypeAdapter.updateBillType(newBillType));
      return true;
    } catch (e, s) {
      throw ManagementError(
        s,
        "InternalDatabase-Management-updateBillType",
        e,
        e.toString(),
      );
    }
  }

}
