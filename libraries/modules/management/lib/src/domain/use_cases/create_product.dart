import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:internal_database/internal_database.dart';

import '../repositories/management_repository.dart';

abstract class ICreateProduct {
  Future<Either<Failure, int>> call(Product product);
}

class CreateProduct implements ICreateProduct {
  final ManagementRepository repository;

  CreateProduct(this.repository);

  @override
  Future<Either<Failure, int>> call(Product product) async {
    return repository.createProduct(product);
  }
}
