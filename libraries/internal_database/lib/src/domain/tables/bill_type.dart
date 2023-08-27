// ignore: implementation_imports
import "package:core/src/enums/enums.dart";
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../utils/enum_converter.dart';

class BillType extends Table {
  TextColumn get id => text().withDefault(Constant(const Uuid().v4()))();
  RealColumn get value => real().nullable()(); //
  TextColumn get name => text()();
  TextColumn get icon => text().nullable()();

  IntColumn get type =>
      integer().map(JsonAwareIntEnumConverter(BillTypes.values))();
  BoolColumn get defaultType => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(Constant(DateTime.now()))();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}
