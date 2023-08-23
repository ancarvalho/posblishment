import "package:core/core.dart";
import "package:flutter/widgets.dart";
import "package:flutter_modular/flutter_modular.dart";

class OrderSheetController extends Disposable {
  ValueNotifier<NewRequest> request =
      ValueNotifier<NewRequest>(NewRequest.empty());

  TextEditingController tableTextController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void insertItemONRequest(NewItem item) {
    request.value.items.add(item);
  }

  void removeItemONRequest(int index) {
    request.value.items.removeAt(index);
  }

  void increaseItemQuantity(int index) {
    request.value.items[index].quantity++;
  }

  void decreaseItemQuantity(int index) {
    request.value.items[index].quantity--;
  }

  void clearRequest() {
    request.value = NewRequest.empty();
  }

  @override
  void dispose() {
    request.dispose();
  }
}
