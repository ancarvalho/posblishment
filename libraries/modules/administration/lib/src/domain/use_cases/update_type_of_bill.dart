import 'package:administration/src/domain/repositories/administration_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

// ignore: one_member_abstracts
abstract class IUpdateTypeOfBill {
  Future<Either<Failure, int>> call(String billId, String billTypeId);
}

class UpdateTypeOfBill implements IUpdateTypeOfBill {
  final AdministrationRepository repository;

  UpdateTypeOfBill(this.repository);

  @override
  Future<Either<Failure, int>> call(String billId, String billTypeId) async {
    return repository.updateTypeOfBill( billTypeId, billId);
  }
}
