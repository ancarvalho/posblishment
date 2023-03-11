import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/basic_statistics.dart';

abstract class DashboardRepository {
  Future<Either<Failure, BasicStatistics>> getTodayStats();
  Future<Either<Failure, BasicStatistics>> getThisWeekStats();
  Future<Either<Failure, BasicStatistics>> getThisMonthStats();
  Future<Either<Failure, List<BasicStatistics>>> getMostSoldProductsThisToday();
  Future<Either<Failure, List<BasicStatistics>>> getMostSoldProductsThisWeek();
  Future<Either<Failure, List<BasicStatistics>>> getMostSoldProductsThisMonth();
  Future<Either<Failure, List<BasicStatistics>>> getMostSoldProductsByCategoryThisToday();
  Future<Either<Failure, List<BasicStatistics>>> getMostSoldProductsByCategoryThisWeek();
  Future<Either<Failure, List<BasicStatistics>>> getMostSoldProductsByCategoryThisMonth();
}
