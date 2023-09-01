import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class PaymentFloatingWidget extends StatelessWidget {
  const PaymentFloatingWidget({
    super.key,
    required this.billTotal,
    required this.calculateRemaining,
    required this.finalizeBill,
  });

  final BillTotal billTotal;
  final double Function() calculateRemaining;
  final void Function() finalizeBill;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 26),
          child: Align(
            alignment: Alignment.bottomCenter,
            // crossAxisAlignment: CrossAxisAlignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                 if (billTotal.total - calculateRemaining() > 0) Text(
                  "Soma Total: ${CurrencyInputFormatter.formatRealCurrency(billTotal.total - calculateRemaining())}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (billTotal.payment != null && billTotal.payment! > 0)
                  Text(
                    "Total Pago: ${CurrencyInputFormatter.formatRealCurrency(billTotal.payment)}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                
              ],
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextButton(
              onPressed: finalizeBill,
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
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
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              "Subtotal: ${CurrencyInputFormatter.formatRealCurrency(billTotal.subtotal)}",
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              "Restante: ${CurrencyInputFormatter.formatRealCurrency(calculateRemaining())}",
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ],
    );
  }
}
