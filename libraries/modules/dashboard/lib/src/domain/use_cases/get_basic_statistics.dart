import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:dashboard/src/domain/entities/basic_statistics.dart';

import '../repositories/dashboard_repository.dart';



class GetBasicStats  {
  final DashboardRepository repository;

  GetBasicStats(this.repository);

 
  Future<Either<Failure, BasicStatistics>> call(String frequency) async {
    return repository.getBasicStatistics(frequency);
  }
}
