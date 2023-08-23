import 'package:flutter_modular/flutter_modular.dart';
import 'package:statistics/statistics.dart';


import 'dashboard_page.dart';

class DashboardModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => const DashBoardPage(),
      children: [
        ModuleRoute('/statistics', module: StatisticsModule()),
        

      ],
      transition: TransitionType.upToDown,
    ),
  ];
}
