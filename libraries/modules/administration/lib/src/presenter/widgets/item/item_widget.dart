import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key, required this.item});
  final Item item;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        
        children: [
          Text(item.quantity.toString(), style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(width: 2,),
          Text(item.name, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}
