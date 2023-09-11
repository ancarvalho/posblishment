import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/use_cases/get_bill_total.dart';

class BillTotalGetter {
  // final IGetBillTotal _getBillTotal;

  final IGetBillTotal _getBillTotal = Modular.get<IGetBillTotal>();

  // BillTotalGetter(this._getBillTotal);

  Future<Either<Failure, BillTotal>> getBillTotal(String billID) async {
    return _getBillTotal(billID);
  }

 
}
