import 'package:administration/src/domain/entities/bill_total.dart';
import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/use_cases/get_not_paid_bills.dart';

class NotPaidBillsStore extends StreamStore<Failure, List<Bill>> {
  final GetNotPaidBills _getNotPaidBills;

  NotPaidBillsStore( this._getNotPaidBills) : super([]);

  Future<void> getNotPaidBills() async => executeEither(
        () => DartzEitherAdapter.adapter(_getNotPaidBills()),
      );
}
