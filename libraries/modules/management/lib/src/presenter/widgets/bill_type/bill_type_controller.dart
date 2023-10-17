// // import 'package:flutter_triple/flutter_triple.dart';
// import "package:core/core.dart";
// import 'package:dartz/dartz.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:management/src/domain/errors/management_failures.dart';
// import 'package:management/src/domain/utils/format_bill_type_value.dart';

// import 'bill_type_store.dart';

// class BillTypeController extends Disposable with ChangeNotifier {
//   // avoiding inject dependency because disposable state

//   BillTypeController();

//   final billTypeStore = Modular.get<BillTypeStore>();

//   final formKey = GlobalKey<FormState>();

//   final nameTextController = TextEditingController();
//   final valueTextController = TextEditingController();

//   late BillTypes _billType ;

//   BillTypes get billType => _billType;

//   set billType(BillTypes type) {
//     _billType = type;
//     valueTextController.text = "";
//     notifyListeners();
//   }

//   bool _defaultType = false;

//   bool get defaultType => _defaultType;

//   set defaultType(bool type) {
//     _defaultType = type;
//     notifyListeners();
//   }

//   void resetFields(BillType? type) {
//     nameTextController.text = type?.name ?? "";

//     defaultType = type?.defaultType ?? false;
//     valueTextController.text = type?.value == null
//         ? ""
//         : type?.type != null
//             ? formatBillTypeValue(type!.type, type.value!)
//             : "";
//     billType = type?.type ?? BillTypes.percentageTax;

//     notifyListeners();
//   }

//   void clearFields() {
//     nameTextController.text = "";
//     defaultType = false;
//     valueTextController.text = "";

//     notifyListeners();
//   }

//   Future<Either<Failure, void>> saveChanges(String? id) async {
//     if (formKey.currentState!.validate() && id != null) {
//       return Right(updateBillType(id));
//     } else if (formKey.currentState!.validate()) {
//       return Right(createBillType());
//     }
//     return Left(
//       ManagementError(
//         StackTrace.current,
//         "AdministrationModule-saveChanges",
//         "",
//         "Error Validating",
//       ),
//     );
//   }

//   double? parseValue(BillTypes billType, String value) {
//     final parsedValue = double.tryParse(value.replaceAll(RegExp('[^0-9]'), ""));
//     switch (billType) {
//       case BillTypes.deliveryTax:
//         return parsedValue != null ? parsedValue / 100 : null;
//       case BillTypes.percentageTax:
//         return parsedValue;
//       case BillTypes.withoutTax:
//         return null;
//     }
//   }

//   Future<void> createBillType() async {
//     await billTypeStore.createBillType(
//       NewBillType(
//         name: nameTextController.text,
//         type: billType,
//         // icon: iconTextController.text,
//         defaultType: defaultType,
//         value: parseValue(billType, valueTextController.text),
//       ),
//     );
//   }

//   void updateBillType(String id) {
//     billTypeStore.updateBillType(
//       BillType(
//         id: id,
//         name: nameTextController.text,
//         type: billType,
//         value: parseValue(billType, valueTextController.text),
//         defaultType: defaultType,
//         // icon: iconTextController.text,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     // formKey.currentState?.dispose();
//     nameTextController.dispose();
//     // iconTextController.dispose();
//     valueTextController.dispose();
//   }
// }
