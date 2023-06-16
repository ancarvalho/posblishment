import 'package:administration/src/domain/entities/bill_total.dart';
import 'package:administration/src/domain/repositories/administration_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';


abstract class IGetBillTotal {
  Future<Either<Failure, BillTotal>> call(String billID);
}

class GetBillTotal implements IGetBillTotal {
  final AdministrationRepository repository;

  GetBillTotal(this.repository);

  @override
  Future<Either<Failure, BillTotal>> call(String billID) async {
    return repository.getBillTotal(billID);
  }
}
