import '../enums/enums.dart';

class Item {
  final String id;
  final double price;
  final int quantity;
  final int totalQuantity;
  final ItemStatus status;
  final String productId;
  final String requestId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Item({
    required this.id,
    required this.price,
    required this.quantity,
    required this.totalQuantity,
    required this.status,
    required this.productId,
    required this.requestId,
    required this.createdAt,
    required this.updatedAt,
  });
}

class NewItem {
  final int quantity;
  final String productId;

  const NewItem({
    required this.quantity,
    required this.productId,
  });
}
