import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:management/src/domain/errors/management_failures.dart';

import '../../../domain/use_cases/create_product.dart';
import '../../../domain/use_cases/update_product.dart';

class ProductStore extends StreamStore<Failure, int> {
  final ICreateProduct _createProduct;
  final IUpdateProduct _updateProduct;

  ProductStore(
    this._createProduct,
    this._updateProduct,
  ) : super(0);

  Future<void> createProduct(NewProduct product) async {
    if (!isLoading) {
      return executeEither(
          () => DartzEitherAdapter.adapter(_createProduct(product)));
    }
    ManagementError(StackTrace.current, "AdministrationModule-createProduct",
        "", "Currently Executing Action");
  }

  Future<void> updateProduct(UpdateProductModel product) async {
    if (!isLoading) {
      return executeEither(
          () => DartzEitherAdapter.adapter(_updateProduct(product)));
    }
    ManagementError(StackTrace.current, "AdministrationModule-updateProduct",
        "", "Currently Executing Action");
  }
}
