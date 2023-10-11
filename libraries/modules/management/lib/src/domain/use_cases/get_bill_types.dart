import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:management/src/domain/repositories/management_repository.dart';

// ignore: one_member_abstracts
abstract class IGetBillTypes {
  Future<Either<Failure, List<BillType>>> call( );
}

class GetBillTypes implements IGetBillTypes {
    final ManagementRepository repository;

  GetBillTypes(this.repository);

  @override
  Future<Either<Failure, List<BillType>>> call( ) async {
    return repository.getBillTypes();
  }
}
