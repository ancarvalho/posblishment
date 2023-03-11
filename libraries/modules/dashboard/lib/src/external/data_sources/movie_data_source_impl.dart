import "package:core/core.dart";

import '../../domain/entities/basic_statistics.dart';
import '../../infra/data_sources/movie_data_source.dart';

class DashboardDataSourceImpl implements DashboardDataSource {


  DashboardDataSourceImpl();

  @override
  Future<List<BasicStatistics>> getMostSoldProductsByCategoryThisMonth() {
    // TODO: implement getMostSoldProductsByCategoryThisMonth
    throw UnimplementedError();
  }

  @override
  Future<List<BasicStatistics>> getMostSoldProductsByCategoryThisToday() {
    // TODO: implement getMostSoldProductsByCategoryThisToday
    throw UnimplementedError();
  }

  @override
  Future<List<BasicStatistics>> getMostSoldProductsByCategoryThisWeek() {
    // TODO: implement getMostSoldProductsByCategoryThisWeek
    throw UnimplementedError();
  }

  @override
  Future<List<BasicStatistics>> getMostSoldProductsThisMonth() {
    // TODO: implement getMostSoldProductsThisMonth
    throw UnimplementedError();
  }

  @override
  Future<List<BasicStatistics>> getMostSoldProductsThisToday() {
    // TODO: implement getMostSoldProductsThisToday
    throw UnimplementedError();
  }

  @override
  Future<List<BasicStatistics>> getMostSoldProductsThisWeek() {
    // TODO: implement getMostSoldProductsThisWeek
    throw UnimplementedError();
  }

  @override
  Future<BasicStatistics> getThisMonthStats() {
    // TODO: implement getThisMonthStats
    throw UnimplementedError();
  }

  @override
  Future<BasicStatistics> getThisWeekStats() {
    // TODO: implement getThisWeekStats
    throw UnimplementedError();
  }

  @override
  Future<BasicStatistics> getTodayStats() {
    throw UnimplementedError();
  }
}
