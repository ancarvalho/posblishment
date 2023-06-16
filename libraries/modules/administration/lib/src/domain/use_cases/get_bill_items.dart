import 'package:administration/src/domain/repositories/administration_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';


abstract class IGetBillItems {
  Future<Either<Failure, List<Item>>> call(String billID);
}

class GetBillItems implements IGetBillItems {
  final AdministrationRepository repository;

  GetBillItems(this.repository);

  @override
  Future<Either<Failure, List<Item>>> call(String billID) async {
    return repository.getBillValidItems(billID);
  }
}
