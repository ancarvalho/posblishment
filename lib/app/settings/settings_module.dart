import 'package:core/core.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'presenter/pages/settings/settings_page.dart';
import 'presenter/pages/settings/settings_store.dart';

class SettingModule extends Module {

 
    @override
  final List<Bind> binds = [

    // AsyncBind<SharedPreferences>((i) => SharedPreferences.getInstance()),
    Bind.singleton<SettingStore>((i) => SettingStore())
  ];


  @override
  final List<ModularRoute> routes = [
    ChildRoute(PagesRoutes.settings.route, child: (_, args) => const SettingPage()),
  ];
}
