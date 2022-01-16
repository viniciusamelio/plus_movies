import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobx/mobx.dart';

import 'package:plus_movies/core/external/dio/dio.dart';
import 'package:plus_movies/core/infra/services/dio.service.dart';
import 'package:plus_movies/core/infra/services/get_storage.service.dart';
import 'package:plus_movies/core/presentation/styles/colors.dart';
import 'package:plus_movies/env.dart';
import 'package:plus_movies/modules/movies/domain/entities/entities.dart';
import 'package:plus_movies/modules/movies/domain/usecases/list_movies.usecase.dart';
import 'package:plus_movies/modules/movies/infra/repositories/cache_movies.repository.dart';
import 'package:plus_movies/modules/movies/infra/repositories/http_movies.repository.dart';
import 'package:plus_movies/modules/movies/presentation/stores/movie_list.store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  late final MovieListStore _movieListPresenter;
  late final TextEditingController _searchBarController;
  late final ReactionDisposer _movieListReactionDisposer;
  late final ReactionDisposer _updateMoviesCacheReactionDisposer;

  @override
  void initState() {
    _movieListPresenter = MovieListStore(
      ListMovies(
        cacheMoviesRepository: CacheMoviesRepository(
          GetStorageService(
            GetStorage(),
          ),
        ),
        networkMoviesRepository: HttpMoviesRepository(
          DioService(
            CustomDio(BaseOptions(
              baseUrl: movieDBBaseUrl,
            )),
          ),
        ),
      ),
    );
    _searchBarController = TextEditingController();
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
    super.initState();
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
              Column(
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
                    controller: _searchBarController,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
              Observer(builder: (_) {
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
              }),
              const SizedBox(
                height: 40,
              ),
              Observer(builder: (_) {
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
                    final filteredMovies = _movieListPresenter.movies.where(
                      (element) {
                        final elementsMatching = element.genres.where(
                          (element) =>
                              element.name == _movieListPresenter.selectedGenre,
                        );
                        return elementsMatching.isNotEmpty;
                      },
                    ).toList();
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
                          // primary: true,
                          itemCount: filteredMovies.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: MoviePosterMolecule(
                              movie: filteredMovies[index],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class SearchBarMolecule extends StatelessWidget {
  final TextEditingController controller;
  const SearchBarMolecule({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        label: const Text("Pesquise filmes"),
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w400,
        ),
        isDense: true,
        prefixIcon: GestureDetector(
          child: const Icon(
            Icons.search,
            size: 18,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 38,
          minHeight: 28,
        ),
      ),
    );
  }
}

class MoviePosterMolecule extends StatelessWidget {
  final Movie movie;
  const MoviePosterMolecule({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String movieGenres = movie.genres
        .map((e) => e.name + " - ")
        .toString()
        .replaceAll("(", "")
        .replaceAll(")", "")
        .replaceAll(",", "");
    movieGenres = movieGenres.substring(0, movieGenres.length - 2);
    return Container(
      height: MediaQuery.of(context).size.height * .62,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(
            "$movieDBImageBaseUrl${movie.posterPath}",
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 162,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Colors.black.withOpacity(.4),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    movieGenres,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class GenreLabelMolecule extends StatelessWidget {
  final String title;
  final Function onTap;
  final bool isSelected;
  const GenreLabelMolecule(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          border: Border.all(
            color: gray08,
          ),
          color: isSelected
              ? Theme.of(context).colorScheme.secondary
              : Colors.white,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: isSelected
                ? Theme.of(context).colorScheme.onSecondary
                : Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
