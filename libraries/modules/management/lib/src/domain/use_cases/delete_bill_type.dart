import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:management/src/domain/repositories/management_repository.dart';

// ignore: one_member_abstracts
abstract class IDeleteBillType {
  Future<Either<Failure, int>> call(String bilID);
}

class DeleteBillType implements IDeleteBillType {
    final ManagementRepository repository;

  DeleteBillType(this.repository);

  @override
  Future<Either<Failure, int>> call(String billID) async {
    return repository.deleteBillType(billID);
  }
}
