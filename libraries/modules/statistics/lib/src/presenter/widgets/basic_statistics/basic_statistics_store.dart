import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/basic_statistics.dart';
import '../../../domain/enums/frequency.dart';
import '../../../domain/use_cases/get_basic_statistics.dart';

class BasicStatsStore extends StreamStore<Failure, BasicStatistics> {
  final IGetBasicStats _getBasicStats;

  BasicStatsStore(this._getBasicStats) : super(BasicStatistics.empty());

  // void loadMovieTrailer(String frequency) => execute(_getBasicStats( frequency));
  Future<void> load(Frequency frequency) async => executeEither(
      () => DartzEitherAdapter.adapter(_getBasicStats(frequency)),);
}
