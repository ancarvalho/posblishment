import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/product_stock.dart';
import '../../../domain/use_cases/get_products_stock.dart';

class ProductsStockStore extends StreamStore<Failure, List<ProductStock>> {
  final IGetProductsStock _getProductsStock;

  ProductsStockStore(this._getProductsStock) : super([]);

  Future<void> load() async => executeEither(
      () => DartzEitherAdapter.adapter(_getProductsStock()),);
}
