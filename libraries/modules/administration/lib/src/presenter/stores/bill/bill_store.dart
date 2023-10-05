import 'package:administration/src/domain/use_cases/use_cases.dart';
import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';


class BillStore extends StreamStore<Failure, Bill> {
  final IGetBill _getBill;

  BillStore( this._getBill) : super(Bill.empty());

  Future<void> getBill(String billID) async => executeEither(
        () => DartzEitherAdapter.adapter(_getBill(billID)),
      );
}
