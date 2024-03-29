import 'package:administration/src/domain/repositories/administration_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';


// ignore: one_member_abstracts
abstract class IFinalizeBill {
  Future<Either<Failure, int>> call(List<NewPayment> payments, String billID);
}

class FinalizeBill implements IFinalizeBill {
  final AdministrationRepository repository;

  FinalizeBill(this.repository);

  @override
  Future<Either<Failure, int>> call(List<NewPayment> payments, String billID) async {
    return repository.finalizeBill(payments, billID);
  }
}
