import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

abstract class AdministrationRepository {
  Future<Either<Failure, List<Product>>> getAllProducts();

  Future<Either<Failure, Bill>> createBill(NewBill bill);
  Future<Either<Failure, String>> createRequest(
    String billID,
    NewRequest request,
  );
  Future<Either<Failure, List<Bill>>> getActiveBills();
  Future<Either<Failure, List<Bill>>> getLastPaidBills();
  Future<Either<Failure, Bill>> getBill(String id);
  Future<Either<Failure, Bill>> getBillByTable(int table);
  Future<Either<Failure, int>> finalizeBill(
    List<NewPayment> payments,
    String billID,
  );
  Future<Either<Failure, int>> cancelBill(String billID);

  Future<Either<Failure, List<BillType>>> getBillTypes();
  Future<Either<Failure, BillType>> getBillType(String id);
  Future<Either<Failure, bool>> createBillType(NewBillType newBillType);
  Future<Either<Failure, bool>> updateBillType(BillType newBillType);
  Future<Either<Failure, BillType>> getDefaultBillType();
  Future<Either<Failure, bool>> removeBillTypeDefaultValue();
  Future<Either<Failure, bool>> setDefaultBillType(String id);
  Future<Either<Failure, int>> updateTypeOfBill(
      String billTypeId, String billId);
  Future<Either<Failure, int>> updateBillStatus(
      String billID, BillStatus status);
  // Future<Either<Failure, Request>> createRequest(Request request, String billID);
  Future<Either<Failure,List<RequestItemWithCategory>>> getRequestItemWithCategory(String requestId);
  Future<Either<Failure, List<Request>>> getLastRequests();
  Future<Either<Failure, int>> cancelRequest(String requestID);
  Future<Either<Failure, int>> setRequestDelivered(String requestID);
  Future<Either<Failure, int>> setItemDelivered(String itemID);
  Future<Either<Failure, List<Request>>> getBillValidRequests(String id);
  Future<Either<Failure, int>> deleteBillType(String id);

  Future<Either<Failure, BillTotal>> getBillTotal(String billID);
  Future<Either<Failure, List<Item>>> getBillValidItems(String billID);
  Future<Either<Failure, BillTotal>> getBillTotalWithPaidAmount(String billID);
  Future<Either<Failure, void>> cancelBillItemQuantity(
    String billId,
    String productId,
    int quantity,
  );
}
