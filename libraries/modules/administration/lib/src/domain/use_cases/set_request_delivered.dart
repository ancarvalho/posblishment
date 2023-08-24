import 'package:administration/src/domain/repositories/administration_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

// ignore: one_member_abstracts
abstract class ISetRequestDelivered {
  Future<Either<Failure, int>> call(String requestID);
}

class SetRequestDelivered implements ISetRequestDelivered {
  final AdministrationRepository repository;

  SetRequestDelivered(this.repository);

  @override
  Future<Either<Failure, int>> call(String requestID) async {
    return repository.setRequestDelivered(requestID);
  }
}
