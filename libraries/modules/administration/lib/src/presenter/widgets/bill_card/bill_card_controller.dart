import 'package:administration/src/domain/use_cases/cancel_bill.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/use_cases/close_bill.dart';

class BillCardController {
  final _cancelBillUseCase = Modular.get<ICancelBill>();
  final _closeBillUseCase = Modular.get<ICloseBill>();

  void cancelBill(String billId) {
    _cancelBillUseCase.call(billId);
  }

  void closeBill(String billId) {
    _closeBillUseCase.close(billId);
  }
}
