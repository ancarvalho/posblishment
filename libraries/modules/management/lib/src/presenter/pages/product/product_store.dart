import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';
import '../../../domain/entities/entities.dart' as e;
import '../../../domain/use_cases/create_product.dart';

class ProductStore extends StreamStore<Failure, e.Product> {
  final ICreateProduct _createProduct;

  ProductStore(this._createProduct) : super(e.Product.empty());

  // void loadMovieTrailer(String frequency) => execute(_getProduct( frequency));
  Future<void> create(e.Product product) async => executeEither(
        () => DartzEitherAdapter.adapter(_createProduct(product)),
      );
}
