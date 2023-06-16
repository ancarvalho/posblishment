import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/use_cases/get_bill_requests.dart';

class BillRequestsStore extends StreamStore<Failure, List<Request>> {
  final GetBillRequests _getBillRequests;

  BillRequestsStore(this._getBillRequests) : super([]);

  Future<void> getBillRequests(String billID) async => executeEither(
        () => DartzEitherAdapter.adapter(_getBillRequests(billID)),
      );
}
