import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
// import 'package:flutter_triple/flutter_triple.dart';
import "package:core/core.dart";

import '../../../domain/use_cases/create_product.dart';
import '../../../domain/use_cases/update_product.dart';

class ProductController extends Disposable {
  final ICreateProduct _createProduct;
  final IUpdateProduct _updateProduct;

  ProductController(this._createProduct, this._updateProduct);

  final formKey = GlobalKey<FormState>();

  final nameTextController = TextEditingController();
  final descriptionTextController = TextEditingController();
  final priceTextController = TextEditingController();
  final variationTextController = TextEditingController();

  void resetFields(Product product) {
    nameTextController.text = product.name;
    descriptionTextController.text = product.description ?? "";
    priceTextController.text = product.price.toString();
    variationTextController.text =
        product.variations != null ? product.variations!.join(",") : "";
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
    _createProduct(
      Product(
        name: nameTextController.text,
        description: descriptionTextController.text,
        price: double.tryParse(priceTextController.text) ?? 0.0,
        variations: variationTextController.text.split(","),
      ),
    );
  }

  void updateProduct(String id) {
    _updateProduct(
      Product(
        id: id,
        name: nameTextController.text,
        description: descriptionTextController.text,
        price: double.tryParse(priceTextController.text) ?? 0.0,
        variations: variationTextController.text.split(","),
      ),
    );
  }

  @override
  void dispose() {
    // formKey.currentState?.dispose();
    nameTextController.dispose();
    descriptionTextController.dispose();
    priceTextController.dispose();
    variationTextController.dispose();
  }
}
