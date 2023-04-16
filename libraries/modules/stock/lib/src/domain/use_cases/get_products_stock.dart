import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/product_stock.dart';
import '../repositories/stock_control_repository.dart';


abstract class IGetProductsStock {
  Future<Either<Failure, List<ProductStock>>> call();
}

class GetProductsStock implements IGetProductsStock {
  final StockControlRepository repository;

  GetProductsStock(this.repository);

  @override
  Future<Either<Failure, List<ProductStock>>> call() async {
    return repository.getProductsStock();
  }
}
