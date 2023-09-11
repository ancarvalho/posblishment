import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../pages/cart/cart_store.dart';

class MenuWidgetCard extends StatelessWidget {
  const MenuWidgetCard({super.key, required this.product});
  final Product product;
  

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () =>  Modular.get<CartStore>().insertProductOnItems(product),
      child: Card(
        child: SizedBox(
          height: Sizes.height(context) / 10,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.dp8(context),
              vertical: Sizes.dp9(context),
            ),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (product.code != null)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "cod",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            "${product.code ?? ""}",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
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
                        if (product.description != null)
                          Text(
                            product.description!,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                      ],
                    ),
                    Text(
                      CurrencyInputFormatter.formatRealCurrency(
                        product.price,
                      ),
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
