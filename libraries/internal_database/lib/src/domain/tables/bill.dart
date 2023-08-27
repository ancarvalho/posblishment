// ignore: implementation_imports
import "package:core/src/enums/enums.dart";
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../utils/enum_converter.dart';
import 'bill_type.dart';

class Bill extends Table {
  TextColumn get id => text().withDefault(Constant(const Uuid().v4()))();
  IntColumn get table => integer().nullable()();
  TextColumn get customerName => text().nullable()();

  IntColumn get status =>
      integer().map(JsonAwareIntEnumConverter(BillStatus.values))();

  TextColumn get billTypeID => text().references(BillType, #id)();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(Constant(DateTime.now()))();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}
