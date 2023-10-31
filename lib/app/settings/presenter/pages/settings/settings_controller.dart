// import 'package:flutter_triple/flutter_triple.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:internal_database/internal_database.dart';

class SettingsController extends Disposable with ChangeNotifier {
  SettingsController();


  // don`t think that modular let inject dependencies after start-up
  Future<void> restoreDatabase() async {
    await restoreFile();
  }

  Future<void> deleteCurrentDb() async {
    await deleteDb();
  }

  Future<void> backupDatabase() async {
    final database = Modular.get<AppDatabase>();
    await backupFile(database);
  }
}
