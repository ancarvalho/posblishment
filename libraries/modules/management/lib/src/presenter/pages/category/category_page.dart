import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/entities.dart' as e;
import '../../widgets/custom_text_form_field/custom_text_form_field_widget.dart';

class CategoryPage extends StatefulWidget {
  final e.Category category;
  const CategoryPage({super.key, required this.category});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
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
          padding: EdgeInsets.symmetric(horizontal: Sizes.width(context) * .02),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextFormField(
                  controller: _nameTextController,
                  decorationName: "Nome",
                  value: widget.category.name,
                ),
                CustomTextFormField(
                  controller: _descriptionTextController,
                  decorationName: "Description",
                  value: widget.category.description,
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
