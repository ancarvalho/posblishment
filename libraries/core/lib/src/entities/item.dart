import '../enums/enums.dart';

class Item {
  final String id;
  final int? code;
  final String name;
  final double price;
  final int quantity;
  final int totalQuantity;
  final ItemStatus status;
  final String productId;
  final String requestId;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Item({
    this.code,
    required this.name,
    required this.id,
    required this.price,
    required this.quantity,
    required this.totalQuantity,
    required this.status,
    required this.productId,
    required this.requestId,
    required this.createdAt,
    this.updatedAt,
  });
}

class NewItem {
  final String productId;
  final int? code;
  int quantity;

  NewItem({
    required this.productId,
    this.code,
    required this.quantity,
  });

  factory NewItem.empty() => NewItem(quantity: 1, productId: "");
}

class MinimizedItem {
  final String name;
  final int quantity;

  MinimizedItem({
    required this.name,
    required this.quantity,
  });
}
