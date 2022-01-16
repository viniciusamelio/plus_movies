import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:plus_movies/modules/movies/presentation/presenters/movie_list.presenter.dart';
import 'package:plus_movies/modules/movies/presentation/stores/movie_list.store.dart';
import 'package:plus_movies/modules/movies/presentation/widgets/molecules/genre_label.widget.dart';

class GenreFilterOrganism extends StatelessWidget {
  const GenreFilterOrganism({
    Key? key,
    required MovieListStore movieListPresenter,
  })  : _movieListPresenter = movieListPresenter,
        super(key: key);

  final MovieListPresenter _movieListPresenter;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GenreLabelMolecule(
            title: "Ação",
            onTap: () => _movieListPresenter.selectGenre(0),
            isSelected: _movieListPresenter.selectedGenreIndex == 0,
          ),
          GenreLabelMolecule(
            title: "Aventura",
            onTap: () => _movieListPresenter.selectGenre(1),
            isSelected: _movieListPresenter.selectedGenreIndex == 1,
          ),
          GenreLabelMolecule(
            title: "Fantasia",
            onTap: () => _movieListPresenter.selectGenre(2),
            isSelected: _movieListPresenter.selectedGenreIndex == 2,
          ),
          GenreLabelMolecule(
            title: "Comédia",
            onTap: () => _movieListPresenter.selectGenre(3),
            isSelected: _movieListPresenter.selectedGenreIndex == 3,
          ),
        ],
      );
    });
  }
}
