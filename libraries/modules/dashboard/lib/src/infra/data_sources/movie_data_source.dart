import '../../domain/entities/crew.dart';

abstract class DashboardDataSource {

  Future<List<Crew>> getMovieCrewById(int id);
}
