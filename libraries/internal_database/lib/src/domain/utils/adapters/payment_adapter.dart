import 'package:core/core.dart';
import 'package:internal_database/src/domain/db/sqlite.dart';
import "package:uuid/uuid.dart";

class PaymentAdapter {
  static PaymentData createPayment(Payment payment, String billID) {
    return PaymentData(
      id: const Uuid().v4(),
      paymentType: payment.paymentType,
      value: payment.value,
      billId: billID,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  static Payment convertPayment(PaymentData payment) {
    return Payment(
      id: payment.id,
      createdAt: payment.createdAt,
      paymentType: payment.paymentType,
      updatedAt: payment.updatedAt,
      value: payment.value,
      billId: payment.billId,
    );
  }
}
