import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/entities.dart';
import '../enums/frequency.dart';

abstract class StatisticsRepository {
  Future<Either<Failure, BasicStatistics>> getBasicStatistics(
      Frequency frequency);
  Future<List<ItemsSold>> getMostSoldProducts(Frequency frequency);
  Future<Either<Failure, List<BasicStatistics>>>
      getMostSoldProductsByCategoryThisToday();
  Future<Either<Failure, List<BasicStatistics>>>
      getMostSoldProductsByCategoryThisWeek();
  Future<Either<Failure, List<BasicStatistics>>>
      getMostSoldProductsByCategoryThisMonth();
}
