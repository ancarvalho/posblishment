class Product {
  final String? id;
  final int? code;
  final String name;
  final String? description;
  final double price;
  final bool preparable;
  final List<String>? variations;
  final String? categoryId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  const Product({
    this.id,
    this.code,
    required this.name,
    this.description,
    this.price = 0.0,
    this.preparable = false,
    this.variations,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.empty() {
    return const Product(name: "");
  }
}
