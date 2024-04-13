import 'package:movies_app/data/database/dao/movies_dao.dart';
import 'package:movies_app/data/database/database_mapper.dart';
import 'package:movies_app/data/network/client/api_client.dart';
import 'package:movies_app/data/network/network_mapper.dart';
import 'package:movies_app/domain/model/movie.dart';

class MoviesRepository {
  final ApiClient apiClient;
  final NetworkMapper networkMapper;
  final MoviesDao moviesDao;
  final DatabaseMapper databaseMapper;

  MoviesRepository({
    required this.apiClient,
    required this.networkMapper,
    required this.moviesDao,
    required this.databaseMapper,
  });

  Future<List<Movie>> getUpcomingMovies({
    required int page,
    required int limit,
  }) async {
    final dbEntities =
        await moviesDao.selectAll(limit: limit, offset: (page * limit) - limit);

    if (dbEntities.isNotEmpty) {
      return databaseMapper.toMovies(dbEntities);
    }

    // Fetch movies from remote API
    final entities =
        await apiClient.getUpcomingMovies(page: page, limit: limit);
    final movies = networkMapper.toMovies(entities.results);

    // Save movies to database
    moviesDao.insertAll(databaseMapper.toMovieDbEntities(movies));

    return movies;
  }
}
