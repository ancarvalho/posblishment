import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/product_stock.dart';



abstract class StockControlRepository {
  Future<Either<Failure, List<ProductStock>>> getProductsStock();
  Future<Either<Failure, ProductStock>> increaseProductStock(String id, int quantity);
  Future<Either<Failure, ProductStock>> decreaseProductStock(String id, int quantity);
}
