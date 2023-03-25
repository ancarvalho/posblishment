class ProductStock {
  final String name;
  final int totalAvailable;
  final String? variationName;
  

  ProductStock({
    required this.name,
    required this.totalAvailable,
    this.variationName,
  });
}
