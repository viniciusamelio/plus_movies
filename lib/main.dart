import 'package:flutter/material.dart';
import 'package:plus_movies/core/infra/services/get_storage.service.dart';
import 'package:plus_movies/core/presentation/styles/theme.dart';
import 'package:plus_movies/modules/movies/presentation/pages/home.page.dart';
import 'package:plus_movies/modules/movies/presentation/pages/movie_details.page.dart';

void main() async {
  await GetStorageService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plus Movies',
      theme: theme,
      routes: {
        "/": (context) => const HomePage(),
        MovieDetailsPage.routeName: (context) => const MovieDetailsPage(),
      },
    );
  }
}
