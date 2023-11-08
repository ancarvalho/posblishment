enum PagesRoutes {
  statistics(
    name: "Estatísticas",
    route: "/",
    dependsOnModule: ModulesRoutes.statistics,
  ),
  posPrinter(
    name: "Printer",
    route: "/printer_test",
    dependsOnModule: ModulesRoutes.posPrinter,
    standAlone: false,
  ),
  posPrinterConfig(
    name: "Printer",
    route: "/printer_config",
    dependsOnModule: ModulesRoutes.posPrinter,
    standAlone: false,
  ),
  cart(
    name: "Cart",
    route: "/cart/",
    dependsOnModule: ModulesRoutes.administration,
    standAlone: false,
  ),
  //Management

  // Stock Control
  stockControl(
    name: "Stock Control",
    route: "/",
    dependsOnModule: ModulesRoutes.stock,
    standAlone: false,
  ),

  bill(
    name: "Bill",
    route: "/bill/",
    dependsOnModule: ModulesRoutes.administration,
    standAlone: false,
  ),
  bills(
    name: "Contas",
    route: "/bills/",
    dependsOnModule: ModulesRoutes.administration,
  ),

  orderSheet(
    name: "Comanda Digital",
    route: "/order_sheet/",
    dependsOnModule: ModulesRoutes.administration,
  ),
  menu(
    name: "Menu",
    route: "/menu/",
    dependsOnModule: ModulesRoutes.administration,
  ),
  lastRequests(
    name: "Últimos Pedidos",
    route: "/last_requests/",
    dependsOnModule: ModulesRoutes.administration,
  ),
  lastPaidBills(
    name: "Ultimas Contas Pagas",
    route: "/last_paid_bills/",
    dependsOnModule: ModulesRoutes.administration,
  ),
  payment(
    name: "payment",
    route: "/payment/",
    dependsOnModule: ModulesRoutes.administration,
    standAlone: false,
  ),
  products(
    name: "Produtos",
    route: "/all_products/",
    dependsOnModule: ModulesRoutes.management,
  ),
  product(
    name: "Product",
    route: "/product/",
    dependsOnModule: ModulesRoutes.management,
    standAlone: false,
  ),
  categories(
    name: "Categorias",
    route: "/all_categories/",
    dependsOnModule: ModulesRoutes.management,
  ),
  category(
    name: "Category",
    route: "/category/",
    dependsOnModule: ModulesRoutes.management,
    standAlone: false,
  ),
  //Administration
  billType(
    name: "Bill Type",
    route: "/bill_type/",
    dependsOnModule: ModulesRoutes.management,
    standAlone: false,
  ),
  billTypes(
    name: "Tipos de Conta",
    route: "/bill_types/",
    dependsOnModule: ModulesRoutes.management,
  ),
  //Settings
  settings(
    name: "Configurações",
    route: "/",
    dependsOnModule: ModulesRoutes.settings,
  ),

  customizeSettings(
    name: "Customization",
    route: "/customize",
    dependsOnModule: ModulesRoutes.settings,
    standAlone: false,
  ),
  printerSettings(
    name: "Printer Settings",
    route: "/printer",
    dependsOnModule: ModulesRoutes.settings,
    standAlone: false,
  ),
  establishmentSettings(
    name: "Establishment Settings",
    route: "/establishment",
    dependsOnModule: ModulesRoutes.settings,
    standAlone: false,
  );

  const PagesRoutes({
    required this.name,
    required this.route,
    required this.dependsOnModule,
    this.standAlone = true,
  });

  final String name;
  final String route;
  final ModulesRoutes dependsOnModule;
  final bool standAlone;
}

enum ModulesRoutes {
  statistics(name: "Estatísticas", route: "/statistics"),
  administration(name: "Administração", route: "/administration"),
  management(name: "Gerenciamento", route: "/management"),
  stock(name: "Dashboard", route: "/stock"),
  settings(name: "Configurações", route: "/settings"),
  posPrinter(name: "Impressora", route: "/printer");

  const ModulesRoutes({required this.name, required this.route});

  final String name;
  final String route;
}
