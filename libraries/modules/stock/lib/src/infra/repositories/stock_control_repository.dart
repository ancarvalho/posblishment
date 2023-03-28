import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/product_stock.dart';
import '../../domain/repositories/stock_control_repository.dart';

class StockControlRepositoryDummyImpl implements StockControlRepository {
  @override
  Future<Either<Failure, List<ProductStock>>> getProductsStock() async {
    await Future.delayed(const Duration(seconds: 2));

    return Right([
      ProductStock(name: "Peixada de Arabaiana", totalAvailable: 15),
      ProductStock(name: "Peixada de Cavala", totalAvailable: 15),
      ProductStock(name: "Peixada ao Molho de Camarão", totalAvailable: 15),
      ProductStock(name: "Peixada de Carapeba", totalAvailable: 15),
    ]);
  }

  @override
  Future<Either<Failure, ProductStock>> decreaseProductStock(
    String id,
    int quantity,
  ) async {
    await Future.delayed(const Duration(seconds: 2));

    return Right(
      ProductStock(
        name: "Peixada de Arabaiana",
        totalAvailable: 15 + quantity,
        variationName: id,
      ),
    );
  }

  @override
  Future<Either<Failure, ProductStock>> increaseProductStock(
      String id, int quantity) async {
    await Future.delayed(const Duration(seconds: 2));

    return Right(
      ProductStock(
        name: "Peixada de Arabaiana",
        totalAvailable: 15 + quantity,
        variationName: id,
      ),
    );
  }
}
