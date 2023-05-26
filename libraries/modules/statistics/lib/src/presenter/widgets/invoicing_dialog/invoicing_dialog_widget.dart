import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class InvoicingDialogWidget extends StatelessWidget {
  final double subtotal, commission, total;
  const InvoicingDialogWidget({
    Key? key,
    required this.subtotal,
    required this.commission,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Faturado'),
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(4),
          padding: EdgeInsets.all(Sizes.dp12(context)),
          decoration: BoxDecoration(
            border: Border.all(
              width: Sizes.dp4(context),
              color: Theme.of(context).colorScheme.secondary,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: Sizes.dp5(context),
              ),
              Row(
                children: [
                  const Text("Total"),
                  const Spacer(),
                  Text(
                    "R\$ $total",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 181, 15),
                      fontSize: Sizes.dp23(context),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text("Subtotal"),
                  const Spacer(),
                  Text(
                    "R\$ $subtotal",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 181, 15),
                      fontSize: Sizes.dp23(context),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                   const Text("Comissão"),
                   const Spacer(),
                  Text(
                    "R\$ $commission",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 181, 15),
                      fontSize: Sizes.dp23(context),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
