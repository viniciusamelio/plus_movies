import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobx/mobx.dart';

import 'package:plus_movies/env.dart';
import 'package:plus_movies/core/external/dio/dio.dart';
import 'package:plus_movies/core/infra/services/dio.service.dart';
import 'package:plus_movies/core/infra/services/get_storage.service.dart';
import 'package:plus_movies/core/presentation/styles/colors.dart';
import 'package:plus_movies/modules/movies/domain/usecases/list_movies.usecase.dart';
import 'package:plus_movies/modules/movies/infra/repositories/cache_movies.repository.dart';
import 'package:plus_movies/modules/movies/infra/repositories/http_movies.repository.dart';
import 'package:plus_movies/modules/movies/presentation/stores/movie_list.store.dart';
import 'package:plus_movies/modules/movies/presentation/widgets/molecules/molecules.dart';
import 'package:plus_movies/modules/movies/presentation/widgets/organisms/genre_filter.widget.dart';

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
                    onChanged: (e) {},
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
              GenreFilterOrganism(
                movieListPresenter: _movieListPresenter,
              ),
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
                      (movie) {
                        final elementsMatching = movie.genres.where(
                          (genre) =>
                              genre.name == _movieListPresenter.selectedGenre,
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
