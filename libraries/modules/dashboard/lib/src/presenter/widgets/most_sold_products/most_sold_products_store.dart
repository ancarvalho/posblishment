import 'package:core/core.dart';
import 'package:dashboard/src/domain/entities/entities.dart';
import 'package:dashboard/src/domain/enums/frequency.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/use_cases/get_most_sold_products.dart';

class MostSoldProductsStore extends StreamStore<Failure, List<ItemsSold>> {
  final IGetMostSoldProducts _getMostSoldProducts;

  MostSoldProductsStore(this._getMostSoldProducts) : super([]);

  // void loadMovieTrailer(String frequency) => execute(_getMostSoldProducts( frequency));

  Future<void> load(Frequency frequency) async =>
      execute(() => _getMostSoldProducts(frequency));
}
