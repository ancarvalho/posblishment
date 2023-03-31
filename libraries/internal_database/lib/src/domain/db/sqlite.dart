import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:internal_database/src/domain/repositories/product_repository.dart';
import 'package:path_provider/path_provider.dart';

import '../entities/entities.dart';
import '../tables/tables.dart' as t;
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
class AppDatabase extends _$AppDatabase implements ProductRepository {
  AppDatabase() : super(connect());

  AppDatabase.forTesting(DatabaseConnection connection) : super(connection);

  @override
  int get schemaVersion => 3;

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
    return into(product).insert(ProductAdapter.toProductData(newProduct));
  }

  @override
  Future<int> deleteProduct(String id) {
    return (delete(product)..where((tbl) => tbl.id.equals(id))).go();
  }

  @override
  Future<int> updateProduct(Product newProduct) {
    return (update(product)..where((t) => t.id.equals(newProduct.id)))
        .write(ProductAdapter.toProductCompanion(newProduct));
  }
}
