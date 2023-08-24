import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import '../entities/basic_statistics.dart';
import '../enums/frequency.dart';

import '../repositories/statistics_repository.dart';



// ignore: one_member_abstracts
abstract class IGetBasicStats {
  Future<Either<Failure, BasicStatistics>> call(Frequency frequency);
}

class GetBasicStats implements IGetBasicStats {
  final StatisticsRepository repository;

  GetBasicStats(this.repository);

  @override
  Future<Either<Failure, BasicStatistics>> call(Frequency frequency) async {
    return repository.getBasicStatistics(frequency);
  }
}
