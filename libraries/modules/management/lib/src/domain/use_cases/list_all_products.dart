import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/entities.dart' as e;
import '../repositories/management_repository.dart';

abstract class IListAllProducts {
  Future<Either<Failure, List<e.Product>>> call();
}

class ListAllProducts implements IListAllProducts {
  final ManagementRepository repository;

  ListAllProducts(this.repository);

  @override
  Future<Either<Failure, List<e.Product>>> call() async {
    return repository.listAllProducts();
  }
}