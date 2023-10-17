// import 'package:flutter_triple/flutter_triple.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:internal_database/internal_database.dart';
import 'package:posblishment/domain/entities/entities.dart';

class SettingsController extends Disposable with ChangeNotifier {
  SettingsController();

  final establishmentNameTextController = TextEditingController();

  final printerIpTextController = TextEditingController();
  final printerPortTextController = TextEditingController();
  bool _enablePrinter = false;

  bool get enablePrinter => _enablePrinter;
  set enablePrinter(bool value) {
    _enablePrinter = value;
    notifyListeners();
  }

  bool _orderSheetEnabled = false;
  bool get orderSheetEnabled => _orderSheetEnabled;
  set orderSheetEnabled(bool value) {
    _orderSheetEnabled = value;
    notifyListeners();
  }

  EstablishmentTypes establishmentType = EstablishmentTypes.restaurant;
  ThemesOptions theme = ThemesOptions.dark;

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

  void resetFields(Settings? settings) {
    if (settings != null) {
      establishmentNameTextController.text = settings.establishment?.name ?? "";
      orderSheetEnabled = settings.orderSheetEnabled;

      enablePrinter = settings.enablePrinter;
      printerIpTextController.text = settings.printerIp ?? "";
      printerPortTextController.text =
          settings.printerPort != null ? settings.printerPort.toString() : "";

      theme = settings.theme;
      establishmentType = settings.establishment?.establishmentType ??
          EstablishmentTypes.restaurant;
    }
  }

  Settings updateEstablishmentName(Settings settings) {
    return settings.copyWith(
      establishment: settings.establishment
          ?.copyWith(name: establishmentNameTextController.text),
    );
  }

  Settings updateEstablishmentType(Settings settings) {
    return settings.copyWith(
      establishment: settings.establishment
          ?.copyWith(establishmentType: establishmentType),
    );
  }

  Settings updateOrderSheetEnabled(Settings settings) {
    return settings.copyWith(orderSheetEnabled: orderSheetEnabled);
  }

  Settings updateSettings(Settings settings) {
    return settings.copyWith(
      orderSheetEnabled: orderSheetEnabled,
      theme: theme,
      establishment: settings.establishment?.copyWith(
        name: establishmentNameTextController.text,
        establishmentType: establishmentType,
      ),
      enablePrinter: enablePrinter,
      printerIp: printerIpTextController.text,
      printerPort: int.tryParse(printerIpTextController.text) ?? 9100,
    );
  }

  @override
  void dispose() {
    super.dispose();
    establishmentNameTextController.dispose();
    printerIpTextController.dispose();
    printerPortTextController.dispose();
  }
}
