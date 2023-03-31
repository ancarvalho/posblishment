import 'package:drift/drift.dart';
import 'package:internal_database/src/domain/db/sqlite.dart';
import 'package:internal_database/src/domain/entities/product.dart';

class ProductAdapter {
  static Product fromProductData(ProductData product) {
    return Product(
      id: product.id,
      name: product.name,
      description: product.description,
      price: product.price,
      preparable: product.preparable,
      categoryId: product.categoryId,
      createdAt: product.createdAt,
      updatedAt: product.updatedAt,
    );
  }

  static ProductData toProductData(Product product) {
    return ProductData(
      id: product.id,
      name: product.name,
      description: product.description,
      price: product.price,
      preparable: product.preparable,
      categoryId: product.categoryId,
      createdAt: product.createdAt,
      updatedAt: product.updatedAt,
    );
  }

  static ProductCompanion toProductCompanion(Product product) {
    return ProductCompanion(
      name: Value(product.name),
      description: Value(product.description),
      price: Value(product.price),
      preparable: Value(product.preparable),
      categoryId: Value(product.categoryId),
      updatedAt: Value(DateTime.now()),
    );
  }
}
