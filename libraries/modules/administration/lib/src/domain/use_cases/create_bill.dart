import 'package:administration/src/domain/repositories/administration_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';


abstract class ICreateBill {
  Future<Either<Failure, Request>> call(NewBill bill, NewRequest request);
}

class CreateBill implements ICreateBill {
  final AdministrationRepository repository;

  CreateBill(this.repository);

  @override
  Future<Either<Failure, Request>> call(NewBill bill, NewRequest request) async {
    return repository.createBill(bill, request);
  }
}
