import 'package:core/src/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/category.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/management_repository.dart';

class ManagementRepositoryDummyImpl implements ManagementRepository {
  @override
  Future<Either<Failure, Category>> createCategory(Category category) async {
    await Future.delayed(const Duration(seconds: 2));

    return Right(category);
  }

  @override
  Future<Either<Failure, Category>> updateCategory(Category category) async {
    await Future.delayed(const Duration(seconds: 2));

    return Right(category);
  }

  @override
  Future<Either<Failure, Category>> deleteCategory(String id) async {
    await Future.delayed(const Duration(seconds: 2));

    return Right(
      Category(
        id: id,
        name: "Not Available",
        description: "Not Available",
      ),
    );
  }

  @override
  Future<Either<Failure, Product>> createProduct(Product product) async {
    await Future.delayed(const Duration(seconds: 2));

    return Right(product);
  }

  @override
  Future<Either<Failure, Product>> updateProduct(Product product) async {
    await Future.delayed(const Duration(seconds: 2));

    return Right(product);
  }

  @override
  Future<Either<Failure, Product>> deleteProduct(String id) async {
    await Future.delayed(const Duration(seconds: 2));

    return Right(
      Product(
        id: id,
        name: "Not Available",
        unitValue: 0,
      ),
    );
  }

  @override
  Future<Either<Failure, List<Category>>> listAllCategories() async {
    await Future.delayed(const Duration(seconds: 2));

    return Right([
      Category(
        id: "1279407d-d8e2-48d8-8943-7bd785be84a1",
        name: "Petiscos",
        description: "Categoria de Petiscos",
      ),
      Category(
        id: "2c095eec-f086-4356-b48b-f9cb834000b7",
        name: "Almoços",
        description: "Categoria de Almoços",
      ),
      Category(
        id: "5bf1f71b-73d1-4065-9d9c-011bdbf60161",
        name: "Bebidas",
        description: "Categoria de Bebidas",
      ),
      Category(
        id: "1cffe167-1732-4ea0-8b71-d7a247b5460a",
        name: "Sobremesas",
        description: "Categoria de Sobremesas",
      ),
    ]);
  }

  @override
  Future<Either<Failure, List<Product>>> listAllProducts() async {
    await Future.delayed(const Duration(seconds: 2));

    return Right([
      Product(
        id: "1f13d370-bee8-4abe-9eee-240e3b2cd9ee",
        name: "Peixada de Arabaiana",
        unitValue: 20.5,
        code: 2,
        description: "Pirão, arroz, vinagrete, farofa, ",
      ),
      Product(
        id: "58cd0050-2842-42c9-92c7-0eaf6f36c436",
        name: "Peixada de Cavala",
        unitValue: 20.5,
        code: 2,
        description: "Pirão, arroz, vinagrete, farofa, ",
      ),
      Product(
        id: "afe3d0da-47d2-423a-8358-028a7d4b0bd7",
        name: "Peixada de Carapeba",
        unitValue: 20.5,
        code: 2,
        description: "Pirão, arroz, vinagrete, farofa, ",
      ),
      Product(
        id: "2ce46f70-80a3-49cd-993f-c57726027fe5",
        name: "Peixada ao molho de camarão",
        unitValue: 20.5,
        code: 2,
        description: "Pirão, arroz, vinagrete, farofa, ",
      ),
      Product(
        id: "8b6b6cbd-7110-4284-ab26-3116cba3d5b1",
        name: "Cacao completo",
        unitValue: 20.5,
        code: 2,
        description: "Pirão, arroz, vinagrete, farofa, ",
      ),
      Product(
        id: "0e35236e-8603-4e3a-adeb-4c95be887e7e",
        name: "Sirizada",
        unitValue: 20.5,
        code: 2,
        description: "Pirão, arroz, vinagrete, farofa, ",
      ),
    ]);
  }
}
