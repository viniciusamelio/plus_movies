import 'package:fpdart/fpdart.dart';
import 'package:mobx/mobx.dart';
import 'package:plus_movies/core/domain/errors/errors.dart';
import 'package:plus_movies/modules/movies/domain/entities/entities.dart';
import 'package:plus_movies/modules/movies/domain/usecases/list_movies.usecase.dart';
import 'package:plus_movies/modules/movies/presentation/presenters/movie_list.presenter.dart';
part 'movie_list.store.g.dart';

class MovieListStore = _MovieListStoreBase with _$MovieListStore;

abstract class _MovieListStoreBase with Store implements MovieListPresenter {
  _MovieListStoreBase(this.listMoviesUsecase) {
    listMovies();
  }

  @override
  final ListMoviesUsecase listMoviesUsecase;

  @override
  @observable
  int selectedGenreIndex = 0;

  @observable
  ObservableFuture<Either<CoreError, List<Movie>>>? listMoviesReaction;

  @observable
  ObservableList<Movie> movies = <Movie>[].asObservable();

  @override
  int maxIndex = 3;

  @observable
  String selectedGenre = "Ação";

  List<String> genres = [
    "Ação",
    "Aventura",
    "Fantasia",
    "Comédia",
  ];

  @override
  @action
  void selectGenre(int index) {
    if (index <= maxIndex) {
      selectedGenreIndex = index;
      selectedGenre = genres[index];
    }
  }

  @override
  @action
  void listMovies({bool useCache = true}) {
    listMoviesReaction =
        listMoviesUsecase.call(useCache: useCache).asObservable();
  }
}
