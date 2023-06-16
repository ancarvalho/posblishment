import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../repositories/management_repository.dart';

abstract class IDeleteProduct {
  Future<Either<Failure, int>> call(String id);
}

class DeleteProduct implements IDeleteProduct {
  final ManagementRepository repository;

  DeleteProduct(this.repository);

  @override
  Future<Either<Failure, int>> call(String id) async {
    return repository.deleteProduct(id);
  }
}
