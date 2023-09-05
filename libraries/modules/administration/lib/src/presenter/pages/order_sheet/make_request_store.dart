import "package:administration/src/domain/use_cases/create_or_update_bill.dart";
import "package:core/core.dart";
import "package:flutter_triple/flutter_triple.dart";

class MakeRequestStore extends StreamStore<Failure, Request> {
  MakeRequestStore( this._createOrUpdateBill) : super(Request.empty()) ;

  final ICreateOrUpdateBill _createOrUpdateBill;

  Future<void> createOrUpdateBill(NewBill bill, NewRequest request) async =>
      executeEither(() => DartzEitherAdapter.adapter(_createOrUpdateBill(bill, request)));
}
