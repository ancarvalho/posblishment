import "package:core/core.dart";
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:management/src/presenter/widgets/categories/categories_list_store.dart';

import '../../../domain/errors/management_failures.dart';
import 'category_store.dart';

class CategoryController with ChangeNotifier {
  // avoiding inject dependency because disposable state

  final CategoryStore categoryStore;
  final CategoriesListStore categoriesStore;

  CategoryController(this.categoryStore, this.categoriesStore);

  final formKey = GlobalKey<FormState>();

  final nameTextController = TextEditingController();
  final descriptionTextController = TextEditingController();

  int? _index;

  int? get index => _index;

  set index(int? type) {
    _index = type;
    notifyListeners();
  }

  void resetFields() {
    if (index != null) {
      final category = categoriesStore.state[index!];
      nameTextController.text = category.name;
      descriptionTextController.text = category.description ?? "";
    } else {
      clearFields();
    }
  }

  void clearFields() {
    nameTextController.text = "";
    descriptionTextController.text = "";
    _index = null;
  }

  Future<Either<Failure, void>> saveChanges() async {
    if (formKey.currentState!.validate() && index != null) {
      final id = categoriesStore.state[index!].id;
      return Right(updateCategory(id!));
    } else if (formKey.currentState!.validate()) {
      return Right(createCategory());
    }
    return Left(
      ManagementError(
        StackTrace.current,
        "ManagementError-createOrUpdateCategory",
        "",
        "Category name needed",
      ),
    );
  }

  Future<void> createCategory() async {
    await categoryStore.createCategory(
      Category(
        name: nameTextController.text,
        description: descriptionTextController.text,
      ),
    );
  }

  Future<void> updateCategory(String id) async {
    await categoryStore.updateCategory(
      Category(
        id: id,
        name: nameTextController.text,
        description: descriptionTextController.text,
      ),
    );
  }

  // @override
  // void dispose() {
  //   // formKey.currentState?.dispose();
  //   nameTextController.dispose();
  //   descriptionTextController.dispose();
  // }
}
