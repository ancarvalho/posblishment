import '../../domain/entities/crew.dart';

import '../../domain/errors/movie_failures.dart';
import '../../infra/data_sources/movie_data_source.dart';

class DashboardDataSourceImpl implements DashboardDataSource {


  DashboardDataSourceImpl();

  @override
  Future<List<Crew>> getMovieCrewById(int movieId) async {
    // isar.attachCollections(collections)

  

    try {
      return [] as List<Crew>;
    } catch (e, stackTrace) {
      if (e == "asd") {
        throw CrewNoInternetConnection();
      }
      throw MovieNowPlayingError(stackTrace,
          'MovieDataSourceImpl-getMovieNowPlaying', e, e.toString(),);
    }
  }

  
}
