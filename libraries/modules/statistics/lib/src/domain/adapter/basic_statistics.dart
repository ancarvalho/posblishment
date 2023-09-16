import 'package:core/core.dart';
import 'package:statistics/src/domain/entities/entities.dart';

class BasicStatisticsAdapter {
  static BasicStatistics convertFromCalculateTotal(List<RaWBillSubtotal> billsSubtotal) {
    final billStatistics = BasicStatistics.empty();

    for (final bill in billsSubtotal) {
      final billTotal = calculateTotal(bill.subtotal, bill.billType, bill.value);
      if (billTotal.total < bill.totalPaid) {
        billTotal.payment = billTotal.total;
      } else {
        billTotal.payment = bill.totalPaid;
      }
      billStatistics
      ..commission += billTotal.commission
      ..total += billTotal.total
      ..subtotal += billTotal.subtotal;
    }
    return billStatistics;
  }
}
