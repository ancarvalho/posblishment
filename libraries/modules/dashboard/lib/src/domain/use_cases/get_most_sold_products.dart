import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import 'package:dashboard/src/domain/entities/entities.dart';

import '../enums/frequency.dart';
import '../repositories/dashboard_repository.dart';



class GetMostSoldProducts  {
  final DashboardRepository repository;

  GetMostSoldProducts(this.repository);

 
  Future<Either<Failure, List<ItemsSold>>> call(Frequency frequency) async {
    return repository.getMostSoldProducts(frequency);
  }
}
