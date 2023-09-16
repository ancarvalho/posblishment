import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/entities.dart';
import '../enums/frequency.dart';

abstract class StatisticsRepository {
  Future<Either<Failure, BasicStatistics>> getBasicStatistics(Frequency frequency);
  Future<Either<Failure, List<ItemSold>>> getMostSoldProducts(Frequency frequency);
  Future<Either<Failure, List<ItemSold>>>  getMostSoldProductsByCategory(Frequency frequency, String categoryId);

}
