import "package:administration/src/domain/errors/administration_errors.dart";
import "package:administration/src/domain/use_cases/finalize_bill.dart";
import "package:core/core.dart";
import "package:flutter_triple/flutter_triple.dart";

class PaymentStore extends StreamStore<Failure, int> {
  PaymentStore(this._finalizeBill) : super(0);

  final IFinalizeBill _finalizeBill;

  Future<void> finalizeBill(List<NewPayment> payments, String billID) async {
    if (!isLoading) {
      return executeEither(() => DartzEitherAdapter.adapter(_finalizeBill(payments, billID)));
    }
    setError(AdministrationError(StackTrace.current, "AdministrationModule-FinalizeBill", "", "Currently Executing Action"));
  }
}
