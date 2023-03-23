import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';
import '../../../domain/entities/entities.dart' as e;
import '../../../domain/use_cases/list_all_categories.dart';

class CategoriesListStore extends StreamStore<Failure, List<e.Category>> {
  final IListAllCategories _listAllCategories;

  CategoriesListStore(this._listAllCategories) : super([]);

  Future<void> list() async => executeEither(
        () => DartzEitherAdapter.adapter(_listAllCategories()),
      );
}
