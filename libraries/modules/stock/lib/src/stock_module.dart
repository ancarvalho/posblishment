import 'package:flutter_modular/flutter_modular.dart';

import 'domain/repositories/stock_control_repository.dart';
import 'domain/use_cases/decrease_product_stock.dart';
import 'domain/use_cases/get_products_stock.dart';
import 'domain/use_cases/increase_product_stock.dart';
import 'infra/repositories/stock_control_repository.dart';
import 'presenter/pages/products_stock/products_stock_page.dart';
import 'presenter/pages/products_stock/products_stock_store.dart';

class StockModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton(
      (i) => ProductsStockStore(i()),
      export: true,
    ),
    Bind<StockControlRepository>(
      (_) => StockControlRepositoryDummyImpl(),
    ),
    Bind.lazySingleton<IGetProductsStock>(
      (i) => GetProductsStock(i()),
    ),
    Bind.lazySingleton<IIncreaseProductStock>(
      (i) => IncreaseProductStock(i()),
    ),
    Bind.lazySingleton<IDecreaseProductStock>(
      (i) => DecreaseProductStock(i()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute("/", child: (_, args) => const ProductsStockPage(),)
  ];
}
