import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'enum_converter.dart';
// part 'bill.g.dart';

enum BillStatus {
  open,
  closed,
  paid,
  paidWithoutCommission,
  canceled,
}

// // TODO define bill service taxes and extra, like delivery
// enum BillType {
//   takeout,
//   saloon,
//   delivery,
// }

// // three fields predefined, tax of service(shipping, waiter fee), (discount), (no tax) -> personalized tax (percentage or fixed)
// enum BillServiceType {
//   fixedBillTax, // a fixed percentage of bill total value
//   fixedTax, // fixed value
//   billDiscount, // a fixed percentage of bill total value
//   discount, // fixed value
//   dynamicTax,
//   dynamicBillTax,
// }

class Bill extends Table {
  TextColumn get id => text().withDefault(Constant(const Uuid().v4()))();
  IntColumn get table => integer().nullable()();
  TextColumn get customerName => text().nullable()();

  IntColumn get status =>
      integer().map(JsonAwareIntEnumConverter(BillStatus.values))();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(Constant(DateTime.now()))();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(Constant(DateTime.now()))();
}
