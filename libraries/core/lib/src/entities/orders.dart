import 'package:core/src/entities/bill.dart';
import 'package:core/src/entities/item.dart';
import 'package:objectbox/objectbox.dart';
import 'package:uuid/uuid.dart';

@Entity()
class Orders {
  @Id()
  int objectboxID;
  @Unique()
  String id;

  String? observation;

  @Property(type: PropertyType.date)
  DateTime? createdAt;
  @Property(type: PropertyType.date)
  DateTime? updatedAt;

  @Backlink()
  final items = ToMany<Item>;
  final bill = ToOne<Bill>();

  Orders({
    this.objectboxID = 0,
    id,
    this.observation,
    createdAt,
    updatedAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();
}
