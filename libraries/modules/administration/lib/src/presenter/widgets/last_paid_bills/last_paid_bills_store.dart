import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/use_cases/get_last_paid_bills.dart';

class LastPaidBillsStore extends StreamStore<Failure, List<Bill>> {
  final GetLastPaidBills _getLastPaidBills;

  LastPaidBillsStore( this._getLastPaidBills) : super([]);

  Future<void> getLastPaidBills() async => executeEither(
        () => DartzEitherAdapter.adapter(_getLastPaidBills()),
      );
}
