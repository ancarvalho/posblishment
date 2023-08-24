import 'package:administration/src/domain/repositories/administration_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

// ignore: one_member_abstracts
abstract class ICreateOrUpdateBill {
  Future<Either<Failure, Request>> call(NewBill bill, NewRequest request);
}

class CreateOrUpdateBill implements ICreateOrUpdateBill {
  final AdministrationRepository repository;

  CreateOrUpdateBill(this.repository);

  @override
  Future<Either<Failure, Request>> call(
    NewBill newBill,
    NewRequest request,
  ) async {
    var bill = await repository
        .getBillByTable(newBill.table!)
        .then((value) => value.toOption().toNullable());
    // var bill = state.toOption().toNullable();
    bill ??= await repository
        .createBill(newBill)
        .then((value) => value.toOption().toNullable());

    return repository.createRequest(bill!.id, request);
  }
}
