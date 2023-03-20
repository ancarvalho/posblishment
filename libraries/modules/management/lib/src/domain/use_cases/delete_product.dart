import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/entities.dart' as e;
import '../repositories/management_repository.dart';

abstract class IDeleteProduct {
  Future<Either<Failure, e.Product>> call(String id);
}

class DeleteProduct implements IDeleteProduct {
  final ManagementRepository repository;

  DeleteProduct(this.repository);

  @override
  Future<Either<Failure, e.Product>> call(String id) async {
    return repository.deleteProduct(id);
  }
}
