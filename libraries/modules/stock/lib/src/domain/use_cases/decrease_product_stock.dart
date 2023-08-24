import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/product_stock.dart';
import '../repositories/stock_control_repository.dart';



// ignore: one_member_abstracts
abstract class IDecreaseProductStock {
  Future<Either<Failure, ProductStock>> call(String id, int quantity);
}

class DecreaseProductStock implements IDecreaseProductStock {
  final StockControlRepository repository;

  DecreaseProductStock(this.repository);

  @override
  Future<Either<Failure, ProductStock>> call(String id, int quantity) async {
    return repository.decreaseProductStock(id, quantity);
  }
}
