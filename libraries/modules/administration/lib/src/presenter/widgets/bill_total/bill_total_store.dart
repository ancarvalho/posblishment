import 'package:administration/src/domain/entities/bill_total.dart';
import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/use_cases/get_bill_total.dart';

class BillTotalStore extends StreamStore<Failure, BillTotal> {
  final GetBillTotal _getBillTotal;

  BillTotalStore(super.initialState, this._getBillTotal) : super();

  Future<void> getBillTotal(String billID) async => executeEither(
        () => DartzEitherAdapter.adapter(_getBillTotal(billID)),
      );
}
