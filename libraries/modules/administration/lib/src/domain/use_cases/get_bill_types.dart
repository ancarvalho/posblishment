import 'package:administration/src/domain/repositories/administration_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

// ignore: one_member_abstracts
abstract class IGetBillTypes {
  Future<Either<Failure, List<BillType>>> call( );
}

class GetBillTypes implements IGetBillTypes {
    final AdministrationRepository repository;

  GetBillTypes(this.repository);

  @override
  Future<Either<Failure, List<BillType>>> call( ) async {
    return repository.getBillTypes();
  }
}
