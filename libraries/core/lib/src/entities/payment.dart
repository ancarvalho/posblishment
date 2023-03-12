import 'package:core/core.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'enum_converter.dart';

// part 'payment.g.dart';

enum PaymentType {
  creditCard,
  debitCard,
  cash,
  pix,
}


class Payment extends Table {
  TextColumn get id => text().withDefault(Constant(const Uuid().v4()))();
  RealColumn get value => real()();

  IntColumn get paymentType =>
      integer().map(JsonAwareIntEnumConverter(PaymentType.values))();
  TextColumn get billId => text().references(Bill, #id)();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(Constant(DateTime.now()))();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(Constant(DateTime.now()))();
}
