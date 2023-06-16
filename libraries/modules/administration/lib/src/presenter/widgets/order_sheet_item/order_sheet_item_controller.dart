import 'package:flutter/widgets.dart';
import 'package:modular_core/modular_core.dart';

class OrderSheetItemController extends Disposable {
  final formKey = GlobalKey<FormState>();

  final itemCodeController = TextEditingController();
  final itemQuantityController = TextEditingController();

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

  @override
  void dispose() {
    itemCodeController.dispose();
    itemQuantityController.dispose();
  }
}
