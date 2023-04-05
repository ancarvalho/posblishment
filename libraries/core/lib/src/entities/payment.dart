
enum PaymentType {
  creditCard,
  debitCard,
  cash,
  pix,
}

class Payment {
  final String id;
  final double value;
  final PaymentType paymentType;
  final String billId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Payment(
      {required this.id,
      required this.value,
      required this.paymentType,
      required this.billId,
      required this.createdAt,
      required this.updatedAt,});
}
