import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:management/src/domain/use_cases/list_all_categories.dart';

class CategoriesLoadStore extends StreamStore<Failure, List<Category> > {
  final IListAllCategories _listAllCategories;

  CategoriesLoadStore(
    this._listAllCategories,

  ) : super([]);

  Future<void> load() async => executeEither(
        () => DartzEitherAdapter.adapter(_listAllCategories()),
      );



}
