import 'package:administration/src/domain/repositories/administration_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';


abstract class IFinalizeBill {
  Future<Either<Failure, int>> call(List<Payment> payments, String billID);
}

class FinalizeBill implements IFinalizeBill {
  final AdministrationRepository repository;

  FinalizeBill(this.repository);

  @override
  Future<Either<Failure, int>> call(List<Payment> payments, String billID) async {
    return repository.finalizeBill(payments, billID);
  }
}
