import '../../domain/entities/basic_statistics.dart';

abstract class DashboardDataSource {
  Future<BasicStatistics> getTodayStats();
  Future<BasicStatistics> getThisWeekStats();
  Future<BasicStatistics> getThisMonthStats();
  Future<List<BasicStatistics>> getMostSoldProductsThisToday();
  Future<List<BasicStatistics>> getMostSoldProductsThisWeek();
  Future<List<BasicStatistics>> getMostSoldProductsThisMonth();
  Future<List<BasicStatistics>> getMostSoldProductsByCategoryThisToday();
  Future<List<BasicStatistics>> getMostSoldProductsByCategoryThisWeek();
  Future<List<BasicStatistics>> getMostSoldProductsByCategoryThisMonth();
}
