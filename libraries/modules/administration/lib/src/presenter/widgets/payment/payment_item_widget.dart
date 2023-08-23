import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class PaymentItemWidget extends StatelessWidget {
  const PaymentItemWidget({super.key, required this.payment, required this.removePayment});
  final NewPayment payment;
  final void Function() removePayment;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress:removePayment,
      child: Text(
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          "${CurrencyInputFormatter.formatRealCurrency(payment.value)} ${payment.paymentType.name}"),
    );
  }
}
