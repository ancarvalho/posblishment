import 'package:administration/src/domain/use_cases/use_cases.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/use_cases/close_bill.dart';

class BillCardController {
  final _cancelBillUseCase = Modular.get<ICancelBill>();
  final _closeBillUseCase = Modular.get<ICloseBill>();
  final PrinterAbstract? printer = Modular.get<PrinterAbstract>();
  final getBillItems = Modular.get<IGetBillItems>();
  final getBillTotal = Modular.get<IGetBillTotal>();
  final getBill = Modular.get<IGetBill>();
  final settingsStore = Modular.get<AbstractSettingsStore>();

  void cancelBill(String billId) {
    _cancelBillUseCase.call(billId);
  }

  T? getGenericProps<T>(Either<Failure, T> result) {
    return result.fold((l) => null, (r) => r);
  }

  Future<void> closeBill(String billId) async {
    late final Bill? bill;
    late final List<Item>? items;
    late final BillTotal? billTotal;
    await Future.wait([
      getBillItems.call(billId).then((value) => items = getGenericProps(value)),
      getBillTotal
          .call(billId)
          .then((value) => billTotal = getGenericProps(value)),
      getBill.call(billId).then((value) => bill = getGenericProps(value)),
      _closeBillUseCase.close(billId),
    ]);
    if (bill != null &&
        billTotal != null &&
        items != null &&
        settingsStore.state.printerSettings!.enablePrinter) {
      await printer?.reconnect();
      printer?.printBill(bill!, items!, billTotal!);
    }
  }
}
