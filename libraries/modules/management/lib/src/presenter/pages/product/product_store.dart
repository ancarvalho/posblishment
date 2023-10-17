import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:management/src/domain/errors/management_failures.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../../domain/use_cases/create_product.dart';
import '../../../domain/use_cases/update_product.dart';

class ProductStore extends StreamStore<Failure, int> {
  final ICreateProduct _createProduct;
  final IUpdateProduct _updateProduct;

  // final productController = ProductController();

  final formKey = GlobalKey<FormState>();

  final nameTextController = TextEditingController();
  final descriptionTextController = TextEditingController();
  final priceTextController = TextEditingController();
  final codeTextController = TextEditingController();
  // final variationTextController = TextEditingController();
  final TextfieldTagsController variationTextController =
      TextfieldTagsController();

  final ValueNotifier categoryId = ValueNotifier<String?>(null);

  void resetFields(Product? product) {
    codeTextController.text = product?.code.toString() ?? "";
    nameTextController.text = product?.name ?? "";
    descriptionTextController.text = product?.description ?? "";
    priceTextController.text = product?.price != null
        ? CurrencyInputFormatter.formatRealCurrency(product?.price)
        : "";
    categoryId.value = categoryId.value ?? product?.categoryId; // REview
  }

  void clearFields() {
    codeTextController.text = "";
    nameTextController.text = "";
    descriptionTextController.text = "";
    priceTextController.text = "";
    variationTextController.clearTags();
  }

  Future<void> saveChanges(String? id) async {
    if (formKey.currentState!.validate() && categoryId.value != null) {
      if (id != null) {
        return updateProduct(id);
      } else {
        return createProduct();
      }
    }
    return setError(
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
    await _create(
      NewProduct(
        code: int.tryParse(codeTextController.text),
        name: nameTextController.text,
        description: descriptionTextController.text,
        price: parseCurrency(priceTextController.text) ?? 0.0,
        variations: getVariations(),
        categoryId: categoryId.value!,
      ),
    );
  }

  Future<void> updateProduct(String id) async {
    await _update(
      UpdateProductModel(
        id: id,
        code: int.tryParse(codeTextController.text),
        name: nameTextController.text,
        description: descriptionTextController.text,
        price: parseCurrency(priceTextController.text) ?? 0.0,
        variations: getVariations(),
        categoryId: categoryId.value!,
      ),
    );
  }

  ProductStore(
    this._createProduct,
    this._updateProduct,
  ) : super(0);

  Future<void> _create(NewProduct product) async {
    if (!isLoading) {
      return executeEither(
          () => DartzEitherAdapter.adapter(_createProduct(product)));
    }
    ManagementError(StackTrace.current, "AdministrationModule-createProduct",
        "", "Currently Executing Action");
  }

  Future<void> _update(UpdateProductModel product) async {
    if (!isLoading) {
      return executeEither(
          () => DartzEitherAdapter.adapter(_updateProduct(product)));
    }
    ManagementError(StackTrace.current, "AdministrationModule-updateProduct",
        "", "Currently Executing Action");
  }
}
