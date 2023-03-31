class Product {
  final String id;
  final String name;
  final String? description;
  final double price;
  final bool preparable;
  final String categoryId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Product(
      {required this.id,
      required this.name,
      this.description,
      required this.price,
      required this.preparable,
      required this.categoryId,
      required this.createdAt,
      required this.updatedAt});
}
