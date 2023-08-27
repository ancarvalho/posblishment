import "package:core/core.dart";
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../pages/products_list/products_list_store.dart';
import '../dialog/custom_cancel_dialog.dart';
import 'product_card_store.dart';

class ProductCardWidget extends StatefulWidget {
  final Product product;
  const ProductCardWidget({super.key, required this.product});

  @override
  State<ProductCardWidget> createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  final store = Modular.get<ProductCardStore>();
  final productsStore = Modular.get<ProductListStore>();

  @override
  void initState() {
    store.observer(
      onError: (error) {
        // TODO replace by some instance
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
          ),
        );
      },
      onState: (error) {
        productsStore.list();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Modular.to.pushNamed(
          "${PagesRoutes.product.dependsOnModule.route}${PagesRoutes.product.route}",
          arguments: widget.product,
        );
      },
      onDoubleTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return CustomCancelDialog(
              delete: () {
                store.deleteProduct(widget.product.id);
              },
              name: widget.product.name,
            );
          },
        );
      },
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
                    if (widget.product.code != null)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "cod",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            "${widget.product.code ?? ""}",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.product.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (widget.product.description != null)
                          Text(
                            widget.product.description!,
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
                        widget.product.price,
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
