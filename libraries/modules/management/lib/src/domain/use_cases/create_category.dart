import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../repositories/management_repository.dart';

// ignore: one_member_abstracts
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
