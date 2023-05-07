import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/use_cases/create_product.dart';
import '../../../domain/use_cases/update_product.dart';

class ProductStore extends StreamStore<Failure, int> {
  final ICreateProduct _createProduct;
  final IUpdateProduct _updateProduct;

  ProductStore(
    this._createProduct,
    this._updateProduct,
  ) : super(0);

  Future<void> createProduct(Product product) async => executeEither(
        () => DartzEitherAdapter.adapter(_createProduct(product)),
      );

  Future<void> updateProduct(Product product) async => executeEither(
        () => DartzEitherAdapter.adapter(_updateProduct(product)),
      );
}
