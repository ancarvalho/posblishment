// import 'package:flutter_triple/flutter_triple.dart';
import "package:core/core.dart";
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'product_store.dart';

class ProductController extends Disposable {
  // avoiding inject dependency because disposable state
  final store = Modular.get<ProductStore>();

  ProductController();

  final formKey = GlobalKey<FormState>();

  final nameTextController = TextEditingController();
  final descriptionTextController = TextEditingController();
  final priceTextController = TextEditingController();
  final variationTextController = TextEditingController();

  final ValueNotifier<String?> _categoryID = ValueNotifier(null);

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
      // print("Invalid Fields");
    }
  }

  double? parseCurrency(String value) {
    return CurrencyInputFormatter.formatToDouble(value);
  }

  void createProduct() {
    store.createProduct(
      Product(
          name: nameTextController.text,
          description: descriptionTextController.text,
          price: parseCurrency(priceTextController.text) ?? 0.0,
          variations: variationTextController.text.split(","),
          categoryId: categoryID),
    );
  }



  String? get categoryID => _categoryID.value;

  set categoryID(String? value) {
    _categoryID.value = value;
  }

  void updateProduct(String id) {
    store.updateProduct(
      Product(
          id: id,
          name: nameTextController.text,
          description: descriptionTextController.text,
          price: parseCurrency(priceTextController.text) ?? 0.0,
          variations: variationTextController.text.split(","),
          categoryId: categoryID),
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
