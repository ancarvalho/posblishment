import 'product.dart';

class Category {
  final String? id;
  final String name;
  final String? description;
  final List<Product>? products;

  Category({
    this.id,
    required this.name,
    this.description,
    this.products,
  });

  factory Category.empty() {
    return Category(name: "");
  }
}
