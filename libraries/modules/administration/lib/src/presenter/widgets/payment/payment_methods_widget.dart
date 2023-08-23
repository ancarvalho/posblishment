import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../domain/utils/payment_types.dart';

class PaymentMethodsWidget extends StatelessWidget {
  const PaymentMethodsWidget(
      {super.key, required this.paymentType, required this.selectPaymentType});
  final PaymentType paymentType;
  final void Function(PaymentType paymentType) selectPaymentType;

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      onPressed: (index) {
        selectPaymentType(PaymentTypes.values.elementAt(index).value);
      },
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      selectedBorderColor: const Color.fromARGB(255, 0, 120, 218),
      selectedColor: Colors.white,
      fillColor: const Color.fromARGB(255, 0, 62, 133),
      color: const Color.fromARGB(255, 0, 104, 195),
      constraints: const BoxConstraints(
        minHeight: 35.0,
        minWidth: 80.0,
      ),
      isSelected: PaymentTypes.values.map((e) => e.value == paymentType).toList(),
      children: [
        ...PaymentTypes.values
            .map((e) => Padding(
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    e.icon,
                    size: 26,
                  ),
                ))
            .toList()
      ],
    );
  }
}
