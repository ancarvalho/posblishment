import "package:core/core.dart";
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/use_cases/create_category.dart';
import '../../../domain/use_cases/update_category.dart';

class CategoryController extends Disposable {
  final ICreateCategory _createCategory;
  final IUpdateCategory _updateCategory;

  final formKey = GlobalKey<FormState>();

  final nameTextController = TextEditingController();
  final descriptionTextController = TextEditingController();

  CategoryController(this._createCategory, this._updateCategory);

  void resetFields(Category category) {
    nameTextController.text = category.name;
    descriptionTextController.text = category.description ?? "";
  }

  void saveChanges(String? id) {
    if (formKey.currentState!.validate() && id != null) {
      updateProduct(id);
    } else if (formKey.currentState!.validate()) {
      createProduct();
    } else {
      print("Invalid Fields");
    }
  }

  void createProduct() {
    _createCategory(
      Category(
        name: nameTextController.text,
        description: descriptionTextController.text,
      ),
    );
  }

  void updateProduct(String id) {
    _updateCategory(
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
