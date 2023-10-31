// import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
// import 'package:image_picker/image_picker.dart';

import '../settings/settings_store.dart';

class CustomizationController extends Disposable with ChangeNotifier {
  final settingsStore = Modular.get<SettingStore>();

  bool _orderSheetEnabled = false;
  bool get orderSheetEnabled => _orderSheetEnabled;
  set orderSheetEnabled(bool value) {
    _orderSheetEnabled = value;
    notifyListeners();
  }

  bool _enableWideMode = false;
  bool get enableWideMode => _enableWideMode;
  set enableWideMode(bool value) {
    _enableWideMode = value;
    notifyListeners();
  }

  ThemesOptions _theme = ThemesOptions.dark;
  ThemesOptions get theme => _theme;
  set theme(ThemesOptions value) {
    _theme = value;
    // settingsStore.changeTheme(theme: value);
    notifyListeners();
  }

  void resetFields() {
    final customization = settingsStore.state.customization;
    if (customization != null) {
      theme = customization.theme;
      orderSheetEnabled = customization.orderSheetEnabled;
      enableWideMode = customization.enableWideMode;
    }
  }

  void saveChanges() {
    final settings = settingsStore.state.copyWith(
      customization: settingsStore.state.customization?.copyWith(
        enableWideMode: enableWideMode,
        orderSheetEnabled: orderSheetEnabled,
        theme: theme,
      ),
    );
    settingsStore
      ..saveSettings(settings)
      ..changeTheme(theme: theme);
  }
}
