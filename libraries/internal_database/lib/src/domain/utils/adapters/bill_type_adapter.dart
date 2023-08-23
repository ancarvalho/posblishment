import 'package:core/core.dart';
import 'package:internal_database/src/domain/db/sqlite.dart';
// import 'package:internal_database/src/domain/tables/tables.dart';

class BillTypeAdapter {
  static BillType convertToBillType(BillTypeData billType) {
    return BillType(
      id: billType.id,
      name: billType.name,
      type: billType.type,
      icon: billType.icon,
    );
  }

  static BillType filterBillType(
      List<BillTypeData> billTypes, String billTypeID) {
    final billType =
        billTypes.where((element) => element.id == billTypeID).first;

    return convertToBillType(billType);
  }
}
