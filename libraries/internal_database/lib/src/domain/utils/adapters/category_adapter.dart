import 'package:drift/drift.dart';
import 'package:internal_database/src/domain/db/sqlite.dart';
import 'package:internal_database/src/domain/entities/category.dart';

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

  static CategoryData toCategoryData(Category category) {
    return CategoryData(
      id: category.id,
      name: category.name,
      description: category.description,
      createdAt: category.createdAt,
      updatedAt: category.updatedAt,
    );
  }

  static CategoryCompanion toCategoryCompanion(Category category) {
    return CategoryCompanion(
      name: Value(category.name),
      description: Value(category.description),
      updatedAt: Value(DateTime.now()),
    );
  }
}
