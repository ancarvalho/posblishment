class Product {
  final String id;
  final int? code;
  final String name;
  final String? description;
  final double price;
  final bool preparable;
  final List<String>? variations;
  final String? categoryId;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const Product({
    required this.id,
    this.code,
    required this.name,
    this.description,
    this.price = 0.0,
    this.preparable = false,
    this.variations,
    this.categoryId,
    required this.createdAt,
    this.updatedAt,
  });

  // factory Product.empty() {
  //   return const Product(name: "");
  // }
}

class NewProduct {
  final int? code;
  final String name;
  final String? description;
  final double price;
  final bool preparable;
  final List<String>? variations;
  final String categoryId;

  const NewProduct({
    this.code,
    required this.name,
    this.description,
    required this.price,
    this.preparable = false,
    this.variations,
    required this.categoryId,
  });

  // factory Product.empty() {
  //   return const Product(name: "");
  // }
}

class UpdateProductModel {
  final String id;
  final int? code;
  final String name;
  final String? description;
  final double price;
  final bool preparable;
  final List<String>? variations;
  final String categoryId;

  const UpdateProductModel( {
    required this.id,
    this.code,
    required this.name,
    this.description,
    required this.price,
    this.preparable = false,
    this.variations,
    required this.categoryId,
  });

  // factory Product.empty() {
  //   return const Product(name: "");
  // }
}
