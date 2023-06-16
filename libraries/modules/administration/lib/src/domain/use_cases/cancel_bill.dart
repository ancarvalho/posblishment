import 'package:administration/src/domain/repositories/administration_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';


abstract class ICancelBill {
  Future<Either<Failure, int>> call(String billID);
}

class CancelBill implements ICancelBill {
  final AdministrationRepository repository;

  CancelBill(this.repository);

  @override
  Future<Either<Failure, int>> call(String billID) async {
    return repository.cancelBill(billID);
  }
}
