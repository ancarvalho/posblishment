import 'dart:io';

import "package:core/core.dart";
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:internal_database/src/domain/repositories/category_repository.dart';
import 'package:internal_database/src/domain/repositories/product_repository.dart';
import 'package:path_provider/path_provider.dart';

import '../tables/tables.dart' as t;
import '../utils/adapters/category_adapter.dart';
import '../utils/adapters/product_adapter.dart';

part 'sqlite.g.dart';

Future<File> get databaseFile async {
  // We use `path_provider` to find a suitable path to store our data in.

  final appDir = await getApplicationDocumentsDirectory();
  final dbPath = [appDir.path, 'posblishment.db'].join("/");
  return File(dbPath);
}

/// Obtains a database connection for running drift in a Dart VM.
DatabaseConnection connect() {
  return DatabaseConnection.delayed(
    Future(() async {
      return NativeDatabase.createBackgroundConnection(await databaseFile);
    }),
  );
}

@DriftDatabase(
  tables: [
    t.Product,
    t.Category,
    t.Bill,
    t.Item,
    t.Payment,
    t.ProductVariation,
    t.Request
  ],
)
class AppDatabase extends _$AppDatabase
    implements ProductRepository, CategoryRepository {
  AppDatabase() : super(connect());

  AppDatabase.forTesting(DatabaseConnection connection) : super(connection);

  @override
  int get schemaVersion => 3;

  // ------------------------Product---------------------------
  @override
  Future<Product> getProduct(String id) {
    return (select(product)..where((p) => p.id.equals(id)))
        .map(ProductAdapter.fromProductData)
        .getSingle();
  }

  @override
  Future<List<Product>> getProducts() {
    return select(product).map(ProductAdapter.fromProductData).get();
  }

  @override
  Future<int> createProduct(Product newProduct) {
    return into(product).insert(ProductAdapter.createProductData(newProduct));
  }

  @override
  Future<int> deleteProduct(String id) {
    return (delete(product)..where((tbl) => tbl.id.equals(id))).go();
  }

// TODO Modify
  @override
  Future<int> updateProduct(Product newProduct) {
    if (newProduct.id == null) {
      throw Error();
    }
    return (update(product)..where((t) => t.id.equals(newProduct.id!)))
        .write(ProductAdapter.toProductCompanion(newProduct));
  }

  // ------------------------Category---------------------------
  @override
  Future<int> createCategory(Category newCategory) {
    return into(category).insert(CategoryAdapter.toCategoryData(newCategory));
  }

  @override
  Future<List<Category>> getCategories() {
    return select(category).map(CategoryAdapter.fromCategoryData).get();
  }

  @override
  Future<List<CategorizedProduct>> getCategorizedProducts() {
    final query = select(category).join(
      [leftOuterJoin(product, product.categoryId.equalsExp(category.id))],
    );

    return query.map((r) {
      return CategorizedProduct(
        category: CategoryAdapter.fromCategoryData(r.readTable(category)),
        product: ProductAdapter.fromProductData(r.readTable(product)),
      );
    }).get();
  }

  @override
  Future<Category> getCategory(String id) {
    return (select(category)..where((tbl) => tbl.id.equals(id)))
        .map(CategoryAdapter.fromCategoryData)
        .getSingle();
  }

  @override
  Future<int> updateCategory(Category newCategory) {
    if (newCategory.id == null) {
      throw Error();
    }

    return (update(category)..where((t) => t.id.equals(newCategory.id!)))
        .write(CategoryAdapter.toCategoryCompanion(newCategory));
  }

  @override
  Future<int> deleteCategory(String id) {
    return (delete(category)..where((tbl) => tbl.id.equals(id))).go();
  }
}
