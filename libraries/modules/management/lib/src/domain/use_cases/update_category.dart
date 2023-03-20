import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/entities.dart' as e;
import '../repositories/management_repository.dart';

abstract class IUpdateCategory {
  Future<Either<Failure, e.Category>> call(e.Category category);
}

class UpdateCategory implements IUpdateCategory {
  final ManagementRepository repository;

  UpdateCategory(this.repository);

  @override
  Future<Either<Failure, e.Category>> call(e.Category category) async {
    return repository.createCategory(category);
  }
}
