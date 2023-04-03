import 'package:internal_database/src/domain/entities/entities.dart';

class Category {
  final String id;
  final String name;
  final String? description;
  final List<Product>? products;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Category({
    required this.id,
    required this.name,
    this.description,
    this.products,
    required this.createdAt,
    required this.updatedAt,
  });
}

class CategorizedProduct {
  Category category;
  Product product;
  CategorizedProduct({required this.category, required this.product});
}
