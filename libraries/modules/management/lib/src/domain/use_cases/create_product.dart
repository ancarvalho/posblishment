import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../repositories/management_repository.dart';

// ignore: one_member_abstracts
abstract class ICreateProduct {
  Future<Either<Failure, int>> call(NewProduct product);
}

class CreateProduct implements ICreateProduct {
  final ManagementRepository repository;

  CreateProduct(this.repository);

  @override
  Future<Either<Failure, int>> call(NewProduct product) async {
    return repository.createProduct(product);
  }
}
