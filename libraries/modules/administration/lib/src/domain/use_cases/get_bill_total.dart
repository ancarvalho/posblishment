import 'package:administration/src/domain/repositories/administration_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

// ignore: one_member_abstracts
abstract class IGetBillTotal {
  Future<Either<Failure, BillTotal>> call(String billID);
}

class GetBillTotal implements IGetBillTotal {
  final AdministrationRepository repository;

  GetBillTotal(this.repository);

  @override
  Future<Either<Failure, BillTotal>> call(String billID) async {
    return repository.getBillTotalWithPaidAmount(billID);
  }
}
