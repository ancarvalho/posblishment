import 'package:core/core.dart';

Map<ModulesRoutes, List<PagesRoutes>> genModulatedRoutes() {
  final routes = <ModulesRoutes, List<PagesRoutes>>{};

  for (final route in PagesRoutes.values) {
    if (route.standAlone != true) continue;

    if (!routes.containsKey(route.dependsOnModule)) {
      routes[route.dependsOnModule] = [route];
      continue;
    }
    routes[route.dependsOnModule]?.add(route);
  }

  return routes;
}
