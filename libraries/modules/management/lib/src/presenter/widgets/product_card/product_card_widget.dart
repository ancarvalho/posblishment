import "package:core/core.dart";
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/use_cases/delete_product.dart';
import '../../pages/product/product_controller.dart';
import '../dialog/custom_delete_dialog.dart';

class ProductCardWidget extends StatefulWidget {
  final Product product;
  final int index;

  const ProductCardWidget({
    super.key,
    required this.product,
    required this.index,
  });

  @override
  State<ProductCardWidget> createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  final deleteProduct = Modular.get<IDeleteProduct>();
  // final productsStore = Modular.get<ProductListStore>();

  final productController = Modular.get<ProductController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        productController
          ..index = widget.index
          ..resetFields();

        if (Sizes.isMobile(context)) {
          Modular.to.pushNamed(
            "${PagesRoutes.product.dependsOnModule.route}${PagesRoutes.product.route}",
            arguments: widget.index,
          );
        }
      },
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) {
            return CustomDeleteDialog(
              delete: () {
                deleteProduct
                    .call(widget.product.id)
                    .then((value) => eitherDisplayError(context, value));
              },
              name: widget.product.name,
            );
          },
        );
      },
      child: Card(
        child: ConstrainedBox(
          // height: 180,
          constraints: const BoxConstraints(
            maxHeight: 130,
            minWidth: 150,
            maxWidth: 200,
            minHeight: 90,
          ),
          child: Padding(
            padding: Sizes.isMobile(context)
                ? Paddings.paddingVertical4()
                : Paddings.paddingLTRB4(),
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
