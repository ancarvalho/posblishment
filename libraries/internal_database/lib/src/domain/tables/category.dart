import 'package:drift/drift.dart';
import "package:uuid/uuid.dart";

class Category extends Table {
  TextColumn get id => text().withDefault(Constant(const Uuid().v4()))();
  TextColumn get name => text().withLength(min: 6).unique()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(Constant(DateTime.now()))();
 DateTimeColumn get updatedAt => dateTime().nullable()();
}
