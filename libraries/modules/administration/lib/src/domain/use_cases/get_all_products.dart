import 'package:administration/src/domain/repositories/administration_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';


abstract class IGetAllProducts {
  Future<Either<Failure, List<Product>>> call();
}

class GetAllProducts implements IGetAllProducts {
  final AdministrationRepository repository;

  GetAllProducts(this.repository);

  @override
  Future<Either<Failure, List<Product>>> call() async {
    return repository.getAllProducts();
  }
}
