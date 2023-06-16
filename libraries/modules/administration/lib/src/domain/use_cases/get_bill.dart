import 'package:administration/src/domain/repositories/administration_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';


abstract class IGetBill {
  Future<Either<Failure, Bill>> call(String billID);
}

class GetBill implements IGetBill {
  final AdministrationRepository repository;

  GetBill(this.repository);

  @override
  Future<Either<Failure, Bill>> call(String billID) async {
    return repository.getBill(billID);
  }
}
