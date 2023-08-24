import 'package:core/core.dart';
import 'package:dartz/dartz.dart';


abstract class AdministrationRepository {
  Future<Either<Failure, List<Product>>> getAllProducts();

  Future<Either<Failure, Bill>> createBill(NewBill bill);
  Future<Either<Failure, Request>> createRequest(String billID, NewRequest request);
  Future<Either<Failure, List<Bill>>> getActiveBills();
  Future<Either<Failure, List<Bill>>> getLastPaidBills();
  Future<Either<Failure, Bill>> getBill(String id);
  Future<Either<Failure, Bill>> getBillByTable(int table);
  Future<Either<Failure, int>> finalizeBill(List<Payment> payments, String billID);
  Future<Either<Failure, int>> cancelBill(String billID);

  // Future<Either<Failure, Request>> createRequest(Request request, String billID);
  Future<Either<Failure, List<Request>>> getLastRequests();
  Future<Either<Failure, int>> cancelRequest(String requestID);
  Future<Either<Failure, int>> setRequestDelivered(String requestID);
  Future<Either<Failure, int>> setItemDelivered(String itemID);
  Future<Either<Failure, List<Request>>> getBillValidRequests(String id);

  Future<Either<Failure, BillTotal>> getBillTotal(String billID);
  Future<Either<Failure, List<Item>>> getBillValidItems(String billID);
}
