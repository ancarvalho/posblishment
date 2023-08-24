import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class PaymentFloatingWidget extends StatelessWidget {
  const PaymentFloatingWidget({super.key, required this.billTotal});

  final BillTotal billTotal;

  @override
  Widget build(BuildContext context) {

    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            // crossAxisAlignment: CrossAxisAlignment.center,
            child: Text(
                billTotal.payment != null
                    ? "Total Pago:\n ${CurrencyInputFormatter.formatRealCurrency(billTotal.payment)}"
                    : "",
                style: const TextStyle(fontSize: 18),),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),),
                backgroundColor: const Color.fromARGB(255, 0, 255, 195),
                minimumSize: const Size(30, 30),
                // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                // alignment: Alignment.centerLeft
              ),
              child: const Icon(
                Icons.send,
                color: Color.fromARGB(255, 13, 71, 161),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
                "Total: ${CurrencyInputFormatter.formatRealCurrency(billTotal.total)}",
                style: const TextStyle(fontSize: 18),),
            Text(
                "Subtotal: ${CurrencyInputFormatter.formatRealCurrency(billTotal.subtotal)}",
                style: const TextStyle(fontSize: 16),),
            Text(
                "Restante: ${CurrencyInputFormatter.formatRealCurrency(billTotal.total - (billTotal.payment ?? 0))}",
                style: const TextStyle(fontSize: 18),),
          ],
        ),
      ],
    );
  }
}
