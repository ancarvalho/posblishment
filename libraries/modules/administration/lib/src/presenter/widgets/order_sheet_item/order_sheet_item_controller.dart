import 'package:core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../stores/products/products_store.dart';

class OrderSheetItemController extends Disposable {
  final formKey = GlobalKey<FormState>();

  final itemCodeController = TextEditingController();
  final itemQuantityController = TextEditingController();

  final _productStore = Modular.get<ProductStore>();

  OrderSheetItemController();

  void resetFields() {
    itemCodeController.clear();
    itemQuantityController.clear();
  }

  void increaseQuantity() {
    final quantity = int.parse(itemQuantityController.text);
    itemQuantityController.text = (quantity + 1).toString();
  }

  void decreaseQuantity() {
    final quantity = int.parse(itemQuantityController.text);
    if (quantity > 1) {
      itemQuantityController.text = (quantity - 1).toString();
    }
  }

  String getProductByCode(int code) {
    return _productStore.state.firstWhere((element) => element.code == code).id;
  }

  NewItem? transformToItem() {
    final code = int.tryParse(itemCodeController.text);
    if (formKey.currentState!.validate() && code != null) {
      
      return NewItem(
        productId: getProductByCode(code),
        code: int.parse(itemCodeController.text),
        quantity: int.parse(itemQuantityController.text),
      );
    }
    return null;
  }

  @override
  void dispose() {
    itemCodeController.dispose();
    itemQuantityController.dispose();
  }
}
