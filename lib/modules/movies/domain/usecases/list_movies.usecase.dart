import 'package:fpdart/fpdart.dart';

import 'package:plus_movies/core/domain/errors/errors.dart';
import 'package:plus_movies/modules/movies/domain/entities/movie.entity.dart';
import 'package:plus_movies/modules/movies/domain/protocols/protocols.dart';

abstract class ListMoviesUsecase {
  final MoviesRepository networkRepository;
  final MoviesRepository cacheRepository;

  ListMoviesUsecase({
    required this.networkRepository,
    required this.cacheRepository,
  });

  Future<Either<CoreError, List<Movie>>> call();
}
