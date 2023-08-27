import 'package:drift/drift.dart';
import "package:uuid/uuid.dart";

import 'tables.dart';

class Product extends Table {
  TextColumn get id => text().withDefault(Constant(const Uuid().v4()))();
  TextColumn get name => text().withLength(min: 6).unique()();
  TextColumn get description => text().nullable()();
  RealColumn get price => real()();
  IntColumn get code => integer().nullable().unique()();
  BoolColumn get preparable => boolean().withDefault(const Constant(false))();

  TextColumn get categoryId => text().references(Category, #id)();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(Constant(DateTime.now()))();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}
