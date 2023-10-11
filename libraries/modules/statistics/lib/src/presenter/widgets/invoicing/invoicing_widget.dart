import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class InvoicingWidget extends StatelessWidget {
  final String text;
  final double value;
  const InvoicingWidget({super.key, required this.text, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Paddings.paddingLTRB20().copyWith(left: 30, right: 30),
      decoration: BoxDecoration(
        border: Border.all(
          // width: Sizes.dp4(context),
          color: Theme.of(context).colorScheme.secondary,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      // width: Sizes.width(context) * .42,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: Sizes.dp5(context),
          ),
          Text(
            "R\$ ${value.toStringAsFixed(2)}",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600 ,color:  const Color.fromARGB(255, 0, 181, 15)),
          ),
        ],
      ),
    );
  }
}
