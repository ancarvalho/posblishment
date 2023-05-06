import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:management/src/domain/use_cases/list_all_categories.dart';

import '../../../domain/use_cases/create_product.dart';
import '../../../domain/use_cases/update_product.dart';

class ProductStore extends StreamStore<Failure, List<Category> > {
  final IListAllCategories _listAllCategories;
  final ICreateProduct _createProduct;
  final IUpdateProduct _updateProduct;

  ProductStore(
    this._listAllCategories,
    this._createProduct,
    this._updateProduct,
  ) : super([]);

  Future<void> load() async => executeEither(
        () => DartzEitherAdapter.adapter(_listAllCategories()),
      );

  // Future<void> saveChanges(Product product) async {
  //   try {
  //     if (product.id != null) {
  //       await updateProduct(product);
  //     } else {
  //       await createProduct(product);
  //     }
  //   } on Failure catch (e) {
  //     setError(e);
  //   }
  // }

  Future<void> createProduct(Product product) async  => executeEither(
        () => DartzEitherAdapter.adapter(_createProduct(product) as Future<Either<Failure, List<Category>>>),
      );
    
  

  Future<void> updateProduct(Product product) async => executeEither(
        () =>  DartzEitherAdapter.adapter(_updateProduct(product) as Future<Either<Failure, List<Category>>>),
      );
}
