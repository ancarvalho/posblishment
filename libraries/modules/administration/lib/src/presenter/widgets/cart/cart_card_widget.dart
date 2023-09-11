import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CartCardWidget extends StatelessWidget {
  const CartCardWidget({super.key, required this.item});
  final NewItem item;

  // final Function(int index) removeItem;
  // final Function(String index) increaseQuantity;
  // final Function(String index) decreaseQuantity;

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
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.quantity.toString(),
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (item.name != null)
                      Text(
                        item.name!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    SizedBox(
                      width: 30,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {},
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
                            onPressed: () {},
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
                    ),
                    SizedBox(
                      width: 30,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.remove),
                        tooltip: "Remove Item",
                      ),
                    )
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
