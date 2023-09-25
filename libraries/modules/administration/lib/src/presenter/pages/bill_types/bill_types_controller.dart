import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/use_cases/delete_bill_type.dart';
import '../../../domain/use_cases/set_bill_type_default.dart';

class BillTypesController {
  final setBillTypeDefault = Modular.get<ISetBillTypeDefault>();
  final deleteBillType = Modular.get<IDeleteBillType>();

  Future<void> setBillTypeAsDefault(String id) async {
    await setBillTypeDefault.call(id);
  }
  Future<void> deleteCurrentBillType(String id) async {
    await deleteBillType.call(id);
  }

}
