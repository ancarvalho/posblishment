import 'package:core/core.dart';
import "package:drift/drift.dart";
import 'package:internal_database/src/domain/db/sqlite.dart';
import "package:uuid/uuid.dart";

class BillAdapter {
  static Bill convertToBill(BillData bill) {
    return Bill(
      id: bill.id,
      createdAt: bill.createdAt,
      status: bill.status,
      updatedAt: bill.updatedAt,
      customerName: bill.customerName,
      table: bill.table,
    );
  }

  static BillData createBill(Bill bill) {
    return BillData(
      id: const Uuid().v4(),
      table: bill.table,
      customerName: bill.customerName,
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
