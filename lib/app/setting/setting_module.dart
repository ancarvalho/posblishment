import 'package:core/core.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'setting_page.dart';

class SettingModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute(PagesRoutes.settings.route, child: (_, args) => const SettingPage()),
  ];
}
