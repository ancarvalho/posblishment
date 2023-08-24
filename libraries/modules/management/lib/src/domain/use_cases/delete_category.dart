import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../repositories/management_repository.dart';

// ignore: one_member_abstracts
abstract class IDeleteCategory {
  Future<Either<Failure, int>> call(String id);
}

class DeleteCategory implements IDeleteCategory {
  final ManagementRepository repository;

  DeleteCategory(this.repository);

  @override
  Future<Either<Failure, int>> call(String id) async {
    return repository.deleteCategory(id);
  }
}
