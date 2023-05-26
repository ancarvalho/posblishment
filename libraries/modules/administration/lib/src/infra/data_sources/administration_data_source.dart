import 'package:core/core.dart';

abstract class AdministrationDataSource {
  Future<List<Product>> getAllProducts();

  //Bills
  Future<List<Bill>> getActiveBills();
  Future<List<Bill>> getLastPaidBills();
  Future<int> createBill(Bill bill, NewRequest request);
  Future<Bill> getBill(String billID);
  Future<int> cancelBill(String billID);
  Future<int> finalizeBill(List<Payment> payments, String billID);
  
  // Requests
  Future<Request> createRequest(NewRequest request, String billID);
  Future<int> cancelRequest(String requestID);
  Future<int> setRequestDelivered(String requestID);
  Future<List<Request>> getBillValidRequests(String billID);
  Future<List<Request>> getLastRequests();

  Future<int> setItemDelivered(String id);
}
