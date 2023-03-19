
import 'package:flutter_modular/flutter_modular.dart';


class DashboardModule extends Module {
  @override
  final List<Bind> binds = [

    // Bind.lazySingleton((i) => BasicStatsStore(i()),export: true,),

    // Bind<DashboardRepository>((_) => DashboardRepositoryDummyImpl(),),


    // Bind.lazySingleton<IGetBasicStats>((i) => GetBasicStats(i()),),
  ];

  @override
  final List<ModularRoute> routes = [
    // ChildRoute('/home', child: (_, args) => const DashboardPage()),
  ];
}
