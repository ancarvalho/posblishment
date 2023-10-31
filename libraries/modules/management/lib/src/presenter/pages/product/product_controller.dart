// import 'package:flutter_triple/flutter_triple.dart';
import "package:core/core.dart";
import "package:dartz/dartz.dart";
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:management/src/presenter/widgets/products/products_list_store.dart';
import 'package:textfield_tags/textfield_tags.dart';

import 'product_store.dart';

class ProductController with ChangeNotifier {
  // avoiding inject dependency because disposable state
  final ProductStore productStore;
  final ProductListStore productsStore;

  ProductController(this.productStore, this.productsStore);

  final formKey = GlobalKey<FormState>();

  final nameTextController = TextEditingController();
  final descriptionTextController = TextEditingController();
  final priceTextController = TextEditingController();
  final codeTextController = TextEditingController();
  // final variationTextController = TextEditingController();
  final TextfieldTagsController variationTextController =
      TextfieldTagsController();

  String? _categoryID;

  String? get categoryID => _categoryID;

  set categoryID(String? value) {
    _categoryID = value;
    notifyListeners();
  }

  bool _preparable = false;

  bool get preparable => _preparable;

  set preparable(bool value) {
    _preparable = value;
    notifyListeners();
  }

  int? _index;

  int? get index => _index;

  set index(int? type) {
    _index = type;
    notifyListeners();
  }

  void resetFields() {
    if (index != null) {
      final product = productsStore.state[index!];
      codeTextController.text = product.code.toString();
      nameTextController.text = product.name;
      descriptionTextController.text = product.description ?? "";
      priceTextController.text =
          CurrencyInputFormatter.formatRealCurrency(product.price);
      _categoryID = product.categoryId; // REview
      _preparable = product.preparable;
       notifyListeners();
    } else {
      clearFields();
    }
   
  }

  void clearFields() {
    codeTextController.text = "";
    nameTextController.text = "";
    descriptionTextController.text = "";
    priceTextController.text = "";
    variationTextController.clearTags();
    _categoryID = null;
    _index = null;
    _preparable = false;
    notifyListeners();
  }

  Future<Either<Failure, void>> saveChanges() async {
    if (formKey.currentState!.validate() && index != null) {
      final id = productsStore.state[index!].id;
      return Right(updateProduct(id));
    } else {
      return Right(createProduct());
    }

    // return Left(
    //   ManagementError(
    //     StackTrace.current,
    //     "ManagementError-SaveOrCreateProducts",
    //     "",
    //     "No Category ID Set or Validation Error",
    //   ),
    // );
  }

  double? parseCurrency(String value) {
    return CurrencyInputFormatter.formatToDouble(value);
  }

  String? getVariations() {
    final variations = (variationTextController.getTags != null &&
            variationTextController.getTags!.isNotEmpty)
        ? variationTextController.getTags?.join(",")
        : null;
    return variations;
  }

  Future<void> createProduct() async {
    return productStore.createProduct(
      NewProduct(
        code: int.tryParse(codeTextController.text),
        name: nameTextController.text,
        description: descriptionTextController.text,
        price: parseCurrency(priceTextController.text) ?? 0.0,
        variations: getVariations(),
        categoryId: _categoryID!,
        preparable: _preparable,
      ),
    );
  }

  Future<void> updateProduct(String id) async {
    return productStore.updateProduct(
      UpdateProductModel(
        id: id,
        code: int.tryParse(codeTextController.text),
        name: nameTextController.text,
        description: descriptionTextController.text,
        price: parseCurrency(priceTextController.text) ?? 0.0,
        variations: getVariations(),
        categoryId: _categoryID!,
      ),
    );
  }

  // @override
  // void dispose() {
  //   // formKey.currentState?.dispose();
  //   nameTextController.dispose();
  //   descriptionTextController.dispose();
  //   priceTextController.dispose();
  //   variationTextController.dispose();
  // }
}
