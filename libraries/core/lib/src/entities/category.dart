import 'package:core/src/entities/product.dart';
import 'package:objectbox/objectbox.dart';
import "package:uuid/uuid.dart";

@Entity()
class Category {
  @Id()
  int objectboxID;
  @Unique()
  String id;

  @Unique()
  String name;
  String description;

  @Backlink()
  final products = ToMany<Product>;

  @Property(type: PropertyType.date)
  DateTime? createdAt;
  @Property(type: PropertyType.date)
  DateTime? updatedAt;

  Category({
    this.objectboxID = 0,
    id,
    required this.name,
    required this.description,
    createdAt,
    updatedAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();
}
