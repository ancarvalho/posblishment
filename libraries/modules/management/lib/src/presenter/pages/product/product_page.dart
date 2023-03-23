import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/entities.dart' as e;
import '../../widgets/custom_text_form_field/custom_text_form_field_widget.dart';

class ProductPage extends StatefulWidget {
  final e.Product product;
  const ProductPage({super.key, required this.product});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _descriptionTextController =
      TextEditingController();
  final TextEditingController _priceTextController = TextEditingController();
  final TextEditingController _variationTextController =
      TextEditingController();

  void resetFields() {
    _nameTextController.clear();
    _descriptionTextController.clear();
    _priceTextController.clear();
    _variationTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(""),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.clear),
              tooltip: 'Reset Fields',
              onPressed: resetFields,
            ),
          ],
        ),
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: Sizes.width(context)*.02),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextFormField(
                  controller: _nameTextController,
                  decorationName: "Nome",
                  value: widget.product.name,
                ),
                CustomTextFormField(
                  controller: _descriptionTextController,
                  decorationName: "Description",
                  value: widget.product.description,
                ),
                CustomTextFormField(
                  controller: _priceTextController,
                  decorationName: "Price",
                  value: widget.product.unitValue.toString(),
                ),
                CustomTextFormField(
                  controller: _variationTextController,
                  decorationName: "Variações",
                  value: widget.product.variations?.entries.join(","),
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
