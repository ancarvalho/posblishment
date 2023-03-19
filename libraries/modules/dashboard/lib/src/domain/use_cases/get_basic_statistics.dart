import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:dashboard/src/domain/entities/basic_statistics.dart';
import 'package:dashboard/src/domain/enums/frequency.dart';

import '../repositories/dashboard_repository.dart';

abstract class IGetBasicStats {
  Future<Either<Failure, BasicStatistics>> call(Frequency frequency);
}

class GetBasicStats implements IGetBasicStats {
  final DashboardRepository repository;

  GetBasicStats(this.repository);

  @override
  Future<Either<Failure, BasicStatistics>> call(Frequency frequency) async {
    return repository.getBasicStatistics(frequency);
  }
}
