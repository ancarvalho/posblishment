import "package:core/core.dart";

abstract class PaymentRepository {
  Future<bool> makePayment(String id);
  Future<bool> cancelPayment(String id);

    //
  Future<bool> createPayment(Payment payment);
  Future<bool> updatePayment(Payment payment);
}
