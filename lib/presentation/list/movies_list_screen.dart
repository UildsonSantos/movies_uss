import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';
import 'package:movies_app/data/repository/movies_repository.dart';
import 'package:movies_app/domain/model/movie.dart';
import 'package:movies_app/presentation/list/movie_list_model.dart';
import 'package:movies_app/presentation/list/movie_preview.dart';
import 'package:provider/provider.dart';

class MoviesListScreen extends StatefulWidget {
  const MoviesListScreen({super.key});

  @override
  _MoviesListScreenState createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  late final MoviesListModel _model;
  final PagingController<int, Movie> _pagingController =
      PagingController(firstPageKey: 1);

  late final Future<void> _future;
  @override
  void initState() {
    super.initState();

    _model = MoviesListModel(
      log: Provider.of<Logger>(context, listen: false),
      moviesRepo: Provider.of<MoviesRepository>(context, listen: false),
    );

    _future = _checkNewData();

    _pagingController.addPageRequestListener((pageKey) async {
      try {
        final movies = await _model.fetchPage(pageKey);
        _pagingController.appendPage(movies, pageKey + 1);
      } catch (e) {
        _pagingController.error = e;
      }
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Uncoming Movies'),
      ),
      body: FutureBuilder<void>(
        future: _future,
        builder: (context, snapshot) => RefreshIndicator(
          onRefresh: _refresh,
          child: PagedListView<int, Movie>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Movie>(
              itemBuilder: (context, movie, index) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 6.0,
                ),
                child: MoviePreview(
                  movie: movie,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    await _model.deletePersistedMovies();
    _pagingController.refresh();
  }

  Future<void> _checkNewData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      final hasNewData = await _model.hasNewData();

      if (hasNewData) {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: const Text('Refresh to obtain the new available data'),
            action: SnackBarAction(
              label: 'Refresh',
              onPressed: _refresh,
            ),
          ),
        );
      }
    });
  }
}
