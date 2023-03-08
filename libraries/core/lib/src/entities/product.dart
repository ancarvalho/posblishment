import 'package:objectbox/objectbox.dart';
import 'package:uuid/uuid.dart';
import 'category.dart';
import 'item.dart';
import 'product_variation.dart';

@Entity()
class Product {
  @Id()
  int objectboxID;

  @Unique()
  String? id;
  
  String name;
  String? description;
  double price;
  bool? preparable;

  final categoryID = ToOne<Category>();

  @Backlink()
  final items = ToMany<Item>;

  @Backlink()
  final variations = ToMany<ProductVariation>;

  @Property(type: PropertyType.date)
  DateTime? createdAt;
  @Property(type: PropertyType.date)
  DateTime? updatedAt;

  Product({
    this.objectboxID = 0,

    id,
    required this.name,
    this.description,
    required this.price,
    this.preparable = false,
    createdAt,
    updatedAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();
}
