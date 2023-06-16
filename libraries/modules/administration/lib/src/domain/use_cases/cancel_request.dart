import 'package:administration/src/domain/repositories/administration_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';


abstract class IRequestID {
  Future<Either<Failure, int>> call(String requestID);
}

class RequestID implements IRequestID {
  final AdministrationRepository repository;

  RequestID(this.repository);

  @override
  Future<Either<Failure, int>> call(String requestID) async {
    return repository.cancelRequest(requestID);
  }
}
