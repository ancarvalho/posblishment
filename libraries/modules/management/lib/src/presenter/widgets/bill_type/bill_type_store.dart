import 'package:core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:management/src/presenter/widgets/bill_type/bill_type_controller.dart';

import '../../../domain/errors/management_failures.dart';
import '../../../domain/use_cases/create_or_update_bill_type.dart';
import '../../../domain/utils/format_bill_type_value.dart';

class BillTypeStore extends StreamStore<Failure, bool> {
  final ICreateOrUpdateBillType _createOrUpdateBillType;

  final formKey = GlobalKey<FormState>();

  final nameTextController = TextEditingController();
  final valueTextController = TextEditingController();

  final billType = ValueNotifier<BillTypes>(BillTypes.percentageTax);

  // late BillTypes _billType;

  // BillTypes get billType => _billType;

  // set billType(BillTypes type) {
  //   setLoading(false);
  //   _billType = type;
  //   valueTextController.text = "";
  //   setLoading(true);
  // }

final ValueNotifier defaultType = ValueNotifier<bool?>(null);

  // bool _defaultType = false;

  // bool get defaultType => _defaultType;

  // set defaultType(bool type) {
  //   setLoading(true);
  //   _defaultType = type;
  //   setLoading(false);
  // }

  void resetFields(BillType? type) {
    setLoading(true);
    nameTextController.text = type?.name ?? "";

    defaultType.value = type?.defaultType ?? false;
    valueTextController.text = type?.value == null
        ? ""
        : type?.type != null
            ? formatBillTypeValue(type!.type, type.value!)
            : "";
    billType.value = type?.type ?? BillTypes.percentageTax;

    setLoading(false);
  }

  void clearFields() {
    setLoading(true);
    nameTextController.text = "";
    defaultType.value = false;
    valueTextController.text = "";
    setLoading(false);
    // notifyListeners();
  }

  Future<void> saveChanges(String? id) async {
    if (formKey.currentState!.validate() && id != null) {
      return updateBillType(id);
    } else if (formKey.currentState!.validate()) {
      return createBillType();
    }
    return setError(
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
    await _create(
      NewBillType(
        name: nameTextController.text,
        type: billType.value,
        // icon: iconTextController.text,
        defaultType: defaultType.value,
        value: parseValue(billType.value, valueTextController.text),
      ),
    );
  }

  Future<void> updateBillType(String id) async {
    await _update(
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

  BillTypeStore(this._createOrUpdateBillType) : super(false);

  Future<void> _create(NewBillType newBillType) async => executeEither(
        () => DartzEitherAdapter.adapter(
            _createOrUpdateBillType.create(newBillType)),
      );
  Future<void> _update(BillType billType) async => executeEither(
        () => DartzEitherAdapter.adapter(
            _createOrUpdateBillType.update(billType)),
      );
}
