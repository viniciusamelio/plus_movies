import 'package:plus_movies/modules/movies/domain/usecases/list_movies.usecase.dart';

abstract class MovieListPresenter {
  MovieListPresenter(this.listMoviesUsecase);
  int selectedGenreIndex = 0;
  int maxIndex = 3;
  void selectGenre(int index);
  final ListMoviesUsecase listMoviesUsecase;
  dynamic listMovies();
}
