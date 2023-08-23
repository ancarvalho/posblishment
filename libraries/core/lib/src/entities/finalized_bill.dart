import 'package:core/core.dart';

class FinalizedBill {
  const FinalizedBill(
      {required this.bill, required this.billTotal, required this.payments});
  final Bill bill;
  final BillTotal billTotal;
  final List<Payment> payments;
}
