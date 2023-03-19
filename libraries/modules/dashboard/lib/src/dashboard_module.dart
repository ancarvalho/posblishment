import 'package:dashboard/src/domain/use_cases/get_basic_statistics.dart';
import 'package:dashboard/src/domain/use_cases/get_most_sold_products.dart';
import 'package:dashboard/src/presenter/widgets/most_sold_products/most_sold_products_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/repositories/dashboard_repository.dart';
import 'infra/repositories/dashboard_repository_dummy_impl.dart';
import 'presenter/pages/dashboard/dashboard_page.dart';
import 'presenter/widgets/basic_statistics/basic_statistics_store.dart';

class DashboardModule extends Module {
  @override
  final List<Bind> binds = [
    // Bind.lazySingleton((i) => MoviePlayingStore(i()), export: true),
    Bind.lazySingleton((i) => MostSoldProductsStore(i()),export: true,),
    Bind.lazySingleton((i) => BasicStatsStore(i()),export: true,),

    Bind<DashboardRepository>((_) => DashboardRepositoryDummyImpl(),),

    Bind.lazySingleton<IGetMostSoldProducts>((i) => GetMostSoldProducts(i()),),
    Bind.lazySingleton<IGetBasicStats>((i) => GetBasicStats(i()),),
  ];

  @override
  final List<ModularRoute> routes = [
    // ChildRoute('/', child: (_, args) => const MoviePage()),
    ChildRoute('/home', child: (_, args) => const DashboardPage()),
  ];
}
