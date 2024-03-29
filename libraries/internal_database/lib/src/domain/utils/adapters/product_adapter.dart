import "package:core/core.dart";
import 'package:drift/drift.dart';
import 'package:internal_database/src/domain/db/sqlite.dart';
import "package:uuid/uuid.dart";

class ProductAdapter {
  static Product fromProductData(ProductData product) {
    return Product(
      id: product.id,
      code: product.code,
      name: product.name,
      description: product.description,
      price: product.price,
      variations: product.variations,
      preparable: product.preparable,
      categoryId: product.categoryId,
      createdAt: product.createdAt,
      updatedAt: product.updatedAt,
    );
  }

  static ProductData createProduct(NewProduct product) {
    return ProductData(
      id: const Uuid().v4(),
      code: product.code,
      name: product.name,
      description: product.description,
      price: product.price,
      preparable: product.preparable,
      categoryId: product.categoryId,
      variations: product.variations,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  static ProductCompanion updateProduct(UpdateProductModel product) {
    return ProductCompanion(
      code: Value(product.code),
      name: Value(product.name),
      description: Value(product.description),
      price: Value(product.price),
      variations: Value(product.variations),
      preparable: Value(product.preparable),
      categoryId: Value(product.categoryId),
      updatedAt: Value(DateTime.now()),
    );
  }
}
