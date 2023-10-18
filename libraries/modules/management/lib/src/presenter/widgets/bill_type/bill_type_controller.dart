// import 'package:flutter_triple/flutter_triple.dart';
import "package:core/core.dart";
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:management/src/domain/errors/management_failures.dart';
import 'package:management/src/domain/utils/format_bill_type_value.dart';
import 'package:management/src/presenter/widgets/bill_types/bill_types_store.dart';

import 'bill_type_store.dart';

class BillTypeController with ChangeNotifier {
  // avoiding inject dependency because disposable state
  final BillTypesStore billTypesStore;
  final BillTypeStore billTypeStore;
  BillTypeController(this.billTypesStore, this.billTypeStore);

  // final billTypeStore = Modular.get< >();

  final formKey = GlobalKey<FormState>();

  final nameTextController = TextEditingController();
  final valueTextController = TextEditingController();

  BillTypes? _billType;

  BillTypes? get billType => _billType;

  set billType(BillTypes? type) {
    _billType = type;
    valueTextController.text = "";
    notifyListeners();
  }

  bool _defaultType = false;

  bool get defaultType => _defaultType;

  set defaultType(bool type) {
    _defaultType = type;
    notifyListeners();
  }

  int? _index;

  int? get index => _index;

  set index(int? type) {
    _index = type;
    notifyListeners();
  }

  void resetFields() {
    if (index != null) {
      final type = billTypesStore.state[index!];
      nameTextController.text = type.name;
      defaultType = type.defaultType ?? false;
      _billType = type.type;
      valueTextController.text = type.value != null
          ? formatBillTypeValue(type.type, type.value!)
          : "null";
    } else {
      clearFields();
    }

    notifyListeners();
  }

  void clearFields() {
    nameTextController.text = "";
    _defaultType = false;
    valueTextController.text = "";
    _index = null;
    _billType = null;
    notifyListeners();
  }

  Future<Either<Failure, void>> saveChanges() async {
    if (formKey.currentState!.validate() && index != null) {
      final id = billTypesStore.state[index!].id;
      return Right(updateBillType(id));
    } else if (formKey.currentState!.validate()) {
      return Right(createBillType());
    }
    return Left(
      ManagementError(
        StackTrace.current,
        "AdministrationModule-saveChanges",
        "",
        "Error Validating",
      ),
    );
  }

  double? parseValue(BillTypes billType, String value) {
    final parsedValue = double.tryParse(value.replaceAll(RegExp('[^0-9]'), ""));
    switch (billType) {
      case BillTypes.deliveryTax:
        return parsedValue != null ? parsedValue / 100 : null;
      case BillTypes.percentageTax:
        return parsedValue;
      case BillTypes.withoutTax:
        return null;
    }
  }

  Future<void> createBillType() async {
    if (billType != null) {
      await billTypeStore.createBillType(
        NewBillType(
          name: nameTextController.text,
          type: billType!,
          // icon: iconTextController.text,
          defaultType: defaultType,
          value: parseValue(billType!, valueTextController.text),
        ),
      );
    }
  }

  void updateBillType(String id) {
    if (billType != null) {
      billTypeStore.updateBillType(
        BillType(
          id: id,
          name: nameTextController.text,
          type: billType!,
          value: parseValue(billType!, valueTextController.text),
          defaultType: defaultType,
          // icon: iconTextController.text,
        ),
      );
    }
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   // formKey.currentState?.dispose();
  //   nameTextController.dispose();
  //   // iconTextController.dispose();
  //   valueTextController.dispose();
  // }
}
