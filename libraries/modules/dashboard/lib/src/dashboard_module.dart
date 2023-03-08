
import 'package:dashboard/src/presenter/pages/stats/stats_page.dart';
import 'package:flutter_modular/flutter_modular.dart';



class DashboardModule extends Module {
  @override
  final List<Bind> binds = [
    // Bind.lazySingleton((i) => MoviePlayingStore(i()), export: true),

  ];

  @override
  final List<ModularRoute> routes = [
    // ChildRoute('/', child: (_, args) => const MoviePage()),
    ChildRoute('/statistics', child: (_, args) => const StatisticsPage()),

  ];
}
