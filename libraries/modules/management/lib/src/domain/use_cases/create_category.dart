import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/entities.dart' as e;
import '../repositories/management_repository.dart';

abstract class ICreateCategory {
  Future<Either<Failure, e.Category>> call(e.Category category);
}

class CreateCategory implements ICreateCategory {
  final ManagementRepository repository;

  CreateCategory(this.repository);

  @override
  Future<Either<Failure, e.Category>> call(e.Category category) async {
    return repository.createCategory(category);
  }
}
