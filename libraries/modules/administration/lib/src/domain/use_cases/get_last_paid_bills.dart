import 'package:administration/src/domain/repositories/administration_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';


abstract class IGetLastPaidBills {
  Future<Either<Failure, List<Bill>>> call();
}

class GetLastPaidBills implements IGetLastPaidBills {
  final AdministrationRepository repository;

  GetLastPaidBills(this.repository);

  @override
  Future<Either<Failure, List<Bill>>> call() async {
    return repository.getLastPaidBills();
  }
}
