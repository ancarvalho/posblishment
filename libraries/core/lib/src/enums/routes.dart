enum PagesRoutes {
  statistics(
    name: "Statistics",
    route: "/",
    dependsOnModule: ModulesRoutes.statistics,
  ),
  cart(
    name: "Cart",
    route: "/cart/",
    dependsOnModule: ModulesRoutes.administration,
  ),
  //Management
  products(
    name: "Products",
    route: "/all_products/",
    dependsOnModule: ModulesRoutes.management,
  ),
  product(
    name: "Product",
    route: "/product/",
    dependsOnModule: ModulesRoutes.management,
  ),
  categories(
    name: "Categories",
    route: "/all_categories/",
    dependsOnModule: ModulesRoutes.management,
  ),
  category(
    name: "Category",
    route: "/category/",
    dependsOnModule: ModulesRoutes.management,
  ),
  // Stock Control
  stockControl(
    name: "Stock Control",
    route: "/",
    dependsOnModule: ModulesRoutes.stock,
  ),
  //Administration
  billType(
    name: "Bill Type",
    route: "/bill_type/",
    dependsOnModule: ModulesRoutes.administration,
  ),
  billTypes(
    name: "Bill Types",
    route: "/bill_types/",
    dependsOnModule: ModulesRoutes.administration,
  ),
  bill(
    name: "Bill",
    route: "/bill/",
    dependsOnModule: ModulesRoutes.administration,
    standAlone: false,
  ),
  bills(
    name: "Bills",
    route: "/bills/",
    dependsOnModule: ModulesRoutes.administration,
  ),
  lastPaidBills(
    name: "Last Paid Bills",
    route: "/last_paid_bills/",
    dependsOnModule: ModulesRoutes.administration,
  ),
  orderSheet(
    name: "Order Sheet",
    route: "/order_sheet/",
    dependsOnModule: ModulesRoutes.administration,
  ),
  menu(
    name: "menu",
    route: "/menu/",
    dependsOnModule: ModulesRoutes.administration,
  ),
  lastRequests(
    name: "lastRequests",
    route: "/last_requests/",
    dependsOnModule: ModulesRoutes.administration,
  ),
  payment(
    name: "payment",
    route: "/payment/",
    dependsOnModule: ModulesRoutes.administration,
    standAlone: false,
  ),
  //Settings
  settings(
    name: "Settings",
    route: "/",
    dependsOnModule: ModulesRoutes.settings,
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
  statistics(name: "Dashboard", route: "/statistics"),
  administration(name: "Dashboard", route: "/administration"),
  management(name: "Dashboard", route: "/management"),
  stock(name: "Dashboard", route: "/stock"),
  settings(name: "Settings", route: "/settings");

  const ModulesRoutes({required this.name, required this.route});

  final String name;
  final String route;
}
