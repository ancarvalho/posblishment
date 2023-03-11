import 'package:core/core.dart';
import 'package:drift/drift.dart';
import "package:uuid/uuid.dart";

enum ItemStatus {
  preparing,
  delivered,
  canceled,
}


class JsonAwareIntEnumConverter<E extends Enum> extends EnumIndexConverter<E> {
  JsonAwareIntEnumConverter(super.values);
}

class Item extends Table {
  TextColumn get id => text().withDefault(Constant(const Uuid().v4()))();
  RealColumn get price => real()();
  IntColumn get quantity => integer().withDefault(const Constant(1))();
  IntColumn get totalQuantity => integer().generatedAs(quantity)();
  IntColumn get status =>
      integer().map(JsonAwareIntEnumConverter(ItemStatus.values))();

  TextColumn get productId => text().references(Product, #id)();
  TextColumn get requestId => text().references(Request, #id)();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(Constant(DateTime.now()))();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(Constant(DateTime.now()))();
}
