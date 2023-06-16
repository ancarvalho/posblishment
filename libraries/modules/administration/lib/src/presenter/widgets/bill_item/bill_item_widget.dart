import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class BillItemWidget extends StatelessWidget {
  const BillItemWidget({
    super.key,
    required this.item,
  });
  final Item item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(item.totalQuantity.toString()),
        //TODO change to name
        Text(item.id),
        Text(
          CurrencyInputFormatter.formatRealCurrency(
              item.price * item.totalQuantity),
        ),
      ],
    );
  }
}
