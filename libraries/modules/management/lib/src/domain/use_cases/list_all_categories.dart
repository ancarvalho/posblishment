import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../repositories/management_repository.dart';


// ignore: one_member_abstracts
abstract class IListAllCategories {
  Future<Either<Failure, List<Category>>> call();
}

class ListAllCategories implements IListAllCategories {
  final ManagementRepository repository;

  ListAllCategories(this.repository);

  @override
  Future<Either<Failure, List<Category>>> call() async {
    return repository.listAllCategories();
  }
}
