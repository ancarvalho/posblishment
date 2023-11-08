import 'package:administration/src/domain/errors/administration_errors.dart';
import 'package:administration/src/domain/repositories/administration_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

// ignore: one_member_abstracts
abstract class IUpdateBillTable {
  Future<Either<Failure, int>> call(String billId, int table);
}

class UpdateBillTable implements IUpdateBillTable {
  final AdministrationRepository repository;

  UpdateBillTable(this.repository);

  @override
  Future<Either<Failure, int>> call(String billId, int table) async {
    final bill = await repository
        .getBillByTable(table)
        .then((value) => value.fold((l) => null, (r) => r));

    if (bill == null) {
      return repository.changeBillTable(billId, table);
    }
    return Left(
      AdministrationError(
        StackTrace.current,
        "AdministrationModule - UpdateBillTableUseCase",
        "",
        "Error Updating Table - Table Already Exists",
      ),
    );
  }
}
