import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../settings/settings_store.dart';

class PrinterController extends Disposable with ChangeNotifier {
  final printerIpTextController = TextEditingController();
  final printerPortTextController = TextEditingController();
  final settingsStore = Modular.get<SettingStore>();

  bool _enablePrinter = false;
  bool get enablePrinter => _enablePrinter;
  set enablePrinter(bool value) {
    _enablePrinter = value;
    notifyListeners();
  }

  void resetFields() {
    final printerSettings = settingsStore.state.printerSettings;
    if (printerSettings != null) {
      _enablePrinter = printerSettings.enablePrinter;
      printerIpTextController.text = printerSettings.printerIp ?? "";
      printerPortTextController.text = printerSettings.printerPort != null
          ? printerSettings.printerPort.toString()
          : "";
    }
  }

  void saveChanges() {
    final settings = settingsStore.state.copyWith(
      printerSettings: settingsStore.state.printerSettings?.copyWith(
        enablePrinter: enablePrinter,
        printerIp: printerIpTextController.text,
        printerPort: int.tryParse(printerPortTextController.text),
      ),
    );
    settingsStore.saveSettings(settings);
    debugPrint(settings.printerSettings!.printerIp);
  }

  @override
  void dispose() {
    printerIpTextController.dispose();
    printerPortTextController.dispose();
    super.dispose();
  }
}
