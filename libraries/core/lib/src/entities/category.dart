import "package:core/core.dart";

class Category {
  final String? id;
  final String name;
  final String? description;
  final List<Product>? products;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Category({
    this.id,
    required this.name,
    this.description,
    this.products,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.empty() {
    return const Category(
      name: "",
      description: "" //TODO needed because not disposing text editor
    );
  }
}

class CategorizedProduct {
  Category category;
  Product product;
  CategorizedProduct({required this.category, required this.product});
}
