import 'package:management/src/domain/use_cases/delete_product.dart';

class ProductsListController {
   final IDeleteProduct _deleteProduct;

  ProductsListController(this._deleteProduct);

  void deleteProduct(String id) {
    _deleteProduct(id);
  }
}
