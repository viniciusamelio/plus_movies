import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kiwi/kiwi.dart';
import 'package:plus_movies/core/external/dio/dio.dart';
import 'package:plus_movies/core/infra/services/cache.service.dart';
import 'package:plus_movies/core/infra/services/dio.service.dart';
import 'package:plus_movies/core/infra/services/get_storage.service.dart';
import 'package:plus_movies/core/infra/services/http.service.dart';
import 'package:plus_movies/env.dart';
import 'package:plus_movies/modules/movies/domain/protocols/protocols.dart';
import 'package:plus_movies/modules/movies/domain/usecases/list_movies.usecase.dart';
import 'package:plus_movies/modules/movies/infra/repositories/cache_movies.repository.dart';
import 'package:plus_movies/modules/movies/infra/repositories/http_movies.repository.dart';
import 'package:plus_movies/modules/movies/presentation/stores/movie_list.store.dart';

KiwiContainer movieListStoreContainer = KiwiContainer()
  ..registerFactory(
    (container) => BaseOptions(
      baseUrl: movieDBBaseUrl,
    ),
  )
  ..registerFactory(
    (container) => CustomDio(
      container.resolve(),
    ),
  )
  ..registerFactory<HttpService>(
    (container) => DioService(
      container.resolve(),
    ),
    name: "DioService",
  )
  ..registerFactory<MoviesRepository>(
    (container) => HttpMoviesRepository(
      container.resolve("DioService"),
    ),
    name: "HttpMoviesRepository",
  )
  ..registerFactory<GetStorage>(
    (container) => GetStorage(),
  )
  ..registerFactory<CacheService>(
    (container) => GetStorageService(
      container.resolve(),
    ),
  )
  ..registerFactory<MoviesRepository>(
    (container) => CacheMoviesRepository(
      container.resolve(),
    ),
    name: "CacheMoviesRepository",
  )
  ..registerFactory<ListMoviesUsecase>(
    (container) => ListMovies(
      networkMoviesRepository: container.resolve("HttpMoviesRepository"),
      cacheMoviesRepository: container.resolve("CacheMoviesRepository"),
    ),
    name: "ListMovies",
  )
  ..registerFactory(
    (container) => MovieListStore(
      container.resolve("ListMovies"),
    ),
  );
