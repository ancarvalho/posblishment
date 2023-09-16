import '../../domain/entities/entities.dart';
import '../../domain/enums/frequency.dart';

abstract class StatisticsDataSource {
  Future<BasicStatistics> getBasicStatistics(Frequency frequency);
  Future<List<ItemSold>> getMostSoldProducts(Frequency frequency);
  Future<List<ItemSold>> getMostSoldProductsByCategory(Frequency frequency, String categoryId);

}
