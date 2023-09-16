import 'package:core/core.dart';
import 'package:drift/drift.dart';
import 'package:internal_database/src/domain/db/sqlite.dart';
import "package:uuid/uuid.dart";
// import 'package:internal_database/src/domain/tables/tables.dart';

class BillTypeAdapter {
  static BillType convertToBillType(BillTypeData billType) {
    return BillType(
      id: billType.id,
      name: billType.name,
      type: billType.type,
      value: billType.value,
      defaultType: billType.defaultType,
    );
  }

  static BillType filterBillType(
    List<BillType> billTypes,
    String billTypeID,
  ) {
    final billType =
        billTypes.where((element) => element.id == billTypeID).first;

    return billType;
  }

  static BillTypeData createBillType(NewBillType billType) {
    return BillTypeData(
      id: const Uuid().v4(),
      name: billType.name,
      defaultType: billType.defaultType ?? false,
      type: billType.type,
      value: billType.value,
      createdAt: DateTime.now(),
    );
  }

  static BillTypeCompanion updateBillType(BillType billType) {
    return BillTypeCompanion(
      id: Value(billType.id),
      name: Value(billType.name),
      defaultType: Value(billType.defaultType ?? false),
      type: Value(billType.type),
      value: Value(billType.value),
      updatedAt: Value(DateTime.now()),
    );
  }
}
