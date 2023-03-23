class Product {
  final String id;
  final int? code;
  final String name;
  final String? description;
  final double unitValue;
  final Map<String, dynamic>? variations;

  Product({
    required this.id,
    this.code,
    required this.name,
    this.description,
    required this.unitValue,
    this.variations,
  });

  factory Product.empty() {
    return Product(
      id: "",
      name: "",
      unitValue: 0,
    );
  }
}
