import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import "package:core/core.dart";

import '../../widgets/custom_text_form_field/custom_text_form_field_widget.dart';
import 'category_controller.dart';

class CategoryPage extends StatefulWidget {
  final Category category;
  const CategoryPage({super.key, required this.category});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final controller = Modular.get<CategoryController>();

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
              onPressed: () {
                controller.resetFields(widget.category);
              },
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.width(context) * .02),
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextFormField(
                    controller: controller.nameTextController,
                    decorationName: "Nome",
                    value: widget.category.name,
                  ),
                  CustomTextFormField(
                    controller: controller.descriptionTextController,
                    decorationName: "Description",
                    value: widget.category.description,
                  ),
                ],
              ),
            ),
            // ScopedBuilder<ProductStore, Failure, e.Product>(),
          ),
        ),
      ),
    );
  }
}
