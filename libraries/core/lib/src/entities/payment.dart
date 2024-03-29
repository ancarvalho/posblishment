import '../enums/enums.dart';

class Payment {
  final String id;
  final double value;
  final PaymentType paymentType;
  final String? billId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  const Payment({
    required this.id,
    required this.value,
    required this.paymentType,
    this.billId,
    required this.createdAt,
    required this.updatedAt,
  });
}

class NewPayment {
  final double value;
  final PaymentType paymentType;
  final String? billId;

  const NewPayment({
    required this.value,
    required this.paymentType,
    this.billId,
  });
}
