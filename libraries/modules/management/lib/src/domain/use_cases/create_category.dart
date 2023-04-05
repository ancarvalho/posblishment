import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:internal_database/internal_database.dart';


import '../repositories/management_repository.dart';

abstract class ICreateCategory {
  Future<Either<Failure, int>> call(Category category);
}

class CreateCategory implements ICreateCategory {
  final ManagementRepository repository;

  CreateCategory(this.repository);

  @override
  Future<Either<Failure, int>> call(Category category) async {
    return repository.createCategory(category);
  }
}
