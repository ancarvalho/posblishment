import 'package:administration/src/domain/entities/bill_total.dart';
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
      final txID = await _administrationDataSource.changeRequestStatus(id, RequestStatus.canceled, ItemStatus.canceled);
      return Right(txID);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, int>> finalizeBill(
    List<Payment> payments,
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
      final txID = await _administrationDataSource.changeItemStatus(id, ItemStatus.delivered);
      return Right(txID);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, int>> setRequestDelivered(String id) async {
    try {
      final txID = await _administrationDataSource.changeRequestStatus(id, RequestStatus.delivered, ItemStatus.delivered);
      return Right(txID);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, Request>> createBill(NewBill bill, NewRequest request) async {
    try {
      final txID = await _administrationDataSource.handleBillCreationOrUpdate(bill, request);
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
  Future<Either<Failure, List<Item>>> getBillValidItems(String billID) async{
    try {
      final items = await _administrationDataSource.getBillValidItems(billID);
      return Right(items);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
