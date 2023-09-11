import "package:administration/src/domain/use_cases/create_or_update_bill.dart";
import "package:core/core.dart";
import "package:flutter_triple/flutter_triple.dart";

import "../../../domain/errors/administration_errors.dart";

class MakeRequestStore extends StreamStore<Failure, Request> {
  MakeRequestStore(this._createOrUpdateBill) : super(Request.empty());

  final ICreateOrUpdateBill _createOrUpdateBill;

  Future<void> createOrUpdateBill(NewBill bill, NewRequest request) async {
    if (!isLoading) {
      return executeEither(() => DartzEitherAdapter.adapter(_createOrUpdateBill(bill, request)));
    }
    AdministrationError(StackTrace.current,"AdministrationModule-createOrUpdateBill","","Currently Executing Action");
    
  }
}
