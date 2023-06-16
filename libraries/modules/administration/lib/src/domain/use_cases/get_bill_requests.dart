import 'package:administration/src/domain/repositories/administration_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';


abstract class IGetBillRequests {
  Future<Either<Failure, List<Request>>> call(String billID);
}

class GetBillRequests implements IGetBillRequests {
  final AdministrationRepository repository;

  GetBillRequests(this.repository);

  @override
  Future<Either<Failure, List<Request>>> call(String billID) async {
    return repository.getBillValidRequests(billID);
  }
}
