import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/errors/management_failures.dart';
import '../../../domain/use_cases/create_category.dart';
import '../../../domain/use_cases/update_category.dart';

class CategoryStore extends StreamStore<Failure, int> {
  final ICreateCategory _createCategory;
  final IUpdateCategory _updateCategory;


  CategoryStore(this._createCategory, this._updateCategory) : super(0);


  Future<void> createCategory(Category category) async {
    if (!isLoading) {
     return executeEither(() => DartzEitherAdapter.adapter(_createCategory(category)));
    }
      ManagementError(StackTrace.current,"AdministrationModule-createCategory", "", "Currently Executing Action");
  }

  Future<void> updateCategory(Category category) async {
    if(!isLoading) {
      return executeEither(() => DartzEitherAdapter.adapter(_updateCategory(category)));
    }
     ManagementError(StackTrace.current,"AdministrationModule-updateCategory", "", "Currently Executing Action");
  }
}
