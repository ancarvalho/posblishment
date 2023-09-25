import 'package:administration/src/domain/repositories/administration_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';


// ignore: one_member_abstracts
abstract class ICloseBill {
  Future<Either<Failure, int>> close(String billID);
}

class CloseBill implements ICloseBill {
  final AdministrationRepository repository;

  CloseBill(this.repository);

  @override
  Future<Either<Failure, int>> close(String billID) async {
    return repository.updateBillStatus(billID, BillStatus.closed);
  }
}
