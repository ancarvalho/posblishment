import 'package:administration/src/domain/use_cases/cancel_bill.dart';
import 'package:administration/src/domain/use_cases/use_cases.dart';
import 'package:administration/src/presenter/stores/bill/bill_total_store.dart';
import 'package:administration/src/presenter/widgets/bill_items/bill_items_store.dart';
import 'package:core/core.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/use_cases/close_bill.dart';
import '../../stores/bill/bill_store.dart';

class BillCardController {
  final _cancelBillUseCase = Modular.get<ICancelBill>();
  final _closeBillUseCase = Modular.get<ICloseBill>();
  final PrinterAbstract? printer = Modular.get<PrinterAbstract>();
  final getBillItems = Modular.get<BillItemsStore>();
  final getBillTotal = Modular.get<BillTotalStore>();
  final getBill = Modular.get<BillStore>();

  void cancelBill(String billId) {
    _cancelBillUseCase.call(billId);
  }

  Future<void> closeBill(String billId) async {
    await Future.wait([
      getBillItems.getBillItems(billId),
      getBillTotal.getBillTotal(billId),
      getBill.getBill(billId),
      _closeBillUseCase.close(billId),
    ]);
    printer?.printBill(getBill.state, getBillItems.state, getBillTotal.state);
  }
}
