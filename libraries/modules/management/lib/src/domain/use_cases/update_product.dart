import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../repositories/management_repository.dart';

abstract class IUpdateProduct {
  Future<Either<Failure, int>> call(Product product);
}

class UpdateProduct implements IUpdateProduct {
  final ManagementRepository repository;

  UpdateProduct(this.repository);

  @override
  Future<Either<Failure, int>> call(Product product) async {
    return repository.updateProduct(product);
  }
}
