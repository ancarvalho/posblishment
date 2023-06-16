import 'package:administration/src/domain/repositories/administration_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';


abstract class ISetItemDelivered {
  Future<Either<Failure, int>> call(String itemID);
}

class SetItemDelivered implements ISetItemDelivered {
  final AdministrationRepository repository;

  SetItemDelivered(this.repository);

  @override
  Future<Either<Failure, int>> call(String itemID) async {
    return repository.setItemDelivered(itemID);
  }
}
