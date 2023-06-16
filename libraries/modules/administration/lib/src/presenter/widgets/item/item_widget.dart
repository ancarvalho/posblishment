import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key, required this.item});
  final Item item;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(item.quantity.toString(), style: Theme.of(context).textTheme.displayMedium),
        Text(item.productId, style: Theme.of(context).textTheme.displayMedium),
      ],
    );
  }
}
