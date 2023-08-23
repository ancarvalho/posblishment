import 'package:administration/src/domain/repositories/administration_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';


abstract class ICancelRequest {
  Future<Either<Failure, int>> call(String CancelRequest);
}

class CancelRequest implements ICancelRequest {
  final AdministrationRepository repository;

  CancelRequest(this.repository);

  @override
  Future<Either<Failure, int>> call(String CancelRequest) async {
    return repository.cancelRequest(CancelRequest);
  }
}
