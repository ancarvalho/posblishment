import 'package:administration/src/domain/repositories/administration_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

// ignore: one_member_abstracts
abstract class IGetRequestItemCategorized {
  Future<Either<Failure, List<RequestItemWithCategory>>> call(String requestId);
}

class GetRequestItemCategorized implements IGetRequestItemCategorized {
  final AdministrationRepository repository;

  GetRequestItemCategorized(this.repository);

  @override
  Future<Either<Failure, List<RequestItemWithCategory>>> call(String requestId) async {
    return repository.getRequestItemWithCategory(requestId);
  }
}
