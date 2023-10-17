import 'package:core/core.dart';
import 'package:drift/drift.dart';
import "package:uuid/uuid.dart";

import '../../../internal_database.dart';

class EstablishmentSettings extends Table {
  TextColumn get id => text().withDefault(Constant(const Uuid().v4()))();
  TextColumn get name => text().withLength(min: 6).unique()();
  IntColumn get establishmentType => integer().map(JsonAwareIntEnumConverter(EstablishmentTypes.values))();
  TextColumn get description => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get imageSrc => text().nullable()();
  BoolColumn get enableOrderSheet => boolean().withDefault(const Constant(false))();
  BoolColumn get enableWideViewMode => boolean().withDefault(const Constant(true))();
  
  BoolColumn get printerEnabled => boolean().withDefault(const Constant(true))();
  TextColumn get printerIp => text().nullable()();
  IntColumn get printerPort => integer().withDefault(const Constant(9100)).nullable()();

  IntColumn get theme => integer().map(JsonAwareIntEnumConverter(ThemesOptions.values))();
  
  DateTimeColumn get createdAt => dateTime().withDefault(Constant(DateTime.now()))();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}
