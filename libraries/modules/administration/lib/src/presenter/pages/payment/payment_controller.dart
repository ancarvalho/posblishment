import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../stores/bill/bill_total_store.dart';
import 'payment_store.dart';

class PaymentController extends Disposable with ChangeNotifier {
  // TODO change to default set adn get
  ValueNotifier<List<NewPayment>> payments = ValueNotifier([]);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController valueController = TextEditingController();
  final ValueNotifier<PaymentType> _currentPaymentType =
      ValueNotifier(PaymentType.creditCard);

  final PaymentStore _paymentStore = Modular.get<PaymentStore>();
  final _billTotalStore = Modular.get<BillTotalStore>();

  // late final double totalRemaining;

  PaymentType get currentPaymentType => _currentPaymentType.value;
  void setCurrentPaymentType(PaymentType paymentType) {
    _currentPaymentType.value = paymentType;
    notifyListeners();
  }

  double calculateTotalRemaining() {
    final paymentsTotal = payments.value.fold(
      _billTotalStore.state.payment ?? 0.0,
      (previousValue, element) => element.value + previousValue,
    );

    return _billTotalStore.state.total - paymentsTotal;
  }

  double calculateSubtotalRemaining() {
    final paymentsTotal = payments.value.fold(
      _billTotalStore.state.payment ?? 0.0,
      (previousValue, element) => element.value + previousValue,
    );

    return _billTotalStore.state.subtotal - paymentsTotal;
  }

  void addHalfTotal() {
    final value = calculateTotalRemaining() / 2;

    payments.value.add(
      NewPayment(
        value: value,
        paymentType: _currentPaymentType.value,
      ),
    );
    notifyListeners();
  }

  void addRemainingValue() {
    final value = calculateTotalRemaining();

    payments.value.add(
      NewPayment(
        value: value,
        paymentType: _currentPaymentType.value,
      ),
    );
    notifyListeners();
  }

  void addValueWithoutCommission() {
    final value = calculateSubtotalRemaining();
    if (value > 0) {
      payments.value.add(
        NewPayment(
          value: value,
          paymentType: _currentPaymentType.value,
        ),
      );
      notifyListeners();
    }
  }

  void addValueToPayment() {
    final value = CurrencyInputFormatter.formatToDouble(valueController.text);
    if (value != null && formKey.currentState!.validate()) {
      payments.value.add(
        NewPayment(
          value: value,
          paymentType: _currentPaymentType.value,
        ),
      );
    }
    notifyListeners();
  }

  void clearPayments() {
    payments.value.clear();
    notifyListeners();
  }

  void removePayment(int index) {
    payments.value.removeAt(index);
    notifyListeners();
  }

  void finalizeBill(String billID) {
    if (payments.value.isNotEmpty) {
      _paymentStore.finalizeBill(payments.value, billID);
    }
  }

  @override
  void dispose() {
    super.dispose();
    valueController.dispose();
    payments.dispose();
    _currentPaymentType.dispose();
  }
}
