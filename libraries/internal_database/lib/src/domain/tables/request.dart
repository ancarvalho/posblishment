// ignore: implementation_imports
import 'package:core/src/enums/enums.dart';
import 'package:drift/drift.dart';
import "package:uuid/uuid.dart";

import '../utils/enum_converter.dart';
import 'tables.dart';

class Request extends Table {
  TextColumn get id => text().withDefault(Constant(const Uuid().v4()))();
  TextColumn get observation => text().nullable()();
  TextColumn get billId => text().references(Bill, #id)();
  IntColumn get status =>
      integer().map(JsonAwareIntEnumConverter(RequestStatus.values))();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(Constant(DateTime.now()))();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}
