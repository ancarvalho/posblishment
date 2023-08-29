import 'dart:convert';

import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:posblishment/domain/enums/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/entities.dart';

class SettingStore extends StreamStore<Failure, Settings> {
  static SettingStore? _instance;

  factory SettingStore() => _instance ??= SettingStore._();

  SettingStore._() : super(Settings.empty()) {
    loadSettings();
  }

  Future<void> changeTheme({required ThemesOptions theme}) async {
    setLoading(true);
    final newState = state.copyWith(theme: theme);
    update(newState, force: true);
    // await saveSettings(newState);
    // update({...state, }, force: true);
    setLoading(false);
  }

  Future<void> loadSettings() async {
    setLoading(true);
    final settings = await getSettings();
    update(settings, force: true);
    setLoading(false);
  }

  final String _settings = 'settings';

  Future saveSettings(Settings settings) async {
    final shared = await SharedPreferences.getInstance();
    await shared.setString(_settings, jsonEncode(Settings.toJson(settings)));
    update(settings, force: true);
  }

  Future<Settings> init() async {
    final newSettings = Settings.empty();
    await saveSettings(newSettings);
    return newSettings;
  }

  Future<void> deleteSettings() async {
    final shared = await SharedPreferences.getInstance();
    await shared.clear();
  }

  Future<Settings> getSettings() async {
    final shared = await SharedPreferences.getInstance();
    // await deleteSettings();
    //  await init();
    final settings = shared.getString(_settings);
    return settings != null ? Settings.fromMap(jsonDecode(settings)) : await init();
  }
}
