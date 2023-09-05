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

  void resetFields(NewItem item) {
    itemCodeController.text = item.code != null ? item.code.toString() : "";
    itemQuantityController.text = item.quantity.toString();
  }

  void clearFields() {
    itemCodeController.clear();
    itemQuantityController.text = "1";
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

  String? getProductByCode(int code) {
    final index =
        _productStore.state.indexWhere((element) => element.code == code);
    if (index != -1) {
      return _productStore.state.elementAt(index).id;
    }
    return null;
  }

  NewItem? transformToItem() {
    final code = int.tryParse(itemCodeController.text);
    final productID = code != null ? getProductByCode(code) : null;
    if (formKey.currentState!.validate() && code != null && productID != null) {
      return NewItem(
        productId: productID,
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
