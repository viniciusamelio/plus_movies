import 'package:mobx/mobx.dart';
import 'package:plus_movies/modules/movies/presentation/presenters/movie_list.presenter.dart';
part 'movie_list.store.g.dart';

class MovieListStore = _MovieListStoreBase with _$MovieListStore;

abstract class _MovieListStoreBase with Store implements MovieListPresenter {
  @override
  @observable
  int selectedGenreIndex = 0;

  @override
  int maxIndex = 3;

  @override
  @action
  void selectGenre(int index) {
    if (index <= maxIndex) selectedGenreIndex = index;
  }
}
