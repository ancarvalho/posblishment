import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/entities.dart' as e;
import '../repositories/management_repository.dart';

abstract class IListAllCategories {
  Future<Either<Failure, List<e.Category>>> call();
}

class ListAllCategories implements IListAllCategories {
  final ManagementRepository repository;

  ListAllCategories(this.repository);

  @override
  Future<Either<Failure, List<e.Category>>> call() async {
    return repository.listAllCategories();
  }
}
