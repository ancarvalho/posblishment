import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:management/src/domain/use_cases/delete_category.dart';

class CategoryCardStore extends StreamStore<Failure, int> {
  final IDeleteCategory _deleteCategory;

  CategoryCardStore(this._deleteCategory) : super(0);

  Future<void> deleteCategory(String id) async {
    try {
      await _deleteCategory(id);
    } on Failure catch (e) {
      setError(e);
    }
  }
}
