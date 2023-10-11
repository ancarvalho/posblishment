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
    String? variation;
    return GestureDetector(
      onTap: () => Modular.get<CartStore>().insertProductOnItems(product, variation),
      child: Card(
        child: ConstrainedBox(
          // height: 180,
          constraints: const BoxConstraints(
              maxHeight: 130, minWidth: 150, maxWidth: 180, minHeight: 90,),
          child: Padding(
            padding: Paddings.paddingLTRB8(),
            
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
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
                //  if (product.variations != null &&
                //     product.variations!.isNotEmpty)
                //   Align(
                //     alignment: Alignment.bottomRight,
                //     child: SizedBox(
                //       width: Sizes.width(context) *.4,
                //       height: Sizes.height(context)*.2,
                //       child: CustomDropDown(items: <String, String>{
                //         for (final v in product.variations!.split(",")) v: v
                //       }, setValue: (value) => variation=value, labelText: "variação", ),
                //     ),
                //   )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
