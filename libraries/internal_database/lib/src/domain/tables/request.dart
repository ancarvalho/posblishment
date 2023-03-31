import 'package:drift/drift.dart';
import "package:uuid/uuid.dart";
import 'tables.dart';
// part 'request.g.dart';

class Request extends Table {
  TextColumn get id => text().withDefault(Constant(const Uuid().v4()))();
  TextColumn get observation => text().nullable()();
  TextColumn get billId => text().references(Bill, #id)();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(Constant(DateTime.now()))();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(Constant(DateTime.now()))();
}
