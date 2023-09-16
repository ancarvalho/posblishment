import 'dart:io';

// ignore: implementation_imports
import "package:core/src/enums/enums.dart";
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
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

Future<void>  backupFile(AppDatabase database) async {
  // We use `path_provider` to find a suitable path to store our data in.

  // if (Platform.isAndroid) {
  final appDir = await getExternalStorageDirectory();
  if (appDir == null) throw Error();
  await appDir.create(recursive: true);

  final dbPath = [appDir.path, 'backup.db'].join("/");

  final file = File(dbPath);
  if (file.existsSync()) await file.delete();

  await database.customStatement('VACUUM INTO ?', [file.path]);
}

Future<void>  restoreFile() async {
  // We use `path_provider` to find a suitable path to store our data in.
  final appDir = await getExternalStorageDirectory();
  if (appDir == null || !appDir.existsSync()) return;

  final dbPath = [appDir.path, 'backup.db'].join("/");
  final backupDb = sqlite3.open(dbPath);

  // Vacuum it into a temporary location first to make sure it's working.
  final tempPath = await getTemporaryDirectory();
  final tempDb = [tempPath.path, 'import.db'].join("/");
  backupDb
    ..execute('VACUUM INTO ?', [tempDb])
    ..dispose();

  // Then replace the existing database file with it.
  final tempDbFile = File(tempDb);
  await tempDbFile.copy((await databaseFile).path);
  await tempDbFile.delete();
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
    tables: [Product, Category, Bill, Item, Payment, Request, BillType])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(connect());

  AppDatabase.forTesting(DatabaseConnection connection) : super(connection);

  @override
  int get schemaVersion => 3;
}
