import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:plus_movies/core/presentation/styles/colors.dart';
import 'package:plus_movies/modules/movies/domain/entities/entities.dart';
import 'package:plus_movies/modules/movies/presentation/stores/movie_list.store.dart';
import 'package:plus_movies/modules/movies/presentation/widgets/molecules/molecules.dart';

class MoviesListOrganism extends StatelessWidget {
  const MoviesListOrganism({
    Key? key,
    required MovieListStore movieListPresenter,
  })  : _movieListPresenter = movieListPresenter,
        super(key: key);

  final MovieListStore _movieListPresenter;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (_movieListPresenter.listMoviesReaction == null ||
          _movieListPresenter.listMoviesReaction?.status ==
              FutureStatus.pending) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        );
      }
      return _movieListPresenter.listMoviesReaction!.value!.match(
        (l) => Text(l.message),
        (movies) {
          final filteredMovies = _getFilteredMovies();
          return Expanded(
            child: RefreshIndicator(
              color: darkGreen01,
              onRefresh: () async {
                _movieListPresenter.updateMoviesCache();
                await _movieListPresenter.updateMoviesCacheReaction!
                    .whenComplete(() => null);
              },
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: filteredMovies.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Hero(
                    tag: "poster-${filteredMovies[index].id}",
                    child: MoviePosterMolecule(
                      movie: filteredMovies[index],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }

  List<Movie> _getFilteredMovies() {
    return _movieListPresenter.movies.where(
      (movie) {
        final elementsMatching = movie.genres.where(
          (genre) => genre.name == _movieListPresenter.selectedGenre,
        );
        return elementsMatching.isNotEmpty;
      },
    ).toList();
  }
}
