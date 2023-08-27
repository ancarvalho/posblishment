// import 'package:flutter_triple/flutter_triple.dart';
import "package:core/core.dart";
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:management/src/domain/errors/management_failures.dart';
import "package:dartz/dartz.dart";
import 'product_store.dart';

class ProductController extends Disposable {
  // avoiding inject dependency because disposable state
  final store = Modular.get<ProductStore>();

  ProductController();

  final formKey = GlobalKey<FormState>();

  final nameTextController = TextEditingController();
  final descriptionTextController = TextEditingController();
  final priceTextController = TextEditingController();
  final codeTextController = TextEditingController();
  final variationTextController = TextEditingController();

  final ValueNotifier<String?> _categoryID = ValueNotifier(null);

  void resetFields(Product? product) {
    codeTextController.text = product?.code.toString() ?? "";
    nameTextController.text = product?.name ?? "";
    descriptionTextController.text = product?.description ?? "";
    priceTextController.text = product?.price.toString() ?? "";
    variationTextController.text =
        product?.variations != null ? product?.variations?.join(",") ?? "" : "";
    categoryID = product?.categoryId;
  }

  Future<Either<Failure, void>> saveChanges(String? id) async {
    if (formKey.currentState!.validate() && categoryID != null) {
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

  Future<void> createProduct() async {
    return store.createProduct(
      NewProduct(
        code: int.tryParse(codeTextController.text),
        name: nameTextController.text,
        description: descriptionTextController.text,
        price: parseCurrency(priceTextController.text) ?? 0.0,
        variations: variationTextController.text.split(","),
        categoryId: categoryID!,
      ),
    );
  }

  String? get categoryID => _categoryID.value;

  set categoryID(String? value) {
    _categoryID.value = value;
  }

  Future<void> updateProduct(String id) async {
    return store.updateProduct(
      UpdateProductModel(
        id: id,
        code: int.tryParse(codeTextController.text),
        name: nameTextController.text,
        description: descriptionTextController.text,
        price: parseCurrency(priceTextController.text) ?? 0.0,
        variations: variationTextController.text.split(","),
        categoryId: categoryID!,
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
