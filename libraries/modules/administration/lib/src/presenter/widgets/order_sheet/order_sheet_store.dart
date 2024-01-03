import "package:core/core.dart";
import "package:flutter/widgets.dart";
import "package:flutter_triple/flutter_triple.dart";

import '../../../domain/errors/administration_errors.dart';
import '../../../domain/utils/utils.dart';
import '../../stores/request/make_request_store.dart';

class OrderSheetStore extends NotifierStore<Failure, NewRequest> {
  OrderSheetStore(this._makeRequestStore) : super(NewRequest.empty());
  NewRequest get requests => state;

  final MakeRequestStore _makeRequestStore;

  final tableTextController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void insertItemONRequest(NewItem? item) {
    if (item != null) {
      setLoading(true);
      state.items.add(item);
      return setLoading(false);
    }
    return setError(
      AdministrationError(
        StackTrace.current,
        "AdministrationModule-orderSheet-insertItemONRequest",
        "",
        "Item does not exist in menu",
      ),
    );
  }

  Future<void> saveChanges(FocusNode focusNode) async {
    try {
      if (formKey.currentState!.validate() &&
          int.tryParse(tableTextController.text) != null &&
          state.items.isNotEmpty) {
        await createOrUpdateBill();
        clearRequest();
        return focusNode.requestFocus();
      }
    } catch (e, s) {
      setError(
        AdministrationError(
          s,
          "AdministrationModule-orderSheetSaveChanges",
          e,
          "Error Validating",
        ),
      );
    }
  }

  Future<void> createOrUpdateBill() async {
    await _makeRequestStore.createOrUpdateBill(
      NewBill(table: int.tryParse(tableTextController.text)),
      state,
    );
  }

  void removeItemInRequests(int index) {
    setLoading(true);
    state.items.removeAt(index);
    setLoading(false);
  }

  void increaseOrDecreaseQuantity(IncreaseORDecrease e, int index) {
    switch (e) {
      case IncreaseORDecrease.increase:
        increaseItemQuantity(index);
        break;
      case IncreaseORDecrease.decrease:
        decreaseItemQuantity(index);
        break;
    }
  }

  void increaseItemQuantity(int index) {
    setLoading(true);
    state.items[index].quantity++;
    setLoading(false);
  }

  void decreaseItemQuantity(int index) {
    setLoading(true);
    if (state.items[index].quantity > 1) state.items[index].quantity--;
    setLoading(false);
  }

  void clearRequest() {
    setLoading(true);
    update(NewRequest.empty());
    tableTextController.text = "";
    setLoading(false);
  }
}
