import "package:core/core.dart";
import 'package:dartz/dartz.dart';
import "package:flutter/widgets.dart";
import "package:flutter_modular/flutter_modular.dart";

import "../../../domain/errors/administration_errors.dart";
import "../../../domain/utils/utils.dart";
import "order_sheet_store.dart";

class OrderSheetController extends Disposable with ChangeNotifier {
  NewRequest _request = NewRequest.empty();

  NewRequest get request => _request;

  final OrderSheetStore _orderSheetStore = Modular.get<OrderSheetStore>();

  final tableTextController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void insertItemONRequest(NewItem? item) {
    if (item != null) _request.items.add(item);
    notifyListeners();
  }

  Future<Either<Failure, void>> saveChanges() async {
    if (formKey.currentState!.validate() &&
        int.tryParse(tableTextController.text) != null) {
      return Right(createOrUpdateBill());
    }
    return Left(
      AdministrationError(
        StackTrace.current,
        "AdministrationModule-orderSheetSaveChanges",
        "",
        "Error Validating",
      ),
    );
  }

  Future<void> createOrUpdateBill() async {
    await _orderSheetStore.createOrUpdateBill(
      NewBill(table: int.tryParse(tableTextController.text)),
      request,
    );
  }

  void removeItemInRequest(int index) {
    _request.items.removeAt(index);
    notifyListeners();
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
    _request.items[index].quantity++;
    notifyListeners();
  }

  void decreaseItemQuantity(int index) {
    _request.items[index].quantity--;
    notifyListeners();
  }

  void clearRequest() {
    _request = NewRequest.empty();
    tableTextController.text = "";
    notifyListeners();
  }

  void makeRequest(NewBill? newBill) {
    // TODO Modify create Method
    // _orderSheetStore.createOrUpdateBill(newBill, _request);
  }
}
