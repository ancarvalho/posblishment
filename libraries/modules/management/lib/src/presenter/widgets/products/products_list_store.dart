import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';
import '../../../domain/use_cases/list_all_products.dart';

class ProductListStore extends StreamStore<Failure, List<Product>> {
  final IListAllProducts _listAllProducts;

  ProductListStore(this._listAllProducts) : super([]);

  Future<void> list() async => executeEither(
        () => DartzEitherAdapter.adapter(_listAllProducts()),
      );
}
