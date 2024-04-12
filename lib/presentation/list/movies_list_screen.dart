import 'package:flutter/material.dart';
import 'package:movies_app/data/repository/movies_repository.dart';
import 'package:movies_app/domain/model/movie.dart';
import 'package:movies_app/presentation/list/movie_preview.dart';
import 'package:provider/provider.dart';

class MoviesListScreen extends StatefulWidget {
  const MoviesListScreen({super.key});

  @override
  _MoviesListScreenState createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  @override
  Widget build(BuildContext context) {
    final moviesRepo = Provider.of<MoviesRepository>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Uncoming Movies'),
      ),
      body: FutureBuilder<List<Movie>>(
        future: moviesRepo.getUnComingMovies(page: 1, limit: 10),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: List.generate(
                snapshot.data!.length,
                (index) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 6.0,
                  ),
                  child: MoviePreview(
                    movie: snapshot.data![index],
                  ),
                ),
              ),
            );
          } else {
            return const LinearProgressIndicator();
          }
        },
      ),
    );
  }
}
