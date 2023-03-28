import 'package:core/core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:management/management.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:statistics/statistics.dart';
import 'package:stock/stock.dart';

import 'dashboard/dashboard_module.dart';
import 'splash/splash_module.dart';

class AppModule extends Module {

  // Fixed
  @override
  List<Module> get imports => [StatisticsModule(), ManagementModule(), StockModule()];

  @override
  final List<Bind> binds = [
  

    Bind.lazySingleton<SharedPrefHelper>((i) => SharedPrefHelper(preferences: i())),
    AsyncBind<SharedPreferences>((i) => SharedPreferences.getInstance()),

  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: SplashModule()),
    ModuleRoute('/dashboard', module: DashboardModule()),
    // ModuleRoute('/statistics', module: StatisticsModule()),
    // ModuleRoute('/management', module: ManagementModule()),
  ];
}
