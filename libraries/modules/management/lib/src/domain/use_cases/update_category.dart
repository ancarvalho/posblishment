import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../repositories/management_repository.dart';

// ignore: one_member_abstracts
abstract class IUpdateCategory {
  Future<Either<Failure, int>> call(Category category);
}

class UpdateCategory implements IUpdateCategory {
  final ManagementRepository repository;

  UpdateCategory(this.repository);

  @override
  Future<Either<Failure, int>> call(Category category) async {
    return repository.updateCategory(category);
  }
}
