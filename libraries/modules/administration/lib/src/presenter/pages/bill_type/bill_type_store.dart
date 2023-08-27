import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/use_cases/create_or_update_bill_type.dart';


class BillTypeStore extends StreamStore<Failure, bool> {
  final CreateOrUpdateBillType _createOrUpdateBillType;

  BillTypeStore( this._createOrUpdateBillType) : super(false);

  Future<void> createBillType(NewBillType newBillType) async => executeEither(
        () => DartzEitherAdapter.adapter(_createOrUpdateBillType.create(newBillType)),
      );
  Future<void> updateBillType(BillType billType) async => executeEither(
        () => DartzEitherAdapter.adapter(_createOrUpdateBillType.update(billType)),
      );
}
