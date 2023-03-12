import 'package:core/core.dart';
import 'package:drift/drift.dart';
import "package:uuid/uuid.dart";

// part 'product_variation.g.dart';

class ProductVariation extends Table {
  TextColumn get id => text().withDefault(Constant(const Uuid().v4()))();
  TextColumn get name => text().unique()();
  RealColumn get price => real()();
  BoolColumn get priceVariation =>
      boolean().withDefault(const Constant(false))();

  TextColumn get productId => text().references(Product, #id)();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(Constant(DateTime.now()))();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(Constant(DateTime.now()))();
}
