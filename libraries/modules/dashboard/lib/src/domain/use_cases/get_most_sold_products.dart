import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import 'package:dashboard/src/domain/entities/entities.dart';

import '../enums/frequency.dart';
import '../repositories/dashboard_repository.dart';

abstract class IGetMostSoldProducts {
  Future<List<ItemsSold>> call(Frequency frequency);
}

class GetMostSoldProducts implements IGetMostSoldProducts  {
  final DashboardRepository repository;

  GetMostSoldProducts(this.repository);

 @override
  Future<List<ItemsSold>> call(Frequency frequency) async {
    return repository.getMostSoldProducts(frequency);
  }
}
