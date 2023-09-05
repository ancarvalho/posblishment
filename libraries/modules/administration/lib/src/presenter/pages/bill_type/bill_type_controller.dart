// import 'package:flutter_triple/flutter_triple.dart';
import 'package:administration/src/domain/errors/administration_errors.dart';
import "package:core/core.dart";
import 'package:dartz/dartz.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/utils/bill_types_formatter.dart';
import '../../../domain/utils/format_bill_type_value.dart';
import 'bill_type_store.dart';

class BillTypeController extends Disposable {
  // avoiding inject dependency because disposable state

  BillTypeController();

  final billTypeStore = Modular.get<BillTypeStore>();

  final formKey = GlobalKey<FormState>();

  final nameTextController = TextEditingController();
  // final iconTextController = TextEditingController();
  final valueTextController = TextEditingController();

  final billType = ValueNotifier(BillTypes.percentageTax);
  final defaultType = ValueNotifier<bool>(false);

  void resetFields(BillType? type) {
    nameTextController.text = type?.name ?? "";
    // iconTextController.text = type?.icon ?? "";
    defaultType.value = false;
    valueTextController.text = type?.value == null
        ? ""
        : type?.type != null
            ? formatBillTypeValue(type!.type, type.value!)
            : "";
    billType.value = type?.type ?? BillTypes.percentageTax;
  }

  Future<Either<Failure, void>> saveChanges(String? id) async {
    if (formKey.currentState!.validate() && id != null) {
      return Right(updateBillType(id));
    } else if (formKey.currentState!.validate()) {
      return Right(createBillType());
    }
    return Left(
      AdministrationError(
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
    await billTypeStore.createBillType(
      NewBillType(
        name: nameTextController.text,
        type: billType.value,
        // icon: iconTextController.text,
        defaultType: defaultType.value,
        value: parseValue(billType.value, valueTextController.text),
      ),
    );
  }

  void updateBillType(String id) {
    billTypeStore.updateBillType(
      BillType(
        id: id,
        name: nameTextController.text,
        type: billType.value,
        value: parseValue(billType.value, valueTextController.text),
        defaultType: defaultType.value,
        // icon: iconTextController.text,
      ),
    );
  }

  @override
  void dispose() {
    // formKey.currentState?.dispose();
    nameTextController.dispose();
    // iconTextController.dispose();
    valueTextController.dispose();
    billType.dispose();
  }
}
