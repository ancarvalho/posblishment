import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'payment_store.dart';

class PaymentController extends Disposable {
  ValueNotifier<List<NewPayment>> payment = ValueNotifier([]);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController valueController = TextEditingController();
  final ValueNotifier<PaymentType> _currentPaymentType =
      ValueNotifier(PaymentType.creditCard);

  final PaymentStore _paymentStore = Modular.get<PaymentStore>();

  // late final double totalRemaining;

  PaymentType get currentPaymentType => _currentPaymentType.value;
  void setCurrentPaymentType(PaymentType paymentType) =>
      _currentPaymentType.value = paymentType;

  double calculateTotalRemaining() {
    final paymentsTotal = payment.value.fold(_paymentStore.state.payment ?? 0.0,
        (previousValue, element) => element.value + previousValue);

    return _paymentStore.state.total - paymentsTotal;
  }

  void addHalfTotal() {
    final value = calculateTotalRemaining() / 2;

    payment.value.add(
      NewPayment(
        value: value,
        paymentType: _currentPaymentType.value,
      ),
    );
  }

  void addRemainingValue() {
    final value = calculateTotalRemaining();

    payment.value.add(
      NewPayment(
        value: value,
        paymentType: _currentPaymentType.value,
      ),
    );
  }

  void addValueWithoutCommission() {
    final value = _paymentStore.state.subtotal - calculateTotalRemaining();

    payment.value.add(
      NewPayment(
        value: value,
        paymentType: _currentPaymentType.value,
      ),
    );
  }

  void addValueToPayment() {
    final value = CurrencyInputFormatter.formatToDouble(valueController.text);
    if (value != null && formKey.currentState!.validate()) {
      payment.value.add(
        NewPayment(
          value: value,
          paymentType: _currentPaymentType.value,
        ),
      );
    } else {}
  }

  void clearPayments() {
    payment.value.clear();
  }

  void removePayment(int index) {
    payment.value.removeAt(index);
  }

  @override
  void dispose() {
    valueController.dispose();
  }
}
