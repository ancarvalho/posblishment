import 'package:administration/src/domain/repositories/administration_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

// ignore: one_member_abstracts
abstract class IDeleteBillType {
  Future<Either<Failure, int>> call(String bilID);
}

class DeleteBillType implements IDeleteBillType {
  final AdministrationRepository repository;

  DeleteBillType(this.repository);

  @override
  Future<Either<Failure, int>> call(String billID) async {
    return repository.deleteBillType(billID);
  }
}
