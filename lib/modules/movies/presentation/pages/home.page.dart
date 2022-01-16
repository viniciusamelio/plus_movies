import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'package:plus_movies/core/presentation/styles/colors.dart';
import 'package:plus_movies/modules/movies/di/containers.dart';
import 'package:plus_movies/modules/movies/presentation/stores/movie_list.store.dart';
import 'package:plus_movies/modules/movies/presentation/widgets/molecules/molecules.dart';
import 'package:plus_movies/modules/movies/presentation/widgets/organisms/genre_filter.widget.dart';
import 'package:plus_movies/modules/movies/presentation/widgets/organisms/movies_list.widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  late final MovieListStore _movieListPresenter;

  late final ReactionDisposer _movieListReactionDisposer;
  late final ReactionDisposer _updateMoviesCacheReactionDisposer;

  @override
  void initState() {
    _movieListPresenter = movieListStoreContainer();
    _initReactions();
    super.initState();
  }

  void _initReactions() {
    _movieListReactionDisposer =
        reaction((_) => _movieListPresenter.listMoviesReaction?.status, (_) {
      if (_movieListPresenter.listMoviesReaction?.status ==
          FutureStatus.fulfilled) {
        _movieListPresenter.movies = _movieListPresenter
            .listMoviesReaction!.value!
            .getOrElse((l) => [])
            .asObservable();
        _movieListPresenter.selectGenre(0);
        _movieListPresenter.updateMoviesCache();
      }
    });

    _updateMoviesCacheReactionDisposer = reaction(
        (_) => _movieListPresenter.updateMoviesCacheReaction?.status, (_) {
      if (_movieListPresenter.updateMoviesCacheReaction?.status ==
          FutureStatus.fulfilled) {
        _movieListPresenter.movies = _movieListPresenter
            .listMoviesReaction!.value!
            .getOrElse((l) => [])
            .asObservable();
      }
    });
  }

  @override
  void dispose() {
    _movieListReactionDisposer();
    _updateMoviesCacheReactionDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Filmes",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: gray01,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              SearchBarMolecule(
                store: _movieListPresenter,
              ),
              const SizedBox(
                height: 16,
              ),
              GenreFilterOrganism(
                movieListPresenter: _movieListPresenter,
              ),
              const SizedBox(
                height: 40,
              ),
              MoviesListOrganism(movieListPresenter: _movieListPresenter)
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
