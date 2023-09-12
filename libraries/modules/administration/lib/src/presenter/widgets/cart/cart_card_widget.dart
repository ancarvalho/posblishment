import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CartCardWidget extends StatelessWidget {
  const CartCardWidget(
      {super.key,
      required this.item,
      required this.removeItem,
      required this.increaseQuantity,
      required this.decreaseQuantity});
  final NewItem item;

  final Function(String index) removeItem;
  final Function(String index) increaseQuantity;
  final Function(String index) decreaseQuantity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: SizedBox(
          height: Sizes.height(context) / 10,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.dp8(context),
              vertical: Sizes.dp9(context),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      item.quantity.toString(),
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8,),
                    if (item.name != null)
                      Text(
                        item.name!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),  
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () => increaseQuantity(item.productId),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(30, 30),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            alignment: Alignment.centerLeft,
                          ),
                          child: const Icon(
                            Icons.keyboard_arrow_up,
                            size: 30,
                            // size:
                          ),
                        ),
                        TextButton(
                          onPressed: () => decreaseQuantity(item.productId),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(30, 30),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            alignment: Alignment.centerLeft,
                          ),
                          child: const Icon(
                            Icons.keyboard_arrow_down,
                            size: 30,
                            // size:
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () => removeItem(item.productId),
                      icon: const Icon(Icons.remove),
                      tooltip: "Remove Item",
                    ),
                  ],
                ),
                // SizedBox(
                //   width: 30,
                //   child: IconButton(
                //     onPressed: () => removeItem(item.productId),
                //     icon: const Icon(Icons.remove),
                //     tooltip: "Remove Item",
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
