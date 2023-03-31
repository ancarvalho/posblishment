import '../entities/entities.dart';

abstract class BillRepository {
  Future<List<Bill>> getActiveBills();
  Future<Bill> getBill(String id);
  //
  Future<bool> createBill(Bill bill);
  Future<bool> updateBillStatus(String id, BillStatus status);
  Future<bool> updateBillTable(String id, int table);
  Future<bool> updateBillCustomerName(String id, String customerName);
}
