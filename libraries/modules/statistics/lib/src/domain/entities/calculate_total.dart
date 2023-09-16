import 'package:core/core.dart';

class RaWBillSubtotal {
  final double totalPaid;
  final double subtotal;
  final BillTypes billType;
  final double? value;

  RaWBillSubtotal({
    required this.totalPaid,
    required this.subtotal,
    required this.billType,
    this.value,
  });
}
