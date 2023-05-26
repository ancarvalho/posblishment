import 'dart:io';

// ignore: implementation_imports
import "package:core/src/enums/enums.dart";
// import "package:core/core.dart" as c;
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../tables/tables.dart';
import "../utils/utils.dart";

part 'sqlite.g.dart';

Future<File> get databaseFile async {
  // We use `path_provider` to find a suitable path to store our data in.

  final appDir = await getApplicationDocumentsDirectory();
  final dbPath = [appDir.path, 'posblishment.db'].join("/");
  return File(dbPath);
}

/// Obtains a database connection for running drift in a Dart VM.
DatabaseConnection connect() {
  return DatabaseConnection.delayed(
    Future(() async {
      return NativeDatabase.createBackgroundConnection(await databaseFile);
    }),
  );
}

@DriftDatabase(
  tables: [Product, Category, Bill, Item, Payment, ProductVariation, Request],
)
class AppDatabase extends _$AppDatabase
    // implements ProductRepository, CategoryRepository 
    {
  AppDatabase() : super(connect());

  AppDatabase.forTesting(DatabaseConnection connection) : super(connection);

  @override
  int get schemaVersion => 3;


}
