class BasicStatistics {
  double total;
  double subtotal;
  double commission;
  double notPaid;

  BasicStatistics({
    required this.total,
    required this.subtotal,
    required this.commission,
    required this.notPaid,
  });

  factory BasicStatistics.empty() {
    return BasicStatistics(commission: 0, notPaid: 0, subtotal: 0, total: 0);
  }
}
