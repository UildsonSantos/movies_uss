import 'package:logger/logger.dart';
import 'package:movies_app/data/network/entity/movie_entity.dart';
import 'package:movies_app/domain/exception/mapper_exception.dart';
import 'package:movies_app/domain/model/movie.dart';

class NetworkMapper {
  final Logger log;

  NetworkMapper({required this.log});

  Movie toMovie(MovieEntity entity) {
    try {
      return Movie(
        id: entity.id,
        title: entity.titleText.text,
        imageUrl: entity.primaryImage?.url,
        releaseDate: DateTime(
          entity.releaseDate.year,
          entity.releaseDate.month,
          entity.releaseDate.day,
        ),
      );
    } catch (e) {
      throw MapperException<MovieEntity, Movie>(e.toString());
    }
  }

  List<Movie> toMovies(List<MovieEntity> entities) {
    final List<Movie> movies = [];

    for (final entity in entities) {
      try {
        movies.add(toMovie(entity));
      } catch (e) {
        log.w('Could not map entity ${entity.id}', error: e);
      }
    }

    return movies;
  }
}
