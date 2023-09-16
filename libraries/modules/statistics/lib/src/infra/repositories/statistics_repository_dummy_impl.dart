// import 'package:core/core.dart';
// import 'package:dartz/dartz.dart';
// import '../../domain/entities/entities.dart';
// import '../../domain/enums/frequency.dart';

// import '../../domain/repositories/statistics_repository.dart';

// class StatisticsRepositoryDummyImpl implements StatisticsRepository {
  

//   @override
//   Future<Either<Failure, BasicStatistics>> getBasicStatistics(
//     Frequency frequency,
//   ) async {
//     await Future.delayed(const Duration(seconds: 1));
//     return Right(
//       BasicStatistics(
//         commission: 400,
//         notPaid: 3002,
//         subtotal: 1201,
//         total: 1600,
//       ),
//     );
//   }

//   @override
//   Future<Either<Failure, List<ItemsSold>>> getMostSoldProducts(
//     Frequency frequency,
//   ) async {
//     await Future.delayed(const Duration(seconds: 1));

//     return Right([
//       ItemsSold(
//         id: "a8sda-da9sdi-as1d3w-a8sda",
//         name: "Peixada de Carapeba",
//         totalQuantity: 13,
//       ),
//       ItemsSold(
//         id: "a8sda-da9sdi-asd1da-113d",
//         name: "Peixada de Arabaiana",
//         totalQuantity: 31,
//       ),
//       ItemsSold(
//         id: "a8sda-da9sdi-131a-131a",
//         name: "Peixada de Cavala",
//         totalQuantity: 18,
//       ),
//       ItemsSold(
//         id: "a8sda-da9sdi-a8sda-131a",
//         name: "Peixada ao Molho de Camarão",
//         totalQuantity: 16,
//       ),
//       ItemsSold(
//         id: "a8sda-da9sdi-da9sdi-131a",
//         name: "Camarãozada",
//         totalQuantity: 22,
//       ),
//     ]);
//   }

//   @override
//   Future<Either<Failure, List<BasicStatistics>>>
//       getMostSoldProductsByCategoryThisMonth() async {
//     await Future.delayed(const Duration(seconds: 1));
//     return Right([
//       BasicStatistics(
//         commission: 400,
//         notPaid: 3002,
//         subtotal: 1201,
//         total: 1200,
//       ),
//       BasicStatistics(
//         commission: 400,
//         notPaid: 3002,
//         subtotal: 1201,
//         total: 1200,
//       ),
//       BasicStatistics(
//         commission: 400,
//         notPaid: 3002,
//         subtotal: 1201,
//         total: 1200,
//       ),
//     ]);
//   }

//   @override
//   Future<Either<Failure, List<BasicStatistics>>>
//       getMostSoldProductsByCategoryThisToday() async {
//     await Future.delayed(const Duration(seconds: 1));
//     return Right([
//       BasicStatistics(
//         commission: 400,
//         notPaid: 3002,
//         subtotal: 1201,
//         total: 1200,
//       ),
//       BasicStatistics(
//         commission: 400,
//         notPaid: 3002,
//         subtotal: 1201,
//         total: 1200,
//       ),
//       BasicStatistics(
//         commission: 400,
//         notPaid: 3002,
//         subtotal: 1201,
//         total: 1200,
//       ),
//     ]);
//   }

//   @override
//   Future<Either<Failure, List<BasicStatistics>>>
//       getMostSoldProductsByCategoryThisWeek() async {
//     await Future.delayed(const Duration(seconds: 1));
//     return Right([
//       BasicStatistics(
//         commission: 400,
//         notPaid: 3002,
//         subtotal: 1201,
//         total: 1200,
//       ),
//       BasicStatistics(
//         commission: 400,
//         notPaid: 3122,
//         subtotal: 1211,
//         total: 1200,
//       ),
//       BasicStatistics(
//         commission: 400,
//         notPaid: 1231,
//         subtotal: 1201,
//         total: 1200,
//       ),
//     ]);
//   }
// }
