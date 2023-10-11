import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:management/src/domain/repositories/management_repository.dart';

// ignore: one_member_abstracts
abstract class ISetBillTypeDefault {
  Future<Either<Failure, void>> call(String id);
}

class SetBillTypeDefault implements ISetBillTypeDefault {
  final ManagementRepository repository;

  SetBillTypeDefault(this.repository);

  @override
  Future<Either<Failure, void>> call(String id) async {
    await repository.removeBillTypeDefaultValue();
    return repository.setDefaultBillType(id);
  }
}
