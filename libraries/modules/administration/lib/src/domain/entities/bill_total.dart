class BillTotal {
  final double total;
  final double subtotal;
  final double commission;
  late final double? payment;

  BillTotal( {
    required this.total,
    required this.subtotal,
    this.payment,
    required this.commission,
  });
}
