import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/use_cases/get_all_products.dart';

class ProductStore extends StreamStore<Failure, List<Product>> {
  final GetAllProducts _getAllProducts;

  ProductStore(this._getAllProducts) : super([]);

  Future<void> getAllProducts() async => executeEither(
        () => DartzEitherAdapter.adapter(_getAllProducts()),
      );
}
