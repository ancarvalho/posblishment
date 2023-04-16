import 'package:management/src/domain/use_cases/delete_category.dart';

class CategoriesListController {
   final IDeleteCategory _deleteCategory;

  CategoriesListController(this._deleteCategory);

  Future<void> deleteCategory(String id) async {
    await _deleteCategory(id);
  }
}
