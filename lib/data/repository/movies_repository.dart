import 'package:movies_app/data/network/client/api_client.dart';
import 'package:movies_app/data/network/network_mapper.dart';
import 'package:movies_app/domain/model/movie.dart';

class MoviesRepository {
  final ApiClient apiClient;
  final NetworkMapper networkMapper;

  MoviesRepository({
    required this.apiClient,
    required this.networkMapper,
  });

  Future<List<Movie>> getUpcomingMovies({
    required int page,
    required int limit,
  }) async {
    final upcomingMuvies =
        await apiClient.getUpcomingMovies(page: page, limit: limit);

    return networkMapper.toMovies(upcomingMuvies.results);
  }
}
