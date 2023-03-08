import 'package:objectbox/objectbox.dart';
import 'package:uuid/uuid.dart';

import 'orders.dart';
import 'payment.dart';

enum BillStatus {
  open,
  closed,
  paid,
  paidWithoutCommission,
  canceled,
}

// TODO define bill service taxes and extra, like delivery
enum BillType {
  takeout,
  saloon,
  delivery,
}

// three fields predefined, tax of service(shipping, waiter fee), (discount), (no tax) -> personalized tax (percentage or fixed)
enum BillServiceType {
  fixedBillTax, // a fixed percentage of bill total value
  fixedTax, // fixed value
  billDiscount, // a fixed percentage of bill total value
  discount, // fixed value
  dynamicTax,
  dynamicBillTax,
}

@Entity()
class Bill {
  @Id()
  int objectboxID;
  @Unique()
  String id;

  @Unique()
  int? table;
  String? customerName;
  BillStatus? status;

  @Property(type: PropertyType.date)
  DateTime? createdAt;
  @Property(type: PropertyType.date)
  DateTime? updatedAt;

  @Backlink()
  final orders = ToMany<Orders>;

  @Backlink()
  final payments = ToMany<Payment>;

  Bill({
    this.objectboxID = 0,
    id,
    this.table,
    this.customerName,
    BillStatus this.status = BillStatus.open,
    createdAt,
    updatedAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();
}
