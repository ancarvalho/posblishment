enum BillStatus {
  open(name: "Aberto", value: "open"),
  closed(name: "Fechado", value: "closed"),
  paid(name: "Pago", value: "paid"),
  paidWithoutCommission(name: "Pago Sem Comissão", value: "paid_without_commission"),
  canceled(name: "Cancelada", value: "canceled"),
  partiallyPaid(name: "Parcialmente Pago", value: "partially_paid");

  const BillStatus({required this.name, required this.value});
  final String name;
  final String value;
}
