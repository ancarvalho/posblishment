import 'package:administration/src/domain/repositories/administration_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';


// ignore: one_member_abstracts
abstract class ICancelRequest {
  Future<Either<Failure, int>> call(String cancelRequest);
}

class CancelRequest implements ICancelRequest {
  final AdministrationRepository repository;

  CancelRequest(this.repository);

  @override
  Future<Either<Failure, int>> call(String cancelRequest) async {
    return repository.cancelRequest(cancelRequest);
  }
}
