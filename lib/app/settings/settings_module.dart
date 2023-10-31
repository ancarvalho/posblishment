import 'package:core/core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:posblishment/app/settings/presenter/pages/customization/customization_page.dart';
import 'package:posblishment/app/settings/presenter/pages/establishment/establishment_page.dart';
import 'package:posblishment/app/settings/presenter/pages/printer/printer_page.dart';

import 'presenter/pages/settings/settings_page.dart';
import 'presenter/pages/settings/settings_store.dart';

class SettingModule extends Module {

 
    @override
  final List<Bind> binds = [

    // AsyncBind<SharedPreferences>((i) => SharedPreferences.getInstance()),
    Bind.lazySingleton<AbstractSettingsStore>((i) => SettingStore(), export: true)
  ];


  @override
  final List<ModularRoute> routes = [
    ChildRoute(PagesRoutes.settings.route, child: (_, args) => const SettingPage()),
    ChildRoute(PagesRoutes.customizeSettings.route, child: (_, args) => const CustomizationPage()),
    ChildRoute(PagesRoutes.establishmentSettings.route, child: (_, args) => const EstablishmentPage()),
    ChildRoute(PagesRoutes.printerSettings.route, child: (_, args) => const PrinterPage()),
  ];
}
