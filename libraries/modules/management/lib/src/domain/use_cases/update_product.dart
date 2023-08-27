import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../repositories/management_repository.dart';

// ignore: one_member_abstracts
abstract class IUpdateProduct {
  Future<Either<Failure, int>> call(UpdateProductModel product);
}

class UpdateProduct implements IUpdateProduct {
  final ManagementRepository repository;

  UpdateProduct(this.repository);

  @override
  Future<Either<Failure, int>> call(UpdateProductModel product) async {
    return repository.updateProduct(product);
  }
}
