import "package:core/core.dart";
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../pages/products_list/products_list_store.dart';
import '../dialog/custom_cancel_dialog.dart';
import 'item_store.dart';

class ItemWidget extends StatefulWidget {
  final Product product;
  const ItemWidget({super.key, required this.product});

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  final store = Modular.get<ItemStore>();
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
          './product',
          arguments: widget.product,
        );
      },
      onDoubleTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return CustomCancelDialog(
              delete: () {
                store.deleteProduct(widget.product.id!);
                
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
                    Text(
                      "${widget.product.code ?? ""}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
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
                        Text(
                          widget.product.description ?? "",
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
