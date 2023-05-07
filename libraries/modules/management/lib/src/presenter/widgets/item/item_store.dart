import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:management/src/domain/use_cases/delete_product.dart';

class ItemStore extends StreamStore<Failure, int> {
  final IDeleteProduct _deleteProduct;

  ItemStore(this._deleteProduct) : super(0);

  Future<void> deleteProduct(String id) async =>
      executeEither(() => DartzEitherAdapter.adapter(_deleteProduct(id)));
}
