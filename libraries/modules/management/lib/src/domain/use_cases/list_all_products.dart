import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../repositories/management_repository.dart';

// ignore: one_member_abstracts
abstract class IListAllProducts {
  Future<Either<Failure, List<Product>>> call();
}

class ListAllProducts implements IListAllProducts {
  final ManagementRepository repository;

  ListAllProducts(this.repository);

  @override
  Future<Either<Failure, List<Product>>> call() async {
    return repository.listAllProducts();
  }
}
