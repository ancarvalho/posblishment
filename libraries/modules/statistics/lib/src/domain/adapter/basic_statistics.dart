import 'package:core/core.dart';
import 'package:statistics/src/domain/entities/entities.dart';

class BasicStatisticsAdapter {
  static BasicStatistics convertFromCalculateTotal(
      List<RaWBillSubtotal> billsSubtotal) {
    final billStatistics = BasicStatistics.empty();

    for (final bill in billsSubtotal) {
      final billTotal =
          calculateTotal(bill.subtotal, bill.billType, bill.value);
  
      billStatistics
        ..commission += bill.totalPaid - billTotal.subtotal
        ..total += bill.totalPaid > billTotal.total ? billTotal.total : bill.totalPaid
        ..subtotal += billTotal.subtotal;
    }
    return billStatistics;
  }
}
