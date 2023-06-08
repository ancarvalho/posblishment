import "package:core/core.dart";
import 'package:drift/drift.dart';
import 'package:internal_database/src/domain/db/sqlite.dart';
import "package:uuid/uuid.dart";

class CategoryAdapter {
  static Category fromCategoryData(CategoryData category) {
    return Category(
      id: category.id,
      name: category.name,
      description: category.description,
      createdAt: category.createdAt,
      updatedAt: category.updatedAt,
    );
  }

  static CategoryData createCategory(Category category) {
    return CategoryData(
      id: const Uuid().v4(),
      name: category.name,
      description: category.description,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  static CategoryCompanion updateCategory(Category category) {
    return CategoryCompanion(
      name: Value(category.name),
      description: Value(category.description),
      updatedAt: Value(DateTime.now()),
    );
  }
}
