import 'package:drift/drift.dart';
import "package:uuid/uuid.dart";
import 'tables.dart';


class ProductVariation extends Table {
  TextColumn get id => text().withDefault(Constant(const Uuid().v4()))();
  TextColumn get name => text().withLength(min: 5).unique()();
  RealColumn get price => real()();
  BoolColumn get priceVariation => boolean().withDefault(const Constant(false))();
  TextColumn get productId => text().references(Product, #id)();

  DateTimeColumn get createdAt => dateTime().withDefault(Constant(DateTime.now()))();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}
