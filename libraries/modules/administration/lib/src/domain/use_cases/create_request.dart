import 'package:administration/src/domain/repositories/administration_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

// ignore: one_member_abstracts
abstract class ICreateRequest {
  Future<Either<Failure, Request>> call(String bilID, NewRequest request);
}

class CreateRequest implements ICreateRequest {
  final AdministrationRepository repository;

  CreateRequest(this.repository);

  @override
  Future<Either<Failure, Request>> call(String billID, NewRequest request) async {
    return repository.createRequest(billID, request);
  }
}
