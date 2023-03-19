import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:dashboard/src/domain/entities/basic_statistics.dart';
import 'package:dashboard/src/domain/entities/items_sold.dart';
import 'package:dashboard/src/domain/enums/frequency.dart';

import '../../domain/repositories/dashboard_repository.dart';

class DashboardRepositoryDummyImpl implements DashboardRepository {
  @override
  Future<Either<Failure, BasicStatistics>> getBasicStatistics(
    Frequency frequency,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
    return Right(
      BasicStatistics(
        commission: 400,
        notPaid: 3002,
        subtotal: 1201,
        total: 1600,
      ),
    );
  }

  @override
  Future<List<ItemsSold>> getMostSoldProducts(
    Frequency frequency,
  ) async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      ItemsSold(
        id: "a8sda-da9sdi-asddaw-123a",
        name: "Peixada de Carapeba",
        totalQuantity: 13,
      ),
      ItemsSold(
        id: "a8sda-da9sdi-asddaw-113d",
        name: "Peixada de Arabaiana",
        totalQuantity: 31,
      ),
      ItemsSold(
        id: "a8sda-da9sdi-asddaw-131a",
        name: "Peixada de Cavala",
        totalQuantity: 18,
      ),
      ItemsSold(
        id: "a8sda-da9sdi-asddaw-131a",
        name: "Peixada ao Molho de Camarão",
        totalQuantity: 16,
      ),
      ItemsSold(
        id: "a8sda-da9sdi-asddaw-131a",
        name: "Camarãozada",
        totalQuantity: 22,
      ),
    ];
  }

  @override
  Future<Either<Failure, List<BasicStatistics>>>
      getMostSoldProductsByCategoryThisMonth() async {
    await Future.delayed(const Duration(seconds: 1));
    return Right([
      BasicStatistics(
        commission: 400,
        notPaid: 3002,
        subtotal: 1201,
        total: 1200,
      ),
      BasicStatistics(
        commission: 400,
        notPaid: 3002,
        subtotal: 1201,
        total: 1200,
      ),
      BasicStatistics(
        commission: 400,
        notPaid: 3002,
        subtotal: 1201,
        total: 1200,
      ),
    ]);
  }

  @override
  Future<Either<Failure, List<BasicStatistics>>>
      getMostSoldProductsByCategoryThisToday() async {
    await Future.delayed(const Duration(seconds: 1));
    return Right([
      BasicStatistics(
        commission: 400,
        notPaid: 3002,
        subtotal: 1201,
        total: 1200,
      ),
      BasicStatistics(
        commission: 400,
        notPaid: 3002,
        subtotal: 1201,
        total: 1200,
      ),
      BasicStatistics(
        commission: 400,
        notPaid: 3002,
        subtotal: 1201,
        total: 1200,
      ),
    ]);
  }

  @override
  Future<Either<Failure, List<BasicStatistics>>>
      getMostSoldProductsByCategoryThisWeek() async {
    await Future.delayed(const Duration(seconds: 1));
    return Right([
      BasicStatistics(
        commission: 400,
        notPaid: 3002,
        subtotal: 1201,
        total: 1200,
      ),
      BasicStatistics(
        commission: 400,
        notPaid: 3122,
        subtotal: 1211,
        total: 1200,
      ),
      BasicStatistics(
        commission: 400,
        notPaid: 1231,
        subtotal: 1201,
        total: 1200,
      ),
    ]);
  }
}
