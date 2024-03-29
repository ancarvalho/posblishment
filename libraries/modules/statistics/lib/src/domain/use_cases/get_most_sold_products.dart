import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/entities.dart';
import '../enums/frequency.dart';
import '../repositories/statistics_repository.dart';



// ignore: one_member_abstracts
abstract class IGetMostSoldProducts {
  Future<Either<Failure,List<ItemSold>>> call(Frequency frequency);
}

class GetMostSoldProducts implements IGetMostSoldProducts  {
  final StatisticsRepository repository;

  GetMostSoldProducts(this.repository);

 @override
  Future<Either<Failure,List<ItemSold>>> call(Frequency frequency) async {
    return repository.getMostSoldProducts(frequency);
  }
}
