import 'package:administration/src/domain/repositories/administration_repository.dart';
import 'package:administration/src/infra/data_sources/administration_data_source.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class AdministrationRepositoryImpl implements AdministrationRepository {
  final AdministrationDataSource _administrationDataSource;

  AdministrationRepositoryImpl(this._administrationDataSource);

  @override
  Future<Either<Failure, int>> cancelBill(String id) async {
    try {
      final txID = await _administrationDataSource.cancelBill(id);
      return Right(txID);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, int>> cancelRequest(String id) async {
    try {
      final txID = await _administrationDataSource.changeRequestStatus(
        id,
        RequestStatus.canceled,
        ItemStatus.canceled,
      );
      return Right(txID);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, int>> finalizeBill(
    List<NewPayment> payments,
    String billID,
  ) async {
    try {
      final txID =
          await _administrationDataSource.finalizeBill(payments, billID);
      return Right(txID);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<Bill>>> getActiveBills() async {
    try {
      final bill = await _administrationDataSource.getActiveBills();
      return Right(bill);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    try {
      final products = await _administrationDataSource.getAllProducts();
      return Right(products);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, Bill>> getBill(String id) async {
    try {
      final bill = await _administrationDataSource.getBill(id);
      return Right(bill);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<Request>>> getBillValidRequests(String id) async {
    try {
      final requests = await _administrationDataSource.getBillValidRequests(id);
      return Right(requests);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<Bill>>> getLastPaidBills() async {
    try {
      final bills = await _administrationDataSource.getLastPaidBills();
      return Right(bills);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<Request>>> getLastRequests() async {
    try {
      final requests = await _administrationDataSource.getLastRequests();
      return Right(requests);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  // @override
  // Future<Either<Failure, Request>> createRequest(Request request, String billID) async {
  //   try {
  //     final txID = await _administrationDataSource.createRequest(request, billID);
  //     return Right(txID);
  //   } on Failure catch (e) {
  //     return Left(e);
  //   }
  // }

  @override
  Future<Either<Failure, int>> setItemDelivered(String id) async {
    try {
      final txID = await _administrationDataSource.changeItemStatus(
        id,
        ItemStatus.delivered,
      );
      return Right(txID);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, int>> setRequestDelivered(String id) async {
    try {
      final txID = await _administrationDataSource.changeRequestStatus(
        id,
        RequestStatus.delivered,
        ItemStatus.delivered,
      );
      return Right(txID);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, Bill>> createBill(NewBill bill) async {
    try {
      final txID = await _administrationDataSource.createBill(bill);
      return Right(txID);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, BillTotal>> getBillTotal(String billID) async {
    try {
      final billTotal = await _administrationDataSource.getBillTotal(billID);
      return Right(billTotal);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<Item>>> getBillValidItems(String billID) async {
    try {
      final items = await _administrationDataSource.getBillValidItems(billID);
      return Right(items);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, Request>> createRequest(
    String billID,
    NewRequest newRequest,
  ) async {
    try {
      final request =
          await _administrationDataSource.createRequest(billID, newRequest);
      return Right(request);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, Bill>> getBillByTable(int table) async {
    try {
      final bill = await _administrationDataSource.getBillByTable(table);
      return Right(bill);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<BillType>>> getBillTypes() async {
    try {
      final billTypes = await _administrationDataSource.getBillTypes();
      return Right(billTypes);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, BillType>> getDefaultBillType() async {
    try {
      final billType = await _administrationDataSource.getDefaultBillType();
      return Right(billType);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, BillType>> getBillType(String id) async {
    try {
      final billType = await _administrationDataSource.getBillType(id);
      return Right(billType);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, bool>> createBillType(NewBillType newBillType) async {
    try {
      final billType =
          await _administrationDataSource.createBillType(newBillType);
      return Right(billType);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, bool>> updateBillType(BillType billType) async {
    try {
      final billTypeUpdated =
          await _administrationDataSource.updateBillType(billType);
      return Right(billTypeUpdated);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, bool>> removeBillTypeDefaultValue() async {
    try {
      final billTypeUpdated =
          await _administrationDataSource.removeBillTypeDefaultValue();
      return Right(billTypeUpdated);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, bool>> setDefaultBillType(String id) async {
    try {
      final billTypeUpdated =
          await _administrationDataSource.setDefaultBillType(id);
      return Right(billTypeUpdated);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, BillTotal>> getBillTotalWithPaidAmount(
      String billID,) async {
    try {
      final billTotal =
          await _administrationDataSource.getBillTotalWithPaidAmount(billID);
      return Right(billTotal);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
