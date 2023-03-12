import 'package:core/core.dart';
import 'package:drift/drift.dart';
import "package:uuid/uuid.dart";
// part 'product.g.dart';

class Product extends Table {
  TextColumn get id => text().withDefault(Constant(const Uuid().v4()))();
  TextColumn get name => text().unique()();
  TextColumn get description => text().nullable()();
  RealColumn get price => real()();
  BoolColumn get preparable => boolean().withDefault(const Constant(false))();

  TextColumn get categoryId => text().references(Category, #id)();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(Constant(DateTime.now()))();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(Constant(DateTime.now()))();
}
