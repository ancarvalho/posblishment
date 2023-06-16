import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/use_cases/get_bill_items.dart';

class BillItemsStore extends StreamStore<Failure, List<Item>> {
  final GetBillItems _getBillItems;

  BillItemsStore(this._getBillItems) : super([]);

  Future<void> getBillItems(String billID) async => executeEither(
        () => DartzEitherAdapter.adapter(_getBillItems(billID)),
      );
}
