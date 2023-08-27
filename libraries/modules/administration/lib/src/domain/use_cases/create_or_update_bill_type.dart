import 'package:administration/src/domain/repositories/administration_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

// ignore: one_member_abstracts
abstract class ICreateOrUpdateBillType {
  Future<Either<Failure, bool>> create(NewBillType billType);
  Future<Either<Failure, bool>> update(BillType billType);
}

class CreateOrUpdateBillType implements ICreateOrUpdateBillType {
  final AdministrationRepository repository;

  CreateOrUpdateBillType(this.repository);

  @override
  Future<Either<Failure, bool>> create(NewBillType billType) async {
    if (billType.defaultType ?? false) {
      await repository.removeBillTypeDefaultValue();
    }
    return repository.createBillType(billType);
  }

  @override
  Future<Either<Failure, bool>> update(BillType billType) async {
    if (billType.defaultType ?? false) {
      await repository.removeBillTypeDefaultValue();
    }
    return repository.updateBillType(billType);
  }
}
