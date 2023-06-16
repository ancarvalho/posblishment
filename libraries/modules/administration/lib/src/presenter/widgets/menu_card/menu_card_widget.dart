import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class MenuWidgetCard extends StatelessWidget {
  const MenuWidgetCard({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: Sizes.height(context) / 12,
        child: Padding(
          padding: EdgeInsets.all(Sizes.dp10(context)),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        product.name,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      if (product.description != null)
                        Text(
                          product.description!,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                    ],
                  ),
                  Text(
                    product.price.toString(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
