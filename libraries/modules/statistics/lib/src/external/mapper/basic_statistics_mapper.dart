import '../../domain/entities/basic_statistics.dart';

class BasicStatisticsMapper {
  // static List<BasicStatistics> fromMapList(Map<String, dynamic> map) =>
  //     List<BasicStatistics>.from(
  //         (map["data"] ?? []).map(BasicStatisticsMapper.fromMap),);

  static BasicStatistics fromMap(dynamic map) {
    return BasicStatistics(
      total: map["total"],
      subtotal: map["subtotal"],
      commission: map["commission"],
     notPaid:  map["notPaid"],
    );
  }
}
