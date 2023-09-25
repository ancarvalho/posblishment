import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/use_cases/get_bill_types.dart';


class BillTypesStore extends StreamStore<Failure, List<BillType>> {
  final IGetBillTypes _getBillTypes;

  BillTypesStore( this._getBillTypes) : super([]);

  Future<void> getBillTypes() async => executeEither(
        () => DartzEitherAdapter.adapter(_getBillTypes()),
      );
}
