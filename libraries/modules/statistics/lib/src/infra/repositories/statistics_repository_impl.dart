import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:statistics/src/infra/data_source/statistics_data_source.dart';
import '../../domain/entities/entities.dart';
import '../../domain/enums/frequency.dart';

import '../../domain/errors/dashboard_failures.dart';
import '../../domain/repositories/statistics_repository.dart';

class StatisticsRepositoryImpl implements StatisticsRepository {
  final StatisticsDataSource _statisticsDataSource;

  StatisticsRepositoryImpl(this._statisticsDataSource);

  @override
  Future<Either<Failure, BasicStatistics>> getBasicStatistics(Frequency frequency) async {
    try {
      return Right(await _statisticsDataSource.getBasicStatistics(frequency));
    } catch (e, s) {
      return Left(StatisticsError(s, "StatisticsModule-getBasicStatistics", e, e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ItemSold>>> getMostSoldProducts(Frequency frequency) async {
    try {
      return Right(await _statisticsDataSource.getMostSoldProducts(frequency));
    } catch (e, s) {
      return Left(StatisticsError(s, "StatisticsModule-getBasicStatistics", e, e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ItemSold>>> getMostSoldProductsByCategory(Frequency frequency, String categoryId) async {
    try {
      return Right(await _statisticsDataSource.getMostSoldProductsByCategory( frequency, categoryId));
    } catch (e, s) {
      return Left(StatisticsError(s, "StatisticsModule-getBasicStatistics", e, e.toString()));
    }
  }


}
