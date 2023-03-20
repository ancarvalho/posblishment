import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/entities.dart' as e;
import '../repositories/management_repository.dart';

abstract class IUpdateProduct {
  Future<Either<Failure, e.Product>> call(e.Product product);
}

class UpdateProduct implements IUpdateProduct {
  final ManagementRepository repository;

  UpdateProduct(this.repository);

  @override
  Future<Either<Failure, e.Product>> call(e.Product product) async {
    return repository.updateProduct(product);
  }
}
