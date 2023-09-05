// import "package:core/core.dart";
// import 'package:dartz/dartz.dart';
// import "package:flutter/widgets.dart";
// import "package:flutter_modular/flutter_modular.dart";

// import "../../../domain/errors/administration_errors.dart";
// import "../../../domain/utils/utils.dart";
// import 'make_request_store.dart';

// class OrderSheetController extends Disposable with ChangeNotifier {
//   final ValueNotifier<NewRequest> _request = ValueNotifier(NewRequest.empty());

//   NewRequest get request => _request.value;

//   final OrderSheetStore _orderSheetStore = Modular.get<OrderSheetStore>();

//   final tableTextController = TextEditingController();
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   Either<Failure, void> insertItemONRequest(NewItem? item) {
//     if (item != null) {
//       _request.value.items.add(item);
//       return Right(notifyListeners());
//     }
//     return Left(
//       AdministrationError(
//         StackTrace.current,
//         "AdministrationModule-orderSheet-insertItemONRequest",
//         "",
//         "Item does not exist in menu",
//       ),
//     );
//   }

//   Future<Either<Failure, void>> saveChanges() async {
//     if (formKey.currentState!.validate() &&
//         int.tryParse(tableTextController.text) != null &&
//         request.items.isNotEmpty) {
//       return Right(await createOrUpdateBill());
//     }
//     return Left(
//       AdministrationError(
//         StackTrace.current,
//         "AdministrationModule-orderSheetSaveChanges",
//         "",
//         "Error Validating",
//       ),
//     );
//   }

//   Future<void> createOrUpdateBill() async {
//     await _orderSheetStore.createOrUpdateBill(
//       NewBill(table: int.tryParse(tableTextController.text)),
//       request,
//     );
//   }

//   void removeItemInRequest(int index) {
//     _request.value.items.removeAt(index);
//     notifyListeners();
//   }

//   void increaseOrDecreaseQuantity(IncreaseORDecrease e, int index) {
//     switch (e) {
//       case IncreaseORDecrease.increase:
//         increaseItemQuantity(index);
//         break;
//       case IncreaseORDecrease.decrease:
//         decreaseItemQuantity(index);
//         break;
//     }
//   }

//   void increaseItemQuantity(int index) {
//     _request.value.items[index].quantity++;
//     notifyListeners();
//   }

//   void decreaseItemQuantity(int index) {
//     if (_request.value.items[index].quantity > 1) _request.value.items[index].quantity--;
//     notifyListeners();
//   }

//   void clearRequest() {
//     _request.value = NewRequest.empty();
//     tableTextController.text = "";
//     notifyListeners();
//   }

//   void makeRequest(NewBill? newBill) {
//     // TODO Modify create Method
//     // _orderSheetStore.createOrUpdateBill(newBill, _request);
//   }
// }
