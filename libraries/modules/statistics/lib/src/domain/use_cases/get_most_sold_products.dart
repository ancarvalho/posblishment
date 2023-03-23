import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/entities.dart';
import '../enums/frequency.dart';
import '../repositories/statistics_repository.dart';

abstract class IGetMostSoldProducts {
  Future<List<ItemsSold>> call(Frequency frequency);
}

class GetMostSoldProducts implements IGetMostSoldProducts  {
  final StatisticsRepository repository;

  GetMostSoldProducts(this.repository);

 @override
  Future<List<ItemsSold>> call(Frequency frequency) async {
    return repository.getMostSoldProducts(frequency);
  }
}
