import "package:objectbox/objectbox.dart";
import 'package:uuid/uuid.dart';

import 'product.dart';

@Entity()
class ProductVariation {
  @Id()
  int objectboxID;
  @Unique()
  String id;

  @Unique()
  String name;
  bool? priceVariation;
  double? price;

  final productID = ToOne<Product>();

  @Property(type: PropertyType.date)
  DateTime? createdAt;
  @Property(type: PropertyType.date)
  DateTime? updatedAt;

  ProductVariation({
    this.objectboxID = 0,
    id,
    required this.name,
    this.priceVariation,
    this.price,
    createdAt,
    updatedAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();
}
