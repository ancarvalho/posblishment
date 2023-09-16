import 'package:core/core.dart';
import "package:drift/drift.dart";
import 'package:internal_database/src/domain/db/sqlite.dart';
import 'package:internal_database/src/domain/utils/adapters/bill_type_adapter.dart';
import "package:uuid/uuid.dart";

class BillAdapter {
  static Bill convertToBill(BillData bill) {
    return Bill(
      id: bill.id,
      status: bill.status,
      customerName: bill.customerName,
      table: bill.table,
      createdAt: bill.createdAt,
      updatedAt: bill.updatedAt,
    );
  }

  static Bill convertToBillWithType(BillData bill, List<BillType> billTypes) {
    return Bill(
      id: bill.id,
      status: bill.status,
      customerName: bill.customerName,
      table: bill.table,
      billType: BillTypeAdapter.filterBillType(billTypes, bill.billTypeId),
      createdAt: bill.createdAt,
      updatedAt: bill.updatedAt,
    );
  }

  static BillData createBill(NewBill bill, String billTypeID) {
    return BillData(
      id: const Uuid().v4(),
      table: bill.table,
      customerName: bill.customerName,
      billTypeId: billTypeID,
      status: BillStatus.open,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  static BillCompanion updateBill(Bill bill) {
    return BillCompanion(
      table: Value(bill.table),
      customerName: Value(bill.customerName),
      status: Value(bill.status),
      updatedAt: Value(DateTime.now()),
    );
  }
}
