class ProductVariation {
  final String id;
  final String name;
  final double price;
  final bool priceVariation;
  final String productId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ProductVariation({
    required this.id,
    required this.name,
    required this.price,
    required this.priceVariation,
    required this.productId,
    required this.createdAt,
    required this.updatedAt,
  });
}
