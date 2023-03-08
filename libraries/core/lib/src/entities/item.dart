import 'package:objectbox/objectbox.dart';
import 'package:uuid/uuid.dart';

import 'orders.dart';
import 'product.dart';

enum ItemStatus {
  preparing,
  delivered,
  canceled,
}

@Entity()
class Item {
  @Id()
  int objectboxID;

  @Unique()
  String id;

  double price;
  int quantity;
  int totalQuantity;
  ItemStatus status;

  final productId = ToOne<Product>();
  final orderId = ToOne<Orders>();

  @Property(type: PropertyType.date)
  DateTime? createdAt;
  @Property(type: PropertyType.date)
  DateTime? updatedAt;

  Item({
    this.objectboxID = 0,
    id,
    required this.price,
    required this.totalQuantity,
    required this.quantity,
    this.status = ItemStatus.preparing,
    createdAt,
    updatedAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();
}
