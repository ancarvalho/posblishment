import 'package:administration/src/domain/repositories/administration_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

// ignore: one_member_abstracts
abstract class ISetBillTypeDefault {
  Future<Either<Failure, void>> call(String id);
}

class SetBillTypeDefault implements ISetBillTypeDefault {
  final AdministrationRepository repository;

  SetBillTypeDefault(this.repository);

  @override
  Future<Either<Failure, void>> call(String id) async {
    await repository.removeBillTypeDefaultValue();
    return repository.setDefaultBillType(id);
  }
}
