import 'package:administration/src/domain/repositories/administration_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';


abstract class IGetNotPaidBills {
  Future<Either<Failure, List<Bill>>> call();
}

class GetNotPaidBills implements IGetNotPaidBills {
  final AdministrationRepository repository;

  GetNotPaidBills(this.repository);

  @override
  Future<Either<Failure, List<Bill>>> call() async {
    return repository.getActiveBills();
  }
}
