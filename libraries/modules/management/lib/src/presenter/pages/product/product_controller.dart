// import 'package:flutter_triple/flutter_triple.dart';
import "package:core/core.dart";
import "package:dartz/dartz.dart";
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:management/src/domain/errors/management_failures.dart';
import 'package:textfield_tags/textfield_tags.dart';

import 'product_store.dart';

class ProductController extends Disposable with ChangeNotifier {
  // avoiding inject dependency because disposable state
  final store = Modular.get<ProductStore>();

  ProductController();

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

  void resetFields(Product? product) {
    codeTextController.text = product?.code.toString() ?? "";
    nameTextController.text = product?.name ?? "";
    descriptionTextController.text = product?.description ?? "";
    priceTextController.text = product?.price != null
        ? CurrencyInputFormatter.formatRealCurrency(product?.price)
        : "";
    _categoryID = _categoryID ?? product?.categoryId; // REview
  }

  void clearFields() {
    codeTextController.text = "";
    nameTextController.text = "";
    descriptionTextController.text = "";
    priceTextController.text = "";
    variationTextController.clearTags();
  }

  Future<Either<Failure, void>> saveChanges(String? id) async {
    if (formKey.currentState!.validate() && _categoryID != null) {
      if (id != null) {
        return Right(updateProduct(id));
      } else {
        return Right(createProduct());
      }
    }
    return Left(
      ManagementError(
        StackTrace.current,
        "ManagementError-SaveOrCreateProducts",
        "",
        "No Category ID Set or Validation Error",
      ),
    );
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
    return store.createProduct(
      NewProduct(
        code: int.tryParse(codeTextController.text),
        name: nameTextController.text,
        description: descriptionTextController.text,
        price: parseCurrency(priceTextController.text) ?? 0.0,
        variations: getVariations(),
        categoryId: _categoryID!,
      ),
    );
  }

  Future<void> updateProduct(String id) async {
    return store.updateProduct(
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

  @override
  void dispose() {
    // formKey.currentState?.dispose();
    nameTextController.dispose();
    descriptionTextController.dispose();
    priceTextController.dispose();
    variationTextController.dispose();
  }
}
