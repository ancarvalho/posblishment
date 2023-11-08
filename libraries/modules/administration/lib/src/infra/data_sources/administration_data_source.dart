import 'package:core/core.dart';

abstract class AdministrationDataSource {
  Future<List<Product>> getAllProducts();

  //Bills
  Future<List<Bill>> getActiveBills();
  Future<List<Bill>> getLastPaidBills();
  // Future<Request> handleBillCreationOrUpdate(NewBill bill, NewRequest request);
  Future<Bill> createBill(NewBill bill);

  Future<Bill> getBill(String billID);
  Future<Bill> getBillByTable(int table);
  Future<int> changeBillTable(String billId, int table);
  Future<int> cancelBill(String billID);
  Future<int> updateBillStatus(String billID, BillStatus status);
  Future<int> finalizeBill(List<NewPayment> payments, String billID);
  Future<BillTotal> getBillTotal(String billID);
  Future<int> updateTypeOfBill(String billTypeId, String billId);

  Future<List<BillType>> getBillTypes();

  // Requests
  // Future<Request> createRequest(NewRequest request, String billID);
  Future<int> changeRequestStatus(
    String requestID,
    RequestStatus status,
    ItemStatus itemStatus,
  );
  Future<List<Request>> getBillValidRequests(String billID);
  Future<List<Request>> getLastRequests();
  Future<String> createRequest(String billId, NewRequest request);
  Future<List<RequestItemWithCategory>> getRequestItemWithCategory(String requestId);

  Future<int> changeItemStatus(String id, ItemStatus status);
  Future<List<Item>> getBillValidItems(String billID);
  Future<BillTotal> getBillTotalWithPaidAmount(String billID);
  Future<void> cancelBillItemQuantity(
    String billId,
    String productId,
    int quantity,
  );
}
