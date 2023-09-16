import 'package:flutter_modular/flutter_modular.dart';
import 'package:statistics/src/infra/data_source/statistics_data_source.dart';

import 'domain/repositories/statistics_repository.dart';
import 'domain/use_cases/get_basic_statistics.dart';
import 'domain/use_cases/get_most_sold_products.dart';

import 'infra/repositories/statistics_repository_impl.dart';
import 'internal/statistics_data_source_impl.dart';
import 'presenter/pages/statistics/statistics_page.dart';
import 'presenter/widgets/basic_statistics/basic_statistics_store.dart';
import 'presenter/widgets/most_sold_products/most_sold_products_store.dart';

class StatisticsModule extends Module {
  @override
  final List<Bind> binds = [
    // Bind.lazySingleton((i) => MoviePlayingStore(i()), export: true),
    Bind.lazySingleton((i) => MostSoldProductsStore(i()), export: true),
    Bind.lazySingleton((i) => BasicStatsStore(i()), export: true),

    Bind<StatisticsRepository>((i) => StatisticsRepositoryImpl(i())),
    Bind<StatisticsDataSource>((i) => StatisticsDataSourceImpl(i())),

    Bind.lazySingleton<IGetMostSoldProducts>((i) => GetMostSoldProducts(i())),
    Bind.lazySingleton<IGetBasicStats>((i) => GetBasicStats(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const StatisticsPage())
  ];
}
