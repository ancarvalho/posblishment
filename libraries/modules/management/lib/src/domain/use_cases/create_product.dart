import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/entities.dart' as e;
import '../repositories/management_repository.dart';

abstract class ICreateProduct {
  Future<Either<Failure, e.Product>> call(e.Product product);
}

class CreateProduct implements ICreateProduct {
  final ManagementRepository repository;

  CreateProduct(this.repository);

  @override
  Future<Either<Failure, e.Product>> call(e.Product product) async {
    return repository.createProduct(product);
  }
}
