import 'package:core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/errors/management_failures.dart';
import '../../../domain/use_cases/create_category.dart';
import '../../../domain/use_cases/update_category.dart';

class CategoryStore extends StreamStore<Failure, int> {
  final ICreateCategory _createCategory;
  final IUpdateCategory _updateCategory;


  CategoryStore(this._createCategory, this._updateCategory) : super(0);

  final formKey = GlobalKey<FormState>();

  final nameTextController = TextEditingController();
  final descriptionTextController = TextEditingController();

  void resetFields(Category? category) {
    nameTextController.text = category?.name ?? "";
    descriptionTextController.text = category?.description ?? "";
  }


  void clearFields() {
    nameTextController.text =  "";
    descriptionTextController.text = "";
  }


  Future<void> saveChanges(String? id) async {
    if (formKey.currentState!.validate() && id != null) {
      return updateCategory(id);
    } else if (formKey.currentState!.validate()) {
      return createCategory();
    }
    return setError(
      ManagementError(
        StackTrace.current,
        "ManagementError-createOrUpdateCategory",
        "",
        "Category name needed",
      ),
    );
  }

  Future<void> createCategory() async {
    await _create(
      Category(
        name: nameTextController.text,
        description: descriptionTextController.text,
      ),
    );
  }

  Future<void> updateCategory(String id) async {
    await _update(
      Category(
        id: id,
        name: nameTextController.text,
        description: descriptionTextController.text,
      ),
    );
  }



  Future<void> _create(Category category) async {
    if (!isLoading) {
     return executeEither(() => DartzEitherAdapter.adapter(_createCategory(category)));
    }
      ManagementError(StackTrace.current,"AdministrationModule-createCategory", "", "Currently Executing Action");
  }

  Future<void> _update(Category category) async {
    if(!isLoading) {
      return executeEither(() => DartzEitherAdapter.adapter(_updateCategory(category)));
    }
     ManagementError(StackTrace.current,"AdministrationModule-updateCategory", "", "Currently Executing Action");
  }
}
