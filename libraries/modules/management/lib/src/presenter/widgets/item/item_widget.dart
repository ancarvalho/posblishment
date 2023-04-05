import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import "package:core/core.dart";

class ItemWidget extends StatelessWidget {
  final Product product;
  const ItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: Sizes.height(context) / 10,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Sizes.dp8(context), vertical: Sizes.dp9(context),),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${product.code ?? ""}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        product.description ?? "",
                        maxLines: 1,

                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                  Text(
                    product.price.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
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
