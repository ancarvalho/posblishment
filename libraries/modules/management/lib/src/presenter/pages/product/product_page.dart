import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import "package:core/core.dart";
import 'package:management/src/presenter/pages/product/product_controller.dart';
import 'package:management/src/presenter/pages/product/product_store.dart';

import '../../widgets/custom_text_form_field/custom_text_form_field_widget.dart';

class ProductPage extends StatefulWidget {
  final Product product;
  const ProductPage({super.key, required this.product});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

// TODO Instanciate usecases, controller, and store on module
class _ProductPageState extends State<ProductPage> {
  final controller = Modular.get<ProductController>();
  final store = Modular.get<ProductStore>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.product.id != null ? widget.product.name : "Criar Produto",
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.clear),
              tooltip: 'Reset Fields',
              onPressed: () {
                controller.resetFields(widget.product);
              },
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.width(context) * .02),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextFormField(
                  controller: controller.nameTextController,
                  decorationName: "Nome",
                  value: widget.product.name,
                ),
                CustomTextFormField(
                  controller: controller.descriptionTextController,
                  decorationName: "Description",
                  value: widget.product.description,
                ),
                CustomTextFormField(
                  controller: controller.priceTextController,
                  decorationName: "Price",
                  value: widget.product.price.toString(),
                ),
                CustomTextFormField(
                  controller: controller.variationTextController,
                  decorationName: "Variações",
                  value: widget.product.variations?.join(","),
                ),
              ],
            ),
            // ScopedBuilder<ProductStore, Failure, e.Product>(),
          ),
        ),
      ),
    );
  }
}
