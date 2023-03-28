import 'package:flutter_modular/flutter_modular.dart';
import 'package:management/management.dart';
import 'package:statistics/statistics.dart';
import 'package:stock/stock.dart';

import 'dashboard_page.dart';

class DashboardModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => const DashBoardPage(),
      children: [
        ModuleRoute('/statistics', module: StatisticsModule()),
        ModuleRoute('/management', module: ManagementModule()),
        ModuleRoute('/stock', module: StockModule()),

      ],
      transition: TransitionType.upToDown,
    ),
  ];
}
