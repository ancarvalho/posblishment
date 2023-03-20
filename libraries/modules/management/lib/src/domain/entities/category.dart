import 'product.dart';

class Category {
  final String id;
  final String name;
  final String? description;
  final List<Product>? products;

  Category({
    required this.id,
    required this.name,
    required this.description,
    this.products,
  });
}
