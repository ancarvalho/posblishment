import 'package:administration/administration.dart';
import 'package:core/core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:internal_database/internal_database.dart';
import 'package:management/management.dart';
import 'package:posblishment/app/setting/setting_module.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:statistics/statistics.dart';
import 'package:stock/stock.dart';
import 'splash/splash_module.dart';

class AppModule extends Module {
  // Fixed
  @override
  List<Module> get imports => [
        StatisticsModule(),
        ManagementModule(),
        StockModule(),
        AdministrationModule(),
        SettingModule(),
      ];

  @override
  final List<Bind> binds = [
    Bind.lazySingleton<SharedPrefHelper>(
      (i) => SharedPrefHelper(preferences: i()),
    ),
    AsyncBind<SharedPreferences>((i) => SharedPreferences.getInstance()),
    Bind.lazySingleton<AppDatabase>(
      (i) => AppDatabase(),
    )
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: SplashModule()),
    ModuleRoute(ModulesRoutes.settings.route, module: SettingModule()),

    ModuleRoute(ModulesRoutes.statistics.route, module: StatisticsModule()),
    ModuleRoute(ModulesRoutes.administration.route, module: AdministrationModule()),
    ModuleRoute(ModulesRoutes.management.route, module: ManagementModule()),
    ModuleRoute(ModulesRoutes.stock.route, module: StockModule()),
  ];
}
