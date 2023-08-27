import "package:core/core.dart";
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'category_store.dart';

class CategoryController extends Disposable {
  // avoiding inject dependency because disposable state
  final store = Modular.get<CategoryStore>();

  final formKey = GlobalKey<FormState>();

  final nameTextController = TextEditingController();
  final descriptionTextController = TextEditingController();

  CategoryController();

  void resetFields(Category? category) {
    nameTextController.text = category?.name ?? "";
    descriptionTextController.text = category?.description ?? "";
  }

  Future<void> saveChanges(String? id) async {
    if (formKey.currentState!.validate() && id != null) {
      // print("Updating ...");
      await updateProduct(id);
    } else if (formKey.currentState!.validate()) {
      // print("Creating ...");
      await createProduct();
    } else {
      // print("Invalid Fields");
    }
  }

  Future<void> createProduct() async {
    await store.createCategory(
      Category(
        name: nameTextController.text,
        description: descriptionTextController.text,
      ),
    );
  }

  Future<void> updateProduct(String id) async {
    await store.updateCategory(
      Category(
        id: id,
        name: nameTextController.text,
        description: descriptionTextController.text,
      ),
    );
  }

  @override
  void dispose() {
    // formKey.currentState?.dispose();
    nameTextController.dispose();
    descriptionTextController.dispose();
  }
}
