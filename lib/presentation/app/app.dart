import 'package:flutter/material.dart';
import 'package:movies_app/presentation/list/movies_list_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Movies App',
      home: MoviesListScreen(),
    );
  }
}
