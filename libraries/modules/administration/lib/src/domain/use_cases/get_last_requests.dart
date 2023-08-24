import 'package:administration/src/domain/repositories/administration_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

// ignore: one_member_abstracts
abstract class IGetLastRequests {
  Future<Either<Failure, List<Request>>> call();
}

class GetLastRequests implements IGetLastRequests {
  final AdministrationRepository repository;

  GetLastRequests(this.repository);

  @override
  Future<Either<Failure, List<Request>>> call() async {
    return repository.getLastRequests();
  }
}
