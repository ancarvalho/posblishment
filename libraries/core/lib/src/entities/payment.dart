import 'package:core/src/entities/bill.dart';
import 'package:objectbox/objectbox.dart';
import 'package:uuid/uuid.dart';

enum PaymentType {
  creditCard,
  debitCard,
  cash,
  pix,
}

@Entity()
class Payment {
  @Id()
  int objectboxID;
  @Unique()
  String id;

  double value;
  PaymentType paymentType;

  @Property(type: PropertyType.date)
  DateTime? createdAt;
  @Property(type: PropertyType.date)
  DateTime? updatedAt;

  final billID = ToOne<Bill>();

  Payment({
    this.objectboxID = 0,
    id,
    required this.value,
    this.paymentType = PaymentType.creditCard,
    createdAt,
    updatedAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();
}
