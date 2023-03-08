import 'package:core/core.dart';
import 'package:dashboard/dashboard.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'splash/splash_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [];

  @override
  final List<Bind> binds = [
  

    Bind.lazySingleton<SharedPrefHelper>((i) => SharedPrefHelper(preferences: i())),
    AsyncBind<SharedPreferences>((i) => SharedPreferences.getInstance()),

  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: SplashModule()),
    ModuleRoute('/dashboard', module: DashboardModule()),
  ];
}
