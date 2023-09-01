import 'package:core/core.dart';

abstract class AdministrationDataSource {
  Future<List<Product>> getAllProducts();

  //Bills
  Future<List<Bill>> getActiveBills();
  Future<List<Bill>> getLastPaidBills();
  // Future<Request> handleBillCreationOrUpdate(NewBill bill, NewRequest request);
  Future<Bill> createBill(NewBill bill);
  Future<Request> createRequest(String billId, NewRequest request);
  Future<Bill> getBill(String billID);
  Future<Bill> getBillByTable(int table);
  Future<int> cancelBill(String billID);
  Future<int> finalizeBill(List<NewPayment> payments, String billID);
  Future<BillTotal> getBillTotal(String billID);

  Future<BillType> getDefaultBillType();
  Future<BillType> getBillType(String id);
  Future<bool> updateBillType(BillType billType);
  Future<bool> createBillType(NewBillType newBillType);
  Future<List<BillType>> getBillTypes();
  Future<int> deleteBillType(String id);
  Future<bool> removeBillTypeDefaultValue();
  Future<bool> setDefaultBillType(String id);
  // Requests
  // Future<Request> createRequest(NewRequest request, String billID);
  Future<int> changeRequestStatus(
    String requestID,
    RequestStatus status,
    ItemStatus itemStatus,
  );
  Future<List<Request>> getBillValidRequests(String billID);
  Future<List<Request>> getLastRequests();

  Future<int> changeItemStatus(String id, ItemStatus status);
  Future<List<Item>> getBillValidItems(String billID);
  Future<BillTotal> getBillTotalWithPaidAmount(String billID);
}
