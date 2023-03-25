import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/product_stock.dart';
import '../repositories/stock_control_repository.dart';


abstract class IIncreaseProductStock {
  Future<Either<Failure, ProductStock>> call(String id, int quantity);
}

class IncreaseProductStock implements IIncreaseProductStock {
  final StockControlRepository repository;

  IncreaseProductStock(this.repository);

  @override
  Future<Either<Failure, ProductStock>> call(String id, int quantity) async {
    return repository.increaseProductStock(id, quantity);
  }
}