import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/entities.dart' as e;
import '../repositories/management_repository.dart';

abstract class IDeleteCategory {
  Future<Either<Failure, e.Category>> call(String id);
}

class DeleteCategory implements IDeleteCategory {
  final ManagementRepository repository;

  DeleteCategory(this.repository);

  @override
  Future<Either<Failure, e.Category>> call(String id) async {
    return repository.deleteCategory(id);
  }
}
