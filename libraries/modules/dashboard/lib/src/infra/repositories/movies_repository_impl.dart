// import 'package:core/core.dart';
// import 'package:dartz/dartz.dart';

// import '../../domain/entities/crew.dart';
// import '../../domain/errors/movie_failures.dart';
// import '../../domain/repositories/movies_repository.dart';
// import '../data_sources/movie_data_source.dart';

// class MoviesRepositoryImpl implements MoviesRepository {
//   final MovieDataSource _dataSource;

//   MoviesRepositoryImpl(this._dataSource);

//   @override
//   Future<Either<Failure, List<Crew>>> getMovieCrewById(int id) async {
//     try {
//       final result = await _dataSource.getMovieCrewById(id);

//       if (result.isEmpty) {
//         return Left(NoDataFound());
//       }

//       return Right(result);
//     } on Failure catch (e) {
//       return Left(e);
//     } on Exception catch (exception, stacktrace) {
//       return Left(UnknownError(exception: exception, stackTrace: stacktrace, label: 'moviesRepositoryImpl-getTvShowTrailer'));
//     }
//   }

//   @override
//   Future<Either<Failure, List<Crew>>> getTvShowCrewById(int id) async {
//     try {
//       final result = await _dataSource.getTvShowCrewById(id);

//       if (result.isEmpty) {
//         return Left(NoDataFound());
//       }

//       return Right(result);
//     } on Failure catch (e) {
//       return Left(e);
//     } on Exception catch (exception, stacktrace) {
//       return Left(UnknownError(exception: exception, stackTrace: stacktrace, label: 'moviesRepositoryImpl-getTvShowTrailer'));
//     }
//   }
// }
