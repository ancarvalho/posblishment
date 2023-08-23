import "package:administration/src/domain/use_cases/get_bill_total.dart";
import "package:core/core.dart";
import "package:flutter_triple/flutter_triple.dart";

class PaymentStore extends StreamStore<Failure, BillTotal> {
  PaymentStore( this._getBillTotal) : super(BillTotal.empty()) ;

  final IGetBillTotal _getBillTotal;

  Future<void> getBillTotal(String billID) async =>
      executeEither(() => DartzEitherAdapter.adapter(_getBillTotal(billID)));
}
