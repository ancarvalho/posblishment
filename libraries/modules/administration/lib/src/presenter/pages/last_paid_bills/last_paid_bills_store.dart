import 'package:administration/src/domain/use_cases/get_last_paid_bills.dart';
import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';

class LastPaidBillsStore extends StreamStore<Failure, List<Bill>> {
  LastPaidBillsStore(this._getLastPaidBills):super([]);

  final IGetLastPaidBills _getLastPaidBills;

  Future<void> getLastPaidBills() async =>
      executeEither(() => DartzEitherAdapter.adapter(_getLastPaidBills()));
}
