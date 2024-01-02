import 'package:core/core.dart';
import 'package:statistics/src/domain/entities/entities.dart';

class BasicStatisticsAdapter {
  static BasicStatistics convertFromCalculateTotal(
      List<RaWBillSubtotal> billsSubtotal) {
    final billStatistics = BasicStatistics.empty();

    for (final bill in billsSubtotal) {
      final billTotal =
          calculateTotal(bill.subtotal, bill.billType, bill.value);

      final commission = bill.totalPaid > billTotal.total
          ? billTotal.total - billTotal.subtotal
          : bill.totalPaid - billTotal.subtotal;

      billStatistics
        ..commission += commission
        ..total += billTotal.total
        ..subtotal += billTotal.subtotal;
    }
    return billStatistics;
  }
}
