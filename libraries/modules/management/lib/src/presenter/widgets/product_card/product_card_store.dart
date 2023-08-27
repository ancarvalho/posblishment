import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:management/src/domain/use_cases/delete_product.dart';

class ProductCardStore extends StreamStore<Failure, int> {
  final IDeleteProduct _deleteProduct;

  ProductCardStore(this._deleteProduct) : super(0);

  Future<void> deleteProduct(String id) async =>
      executeEither(() => DartzEitherAdapter.adapter(_deleteProduct(id)));
}
