import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';
import '../../../domain/entities/entities.dart' as e;
import '../../../domain/use_cases/create_category.dart';

class CategoryStore extends StreamStore<Failure, e.Category> {
  final ICreateCategory _createCategory;

  CategoryStore(this._createCategory) : super(e.Category.empty());

  // void loadMovieTrailer(String frequency) => execute(_getCategory( frequency));
  Future<void> create(e.Category category) async => executeEither(
        () => DartzEitherAdapter.adapter(_createCategory(category)),
      );
}
