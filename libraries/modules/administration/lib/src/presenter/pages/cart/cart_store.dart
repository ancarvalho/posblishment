import "package:core/core.dart";
import "package:flutter/widgets.dart";
import "package:flutter_triple/flutter_triple.dart";

import '../../../domain/errors/administration_errors.dart';
import '../../../domain/utils/utils.dart';
import '../../stores/request/make_request_store.dart';

class CartStore extends NotifierStore<Failure, Map<String, NewItem>> {
  CartStore(this._makeRequestStore) : super({});
  List<NewItem> get items => state.values.toList();
  int get count => state.values.fold<int>(
      0, (previousValue, element) => element.quantity + previousValue,);

  final MakeRequestStore _makeRequestStore;

  final tableTextController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void insertProductOnItems(Product product, String? variation) {
    final productKey = variation != null ? "${product.id}-$variation" : product.id;

    // if (product != null) {
    setLoading(true);
    // TODO change After to add Variation
    if (state.containsKey(productKey)) {
      increaseItemQuantity(productKey);
    } else {
      state[productKey] =
          NewItem(productId: product.id, quantity: 1, name: product.name, variation: variation);
    }

    return setLoading(false);
    // }
    // return setError(
    //   AdministrationError(
    //     StackTrace.current,
    //     "AdministrationModule-orderSheet-insertItemONRequest",
    //     "",
    //     "Item does not exist in menu",
    //   ),
    // );
  }

  Future<void> saveChanges() async {
    if (formKey.currentState!.validate() &&
        int.tryParse(tableTextController.text) != null &&
        state.isNotEmpty) {
      return createOrUpdateBill();

    }
    setError(
      AdministrationError(
        StackTrace.current,
        "AdministrationModule-CartStore-SaveChanges",
        "",
        "Error Validating",
      ),
    );
  }

  Future<void> createOrUpdateBill() async {
    await _makeRequestStore.createOrUpdateBill(
      NewBill(table: int.tryParse(tableTextController.text)),
      NewRequest(items: items),
    );
    clearRequest();
  }

  void removeItemInRequests(String index) {
    setLoading(true);
    state.remove(index);
    setLoading(false);
  }

  void increaseOrDecreaseQuantity(IncreaseORDecrease e, String index) {
    switch (e) {
      case IncreaseORDecrease.increase:
        increaseItemQuantity(index);
        break;
      case IncreaseORDecrease.decrease:
        decreaseItemQuantity(index);
        break;
    }
  }

  void increaseItemQuantity(String index) {
    setLoading(true);
    if (state.isNotEmpty && state.containsKey(index)) {
      state[index]?.quantity++;
    }
    setLoading(false);
  }

  void decreaseItemQuantity(String index) {
    setLoading(true);
    if (state.isNotEmpty && state.containsKey(index)) {
      if (state[index]!.quantity > 1) state[index]?.quantity--;
    }
    setLoading(false);
  }

  void clearRequest() {
    setLoading(true);
    update({});
    tableTextController.text = "";
    setLoading(false);
  }
}
